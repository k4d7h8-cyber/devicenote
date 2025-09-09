import 'dart:convert';
import 'package:devicenote/data/models/device.dart';
import 'package:devicenote/data/sources/hive_boxes.dart';

class BackupRepository {
  /// 모든 데이터를 JSON 문자열로 내보내기
  String exportToJson() {
    final devices = HiveBoxes.devices.values.map((e) => e.toMap()).toList();
    final map = {
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'devices': devices,
    };
    return const JsonEncoder.withIndent('  ').convert(map);
  }

  /// JSON 문자열에서 복원(병합: id 기준 덮어쓰기)
  /// return: (added, updated, failed)
  Future<(int added, int updated, int failed)> importFromJson(String jsonStr) async {
    int added = 0, updated = 0, failed = 0;
    try {
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      final list = (map['devices'] as List?) ?? const [];
      for (final item in list) {
        try {
          final d = Device.fromMap(Map<String, dynamic>.from(item));
          final exists = HiveBoxes.devices.containsKey(d.id);
          await HiveBoxes.devices.put(d.id, d);
          if (exists) {
            updated++;
          } else {
            added++;
          }
        } catch (_) {
          failed++;
        }
      }
      return (added, updated, failed);
    } catch (_) {
      return (0, 0, -1);
    }
  }
}
