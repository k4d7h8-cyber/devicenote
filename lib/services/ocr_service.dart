import 'dart:async';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

/// Wraps ML Kit text recognition to extract textual content from a single image.
class OcrService {
  OcrService({TextRecognizer? textRecognizer})
    : _textRecognizer =
          textRecognizer ?? TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _textRecognizer;

  /// Processes [image] and returns a set of recognised text snippets (line level).
  Future<List<String>> recognizeCandidatesFromImage(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final recognised = await _textRecognizer.processImage(inputImage);

    final seen = <String>{};
    final lines = <String>[];

    void addIfNew(String? value) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) return;
      if (seen.add(trimmed)) {
        lines.add(trimmed);
      }
    }

    addIfNew(recognised.text);

    for (final block in recognised.blocks) {
      addIfNew(block.text);
      for (final line in block.lines) {
        addIfNew(line.text);
      }
    }

    return lines;
  }

  Future<void> dispose() async {
    await _textRecognizer.close();
  }
}
