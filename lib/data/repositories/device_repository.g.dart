part of 'device_repository.dart';

class DeviceCategoryAdapter extends TypeAdapter<DeviceCategory> {
  @override
  final int typeId = 0;

  @override
  DeviceCategory read(BinaryReader reader) {
    final index = reader.readByte();
    if (index < 0 || index >= DeviceCategory.values.length) {
      return DeviceCategory.etc;
    }
    return DeviceCategory.values[index];
  }

  @override
  void write(BinaryWriter writer, DeviceCategory obj) {
    writer.writeByte(obj.index);
  }
}

class DeviceAdapter extends TypeAdapter<Device> {
  @override
  final int typeId = 1;

  @override
  Device read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }

    return Device(
      id: fields[0] as String,
      name: fields[2] as String,
      brand: fields[3] as String,
      model: fields[4] as String,
      category: fields[5] as DeviceCategory,
      purchaseDate: fields[6] as DateTime,
      warrantyMonths: fields[7] as int,
      asContact: fields[8] as String?,
      photoFileNames: (fields[1] as List?)?.cast<String>(),
      receiptFileNames: (fields[9] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Device obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.photoFileNames)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.brand)
      ..writeByte(4)
      ..write(obj.model)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.purchaseDate)
      ..writeByte(7)
      ..write(obj.warrantyMonths)
      ..writeByte(8)
      ..write(obj.asContact)
      ..writeByte(9)
      ..write(obj.receiptFileNames);
  }
}
