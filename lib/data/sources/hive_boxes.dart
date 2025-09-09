import 'package:hive_flutter/hive_flutter.dart';
import 'package:devicenote/data/models/device.dart';
import 'package:devicenote/data/sources/hive_adapters.dart';

const _deviceBoxName = 'devices';

class HiveBoxes {
  static late Box<Device> devices;

  static Future<void> init() async {
    await Hive.initFlutter();
    registerHiveAdapters();
    devices = await Hive.openBox<Device>(_deviceBoxName);
  }
}
