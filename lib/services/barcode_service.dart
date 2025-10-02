import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/model_number_extract.dart';

class BarcodeResult {
  const BarcodeResult({
    this.rawValues = const [],
    this.urlCandidates = const [],
  });

  final List<String> rawValues;
  final List<String> urlCandidates;

  bool get hasCandidates => rawValues.isNotEmpty || urlCandidates.isNotEmpty;

  List<ScoredCandidate> toScoredCandidates() {
    final results = <ScoredCandidate>[];
    for (final value in urlCandidates) {
      final normalized = normalizeModelNumber(value);
      if (normalized.isEmpty || !isLikelyModelNumber(normalized)) {
        continue;
      }
      results.add(
        ScoredCandidate(
          value: normalized,
          score: 120,
          source: CandidateSource.qr,
        ),
      );
    }
    for (final value in rawValues) {
      final normalized = normalizeModelNumber(value);
      if (normalized.isEmpty || !isLikelyModelNumber(normalized)) {
        continue;
      }
      results.add(
        ScoredCandidate(
          value: normalized,
          score: 90,
          source: CandidateSource.barcode,
        ),
      );
    }
    return results;
  }
}

class BarcodeService {
  BarcodeService({BarcodeScanner? scanner})
    : _scanner = scanner ?? BarcodeScanner(formats: const [BarcodeFormat.all]);

  final BarcodeScanner _scanner;

  Future<BarcodeResult> scanFromImage(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final barcodes = await _scanner.processImage(inputImage);

    final rawValues = <String>{};
    final urlCandidates = <String>{};

    for (final barcode in barcodes) {
      final rawValue = barcode.rawValue?.trim();
      if (rawValue == null || rawValue.isEmpty) {
        continue;
      }

      rawValues.add(rawValue);

      final extracted = _extractFromUrl(rawValue);
      if (extracted != null && extracted.isNotEmpty) {
        urlCandidates.add(extracted);
      }
    }

    return BarcodeResult(
      rawValues: rawValues.toList(growable: false),
      urlCandidates: urlCandidates.toList(growable: false),
    );
  }

  String? _extractFromUrl(String rawUrl) {
    final uri = Uri.tryParse(rawUrl);
    if (uri == null) {
      return null;
    }

    const keys = [
      'model',
      'modelno',
      'modelnumber',
      'sku',
      'part',
      'partno',
      'partnumber',
      'partnum',
    ];

    final lowerParams = <String, String>{};
    uri.queryParameters.forEach((key, value) {
      lowerParams[key.toLowerCase()] = value;
    });

    for (final key in keys) {
      final value = lowerParams[key];
      if (value != null && isLikelyModelNumber(value)) {
        return normalizeModelNumber(value);
      }
    }

    final fragments = uri.fragment.split('&');
    for (final fragment in fragments) {
      final parts = fragment.split('=');
      if (parts.length != 2) {
        continue;
      }
      final key = parts.first.trim().toLowerCase();
      final value = parts.last.trim();
      if (keys.contains(key) && isLikelyModelNumber(value)) {
        return normalizeModelNumber(value);
      }
    }

    for (final segment in uri.pathSegments) {
      // ignore: valid_regexps
      final match = RegExp(
        r'(model|sku|part)[-_/:]?([A-Z0-9][-_/A-Z0-9]{4,28}[A-Z0-9])',
        caseSensitive: false,
      ).firstMatch(segment);
      if (match != null) {
        final candidate = match.group(2);
        if (candidate != null && isLikelyModelNumber(candidate)) {
          return normalizeModelNumber(candidate);
        }
      }
    }

    return null;
  }

  Future<void> dispose() async {
    await _scanner.close();
  }
}
