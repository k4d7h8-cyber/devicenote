import 'dart:io';

import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/features/camera/camera_capture_page.dart';
import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDevicePage extends StatefulWidget {
  final Device? existing;
  const AddDevicePage({super.key, this.existing});

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

  DeviceCategory? _category;
  DateTime? _purchaseDate;
  final List<String> _photos = [];

  String? _lastLocaleName;

  @override
  void initState() {
    super.initState();
    final d = widget.existing;
    if (d != null) {
      _nameCtrl.text = d.name;
      _brandCtrl.text = d.brand;
      _modelCtrl.text = d.model;
      _category = d.category;
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
      _purchaseDateCtrl.text =
          DateUtilsX.formatForLocale(_purchaseDate!, locale: localeName);
    }
    _lastLocaleName = localeName;
  }

  String _requiredLabel(String base) => '$base*';

  Future<void> _pickDate() async {
    final nowLocal = DateTime.now();
    final initialUtc = _purchaseDate ?? DateUtilsX.normalizeToUtcDate(nowLocal);
    final initialLocal = initialUtc.toLocal();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialLocal.isAfter(nowLocal) ? nowLocal : initialLocal,
      firstDate: DateTime(2000),
      lastDate: DateTime(nowLocal.year, nowLocal.month, nowLocal.day),
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

    if (widget.existing == null) {
      final id = const Uuid().v4();
      final device = Device(
        id: id,
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        model: _modelCtrl.text.trim(),
        category: _category!,
        purchaseDate: DateUtilsX.normalizeToUtcDate(_purchaseDate!),
        warrantyMonths: warranty,
        asContact: _phoneCtrl.text.trim().isEmpty
            ? null
            : _phoneCtrl.text.trim(),
        imagePaths: List.unmodifiable(_photos),
      );
      repo.add(device);
      await notifications.onDeviceSaved(device);
      if (!mounted) return;
    } else {
      final updated = widget.existing!.copyWith(
        name: _nameCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        model: _modelCtrl.text.trim(),
        category: _category!,
        purchaseDate: DateUtilsX.normalizeToUtcDate(_purchaseDate!),
        warrantyMonths: warranty,
        asContact: _phoneCtrl.text.trim().isEmpty
            ? null
            : _phoneCtrl.text.trim(),
        imagePaths: List.unmodifiable(_photos),
      );
      repo.update(updated);
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

  Future<void> _capturePhoto() async {
    final path = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const CameraCapturePage()),
    );
    if (path == null || !mounted) return;
    setState(() {
      if (!_photos.contains(path)) {
        _photos.add(path);
      }
    });
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    try {
      var selections = await picker.pickMultiImage();
      if (selections.isEmpty) {
        final single = await picker.pickImage(source: ImageSource.gallery);
        if (single == null) return;
        selections = [single];
      }

      final photosDir = await _ensurePhotosDirectory();
      final added = <String>[];

      for (final file in selections) {
        final saved = await _savePickedImage(file, photosDir);
        if (!_photos.contains(saved)) {
          added.add(saved);
        }
      }

      if (added.isEmpty || !mounted) return;
      setState(() => _photos.addAll(added));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.addDevicePickImagesError(e.toString()),
          ),
        ),
      );
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

  Future<String> _savePickedImage(XFile file, Directory targetDir) async {
    final extIndex = file.name.lastIndexOf('.');
    final ext = extIndex >= 0 ? file.name.substring(extIndex) : '';
    final filename =
        'gallery_${DateTime.now().toUtc().millisecondsSinceEpoch}_${const Uuid().v4()}$ext';
    final destination = File('${targetDir.path}/$filename');
    final saved = await File(file.path).copy(destination.path);
    return saved.path;
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
                    child: DropdownButtonFormField<DeviceCategory>(
                      value: _category,
                      decoration: InputDecoration(
                        labelText: _requiredLabel(l10n.addDeviceCategoryLabel),
                        border: const OutlineInputBorder(),
                      ),
                      items: DeviceCategory.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(_categoryLabel(l10n, c)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _category = value),
                      validator: (value) =>
                          value == null ? l10n.addDeviceCategoryRequired : null,
                    ),
                  ),
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
                    child: TextFormField(
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
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: singleWidth,
                    child: TextFormField(
                      controller: _purchaseDateCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: _requiredLabel(
                          l10n.addDevicePurchaseDateLabel,
                        ),
                        hintText: l10n.addDevicePurchaseDateHint,
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: const OutlineInputBorder(),
                      ),
                      onTap: _pickDate,
                      validator: (_) {
                        if (_purchaseDate == null) {
                          return l10n.addDevicePurchaseDateRequired;
                        }
                        final nowUtc = DateTime.now().toUtc();
                        final todayUtc = DateTime.utc(
                          nowUtc.year,
                          nowUtc.month,
                          nowUtc.day,
                        );
                        if (_purchaseDate!.isAfter(todayUtc)) {
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
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
                        border: OutlineInputBorder(),
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
              const SizedBox(height: 20),
              Text(
                l10n.addDeviceOthersSectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: _capturePhoto,
                    icon: const Icon(Icons.photo_camera),
                    label: Text(l10n.addDeviceTakePhoto),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: Text(l10n.addDeviceSelectFromGallery),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_photos.isNotEmpty)
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

  String _categoryLabel(AppLocalizations l10n, DeviceCategory c) {
    switch (c) {
      case DeviceCategory.tv:
        return l10n.categoryTv;
      case DeviceCategory.washer:
        return l10n.categoryWasher;
      case DeviceCategory.computer:
        return l10n.categoryComputer;
      case DeviceCategory.refrigerator:
        return l10n.categoryRefrigerator;
      case DeviceCategory.aircon:
        return l10n.categoryAirConditioner;
      case DeviceCategory.car:
        return l10n.categoryCar;
      case DeviceCategory.etc:
        return l10n.categoryOthers;
    }
  }
}
