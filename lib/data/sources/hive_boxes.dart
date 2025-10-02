import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static const String deviceBoxName = 'devices';

  static late Box<Device> devices;

  static Future<void> init({Box<Device>? preOpened}) async {
    if (preOpened != null) {
      devices = preOpened;
      return;
    }

    if (Hive.isBoxOpen(deviceBoxName)) {
      devices = Hive.box<Device>(deviceBoxName);
    } else {
      devices = await Hive.openBox<Device>(deviceBoxName);
    }
  }
}
