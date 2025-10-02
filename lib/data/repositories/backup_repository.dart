import 'dart:convert';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/data/sources/hive_boxes.dart';

class BackupRepository {
  /// 紐⑤뱺 ?곗씠?곕? JSON 臾몄옄?대줈 ?대낫?닿린
  String exportToJson() {
    final devices = HiveBoxes.devices.values.map((e) => e.toMap()).toList();
    final map = {
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'devices': devices,
    };
    return const JsonEncoder.withIndent('  ').convert(map);
  }

  /// JSON 臾몄옄?댁뿉??蹂듭썝(蹂묓빀: id 湲곗? ??뼱?곌린)
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
