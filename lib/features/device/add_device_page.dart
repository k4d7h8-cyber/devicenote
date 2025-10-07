import 'dart:async';
import 'dart:io';

import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/l10n/app_localizations_extensions.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/barcode_service.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:devicenote/services/ocr_service.dart';
import 'package:devicenote/utils/model_number_extract.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDevicePage extends StatefulWidget {
  final Device? existing;
  final DeviceCategory? initialCategory;
  const AddDevicePage({super.key, this.existing, this.initialCategory});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _modelCtrl = TextEditingController();
  final _purchaseDateCtrl = TextEditingController();
  final _warrantyCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final OcrService _ocrService = OcrService();
  final BarcodeService _barcodeService = BarcodeService();

  DateTime? _purchaseDate;
  final List<String> _photos = [];

  bool _isProcessingImage = false;
  List<ScoredCandidate> _lastCandidates = const [];

  String? _lastLocaleName;

  bool get _isMobilePlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    final d = widget.existing;
    if (d != null) {
      _nameCtrl.text = d.name;
      _brandCtrl.text = d.brand;
      _modelCtrl.text = d.model;
      _purchaseDate = d.purchaseDate;
      _purchaseDateCtrl.text = DateUtilsX.formatForLocale(d.purchaseDate);
      _warrantyCtrl.text = d.warrantyMonths.toString();
      _phoneCtrl.text = d.asContact ?? '';
      _photos.addAll(d.imagePaths);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _brandCtrl.dispose();
    _modelCtrl.dispose();
    _purchaseDateCtrl.dispose();
    _warrantyCtrl.dispose();
    _phoneCtrl.dispose();
    unawaited(_ocrService.dispose());
    unawaited(_barcodeService.dispose());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeName = AppLocalizations.of(context)?.localeName;
    if (localeName == null) {
      return;
    }
    if (_lastLocaleName == localeName) {
      return;
    }
    if (_purchaseDate != null) {
      _purchaseDateCtrl.text = DateUtilsX.formatForLocale(
        _purchaseDate!,
        locale: localeName,
      );
    }
    _lastLocaleName = localeName;
  }

  String _requiredLabel(String base) => '$base*';

  Future<void> _pickDate() async {
    final nowLocal = DateTime.now();
    final initialUtc = _purchaseDate ?? DateUtilsX.normalizeToUtcDate(nowLocal);
    final initialLocal = initialUtc.toLocal();
    final l10n = AppLocalizations.of(context)!;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialLocal.isAfter(nowLocal) ? nowLocal : initialLocal,
      firstDate: DateTime(2000),
      lastDate: DateTime(nowLocal.year, nowLocal.month, nowLocal.day),
      locale: l10n.locale,
    );
    if (picked == null) {
      return;
    }
    if (!mounted) return;
    final localeName = AppLocalizations.of(context)?.localeName;
    final normalized = DateUtilsX.normalizeToUtcDate(picked);
    setState(() {
      _purchaseDate = normalized;
      _purchaseDateCtrl.text = DateUtilsX.formatForLocale(
        normalized,
        locale: localeName,
      );
      _lastLocaleName = localeName;
    });
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final repo = context.read<DeviceRepository>();
    final notifications = context.read<NotificationController>();
    final warranty = int.parse(_warrantyCtrl.text);
    final category =
        widget.existing?.category ?? widget.initialCategory ?? DeviceCategory.etc;

    if (widget.existing == null) {
      final id = const Uuid().v4();
      final device = Device(
        id: id,
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        model: _modelCtrl.text.trim(),
        category: category,
        purchaseDate: DateUtilsX.normalizeToUtcDate(_purchaseDate!),
        warrantyMonths: warranty,
        asContact: _phoneCtrl.text.trim().isEmpty
            ? null
            : _phoneCtrl.text.trim(),
        photoFileNames: List.unmodifiable(_photos),
      );
      await repo.add(device);
      await notifications.onDeviceSaved(device);
      if (!mounted) return;
    } else {
      final updated = widget.existing!.copyWith(
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        model: _modelCtrl.text.trim(),
        purchaseDate: DateUtilsX.normalizeToUtcDate(_purchaseDate!),
        warrantyMonths: warranty,
        asContact: _phoneCtrl.text.trim().isEmpty
            ? null
            : _phoneCtrl.text.trim(),
        photoFileNames: List.unmodifiable(_photos),
      );
      await repo.update(updated);
      await notifications.onDeviceSaved(updated);
      if (!mounted) return;
    }

    final snack = SnackBar(
      content: Text(AppLocalizations.of(context)!.addDeviceSavedMessage),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (mounted) Navigator.of(context).pop();
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  Future<void> _handleTakePhoto() async {
    if (!_isMobilePlatform) {
      _showMessage('Image scanning is available on Android/iOS only.');
      return;
    }

    final source = await _showImageSourceSelector();
    if (source == null) {
      return;
    }

    final granted = await _ensurePermission(source);
    if (!granted) {
      return;
    }

    XFile? image;
    try {
      image = await _picker.pickImage(source: source);
    } catch (e) {
      _showMessage('Failed to pick image: $e');
      return;
    }

    if (image == null) {
      _showMessage('No image selected.');
      return;
    }

    await _processImageForModelNumber(image);
    await _cacheImage(image);
  }


  Future<void> _handleImportPhoto() async {
    try {
      if (_isMobilePlatform) {
        final granted = await _ensurePermission(ImageSource.gallery);
        if (!granted) {
          return;
        }
        final images = await _picker.pickMultiImage();
        if (images.isEmpty) {
          return;
        }
        for (final image in images) {
          await _cacheImage(image);
        }
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (result == null || result.files.isEmpty) {
        return;
      }
      for (final file in result.files) {
        final path = file.path;
        if (path == null) {
          continue;
        }
        await _cacheImageFromPath(path, originalName: file.name);
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context);
      final message = l10n != null
          ? l10n.addDevicePickImagesError('$e')
          : 'Failed to pick images: $e';
      _showMessage(message);
    }
  }

  Future<void> _processImageForModelNumber(XFile image) async {
    if (!mounted) return;
    setState(() {
      _isProcessingImage = true;
    });

    try {
      final ocrFuture = _ocrService.recognizeCandidatesFromImage(image);
      final barcodeFuture = _barcodeService.scanFromImage(image);

      final recognizedLines = await ocrFuture;
      final barcodeResult = await barcodeFuture;

      final ocrCandidates = extractAndScore(recognizedLines.join('\n'));
      final merged = _mergeCandidates(
        barcodeResult.toScoredCandidates(),
        ocrCandidates,
      );

      if (!mounted) return;

      if (merged.isEmpty) {
        _showMessage(
          'Could not detect a model number. Please enter it manually.',
        );
        setState(() {
          _lastCandidates = const [];
        });
        return;
      }

      setState(() {
        _lastCandidates = merged;
      });

      _updateModelField(merged.first.value);

      if (merged.length > 1 && mounted) {
        final selected = await _showCandidatePicker(merged);
        if (selected != null) {
          _updateModelField(selected.value);
        }
      }
    } catch (e) {
      _showMessage('Failed to process image: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingImage = false;
        });
      }
    }
  }

  List<ScoredCandidate> _mergeCandidates(
    List<ScoredCandidate> barcodeCandidates,
    List<ScoredCandidate> ocrCandidates,
  ) {
    final seen = <String, ScoredCandidate>{};

    void addAll(Iterable<ScoredCandidate> source) {
      for (final candidate in source) {
        final key = candidate.value;
        final existing = seen[key];
        if (existing == null) {
          seen[key] = candidate;
        } else {
          final higherScore = existing.score >= candidate.score
              ? existing.score
              : candidate.score;
          final preferredSource =
              existing.source == CandidateSource.ocr &&
                  candidate.source != CandidateSource.ocr
              ? candidate.source
              : existing.source;
          seen[key] = existing.copyWith(
            score: higherScore,
            source: preferredSource,
          );
        }
      }
    }

    addAll(barcodeCandidates);
    addAll(ocrCandidates);

    final merged = seen.values.toList()
      ..sort((a, b) => b.score.compareTo(a.score));
    return merged;
  }

  Future<ImageSource?> _showImageSourceSelector() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Use camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Pick from gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(AppLocalizations.of(context)!.commonCancel),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _ensurePermission(ImageSource source) async {
    if (!_isMobilePlatform) return false;

    if (source == ImageSource.camera) {
      return _requestPermission(
        Permission.camera,
        deniedMessage: 'Camera permission is required to capture a photo.',
      );
    }

    if (Platform.isIOS) {
      return _requestPermission(
        Permission.photos,
        deniedMessage: 'Photo library permission is required to pick an image.',
      );
    }

    // Android gallery access
    final photosGranted = await _requestPermission(
      Permission.photos,
      deniedMessage: 'Photo access is required to choose an image.',
      suppressMessage: true,
    );
    if (photosGranted) {
      return true;
    }

    return _requestPermission(
      Permission.storage,
      deniedMessage: 'Storage permission is required to choose an image.',
    );
  }

  Future<bool> _requestPermission(
    Permission permission, {
    required String deniedMessage,
    bool suppressMessage = false,
  }) async {
    final status = await permission.request();
    if (status.isGranted || status.isLimited) {
      return true;
    }

    if (!suppressMessage) {
      if (status.isPermanentlyDenied) {
        _showMessage('$deniedMessage Please enable it in system settings.');
        await openAppSettings();
      } else {
        _showMessage(deniedMessage);
      }
    }
    return false;
  }

  Future<ScoredCandidate?> _showCandidatePicker(
    List<ScoredCandidate> candidates,
  ) {
    return showModalBottomSheet<ScoredCandidate>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Choose detected model number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (final candidate in candidates)
                ListTile(
                  title: Text(candidate.value),
                  subtitle: Text(_sourceLabel(candidate.source)),
                  onTap: () => Navigator.of(context).pop(candidate),
                ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Dismiss'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _sourceLabel(CandidateSource source) {
    switch (source) {
      case CandidateSource.qr:
        return 'QR code';
      case CandidateSource.barcode:
        return 'Barcode';
      case CandidateSource.ocr:
        return 'OCR text';
    }
  }

  void _updateModelField(String value) {
    final normalized = normalizeModelNumber(value);
    _modelCtrl.text = normalized;
    _modelCtrl.selection = TextSelection.collapsed(offset: normalized.length);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _cacheImage(XFile file) async {
    await _cacheImageFromPath(file.path, originalName: file.name);
  }

  Future<void> _cacheImageFromPath(String path, {String? originalName}) async {
    await _storeAndAddImage(path, originalName: originalName);
  }

  Future<void> _storeAndAddImage(String sourcePath, {String? originalName}) async {
    try {
      final photosDir = await _ensurePhotosDirectory();
      final saved = await _saveImageFromPath(
        sourcePath,
        photosDir,
        originalName: originalName,
      );
      if (!mounted) return;
      if (!_photos.contains(saved)) {
        setState(() {
          _photos.add(saved);
        });
      }
    } catch (e) {
      _showMessage('Failed to store image: $e');
    }
  }

  Future<Directory> _ensurePhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${appDir.path}/photos');
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir;
  }

  Future<String> _saveImageFromPath(
    String sourcePath,
    Directory targetDir, {
    String? originalName,
  }) async {
    final ext = _extensionOf(originalName ?? sourcePath);
    final filename =
        'capture_${DateTime.now().toUtc().millisecondsSinceEpoch}_${const Uuid().v4()}$ext';
    final destination = File('${targetDir.path}/$filename');
    final saved = await File(sourcePath).copy(destination.path);
    return saved.path;
  }

  String _extensionOf(String value) {
    final dotIndex = value.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == value.length - 1) {
      return '';
    }
    return value.substring(dotIndex);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final l10n = AppLocalizations.of(context)!;
    return ResponsiveScaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.addDeviceEditTitle : l10n.addDeviceCreateTitle,
        ),
      ),
      builder: (context, layout) {
        final fullWidth = layout.columnWidth(span: layout.columns);
        final twoSpanWidth = layout.columnWidth(span: 2);
        final singleWidth = layout.columnWidth();
        const double fieldSpacing = 12;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: layout.gutter,
                runSpacing: fieldSpacing,
                children: [
                  SizedBox(
                    width: fullWidth,
                    child: TextFormField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(
                        labelText: _requiredLabel(l10n.addDeviceModelNameLabel),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.addDeviceModelNameRequired;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: singleWidth,
                    child: TextFormField(
                      controller: _brandCtrl,
                      decoration: InputDecoration(
                        labelText: _requiredLabel(l10n.addDeviceBrandLabel),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.addDeviceBrandRequired;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: singleWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _modelCtrl,
                          decoration: InputDecoration(
                            labelText: _requiredLabel(
                              l10n.addDeviceModelNumberLabel,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return l10n.addDeviceModelNumberRequired;
                            }
                            if (!isLikelyModelNumber(v)) {
                              return 'Enter a valid model number (A-Z, 0-9, -_/ only).';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _isMobilePlatform && !_isProcessingImage
                              ? _handleTakePhoto
                              : (_isMobilePlatform
                                    ? null
                                    : () => _showMessage(
                                        'Image scanning is available on Android/iOS only.',
                                      )),
                          icon: _isProcessingImage
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.camera_alt_outlined),
                          label: Text(
                            _isProcessingImage
                                ? 'Processing...'
                                : l10n.addDeviceTakePhoto,
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _isProcessingImage ? null : _handleImportPhoto,
                          icon: const Icon(Icons.photo_library_outlined),
                          label: Text(l10n.addDeviceSelectFromGallery),
                        ),
                        if (!_isMobilePlatform)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Model number scanning is supported on mobile apps only.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        if (_lastCandidates.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Auto-filled from ${_sourceLabel(_lastCandidates.first.source)}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_lastCandidates.length > 1)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () async {
                                final selected = await _showCandidatePicker(
                                  _lastCandidates,
                                );
                                if (selected != null) {
                                  _updateModelField(selected.value);
                                }
                              },
                              child: const Text('See other matches'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: singleWidth,
                    child: TextFormField(
                      controller: _purchaseDateCtrl,
                      readOnly: true,
                      onTap: _pickDate,
                      decoration: InputDecoration(
                        labelText: _requiredLabel(
                          l10n.addDevicePurchaseDateLabel,
                        ),
                        hintText: l10n.addDevicePurchaseDateHint,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _pickDate,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.addDevicePurchaseDateRequired;
                        }
                        final parsed = _purchaseDate;
                        if (parsed == null) {
                          return l10n.addDevicePurchaseDateRequired;
                        }
                        final now = DateTime.now().toUtc();
                        if (parsed.isAfter(now)) {
                          return l10n.addDevicePurchaseDateFutureError;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: singleWidth,
                    child: TextFormField(
                      controller: _warrantyCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: _requiredLabel(l10n.addDeviceWarrantyLabel),
                        hintText: l10n.addDeviceWarrantyHint,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.addDeviceWarrantyRequired;
                        }
                        final n = int.tryParse(v);
                        if (n == null) return l10n.addDeviceDigitsOnly;
                        if (n < 0 || n > 120) {
                          return l10n.addDeviceWarrantyRange;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: twoSpanWidth,
                    child: TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                      ],
                      decoration: InputDecoration(
                        labelText: l10n.addDeviceCustomerCenterLabel,
                        hintText: l10n.addDeviceCustomerCenterHint,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return null;
                        final ok = RegExp(r'^[0-9-]+$').hasMatch(v.trim());
                        if (!ok) return l10n.addDeviceCustomerCenterInvalid;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              if (_photos.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  l10n.addDeviceOthersSectionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _photos
                      .map(
                        (p) => InputChip(
                          avatar: const Icon(Icons.image, size: 18),
                          label: SizedBox(
                            width: 160,
                            child: Text(
                              p.split(Platform.pathSeparator).last,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onDeleted: () => setState(() => _photos.remove(p)),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onSave,
                      child: Text(l10n.commonSave),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _onCancel,
                      child: Text(l10n.commonCancel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}
