import 'dart:io';

/// 4단계 이후 ML Kit로 실제 구현 예정.
/// 지금은 형식만 맞춘 더미 서비스.
abstract class OcrService {
  Future<List<String>> extractModelCandidatesFromImage(File image);
}

class DummyOcrService implements OcrService {
  @override
  Future<List<String>> extractModelCandidatesFromImage(File image) async {
    // 실제 OCR 결과 대신 더미 후보 반환
    return ['MODEL-123', 'ABC-9000', 'Sample-X'];
  }
}
