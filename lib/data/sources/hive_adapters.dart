import 'package:hive/hive.dart';
import 'package:devicenote/data/models/enums.dart';
import 'package:devicenote/data/models/as_contact.dart';
import 'package:devicenote/data/models/device.dart';

/// Hive TypeAdapter 등록(수동)
void registerHiveAdapters() {
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(DeviceCategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(AsContactAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(DeviceAdapter());
  }
}

/* -------- DeviceCategory Adapter -------- */
class DeviceCategoryAdapter extends TypeAdapter<DeviceCategory> {
  @override
  final int typeId = 1;

  @override
  DeviceCategory read(BinaryReader reader) {
    final index = reader.readByte();
    return DeviceCategory.values[index];
  }

  @override
  void write(BinaryWriter writer, DeviceCategory obj) {
    writer.writeByte(obj.index);
  }
}

/* -------- AsContact Adapter -------- */
class AsContactAdapter extends TypeAdapter<AsContact> {
  @override
  final int typeId = 2;

  @override
  AsContact read(BinaryReader reader) {
    final name = reader.readString();
    final phone = reader.readString();
    final hasMemo = reader.readBool();
    final memo = hasMemo ? reader.readString() : null;
    return AsContact(name: name, phone: phone, memo: memo);
  }

  @override
  void write(BinaryWriter writer, AsContact obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.phone);
    writer.writeBool(obj.memo != null);
    if (obj.memo != null) writer.writeString(obj.memo!);
  }
}

/* -------- Device Adapter -------- */
class DeviceAdapter extends TypeAdapter<Device> {
  @override
  final int typeId = 3;

  @override
  Device read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final brand = reader.readString();
    final model = reader.readString();
    final category = DeviceCategory.values[reader.readByte()];
    final purchaseDate = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final warrantyExpiresAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final hasAs = reader.readBool();
    final asContact = hasAs ? (reader.read() as AsContact) : null;
    final photos = reader.readList().cast<String>();
    final receipts = reader.readList().cast<String>();
    final hasNotes = reader.readBool();
    final notes = hasNotes ? reader.readString() : null;
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final updatedAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());

    return Device(
      id: id,
      name: name,
      brand: brand,
      model: model,
      category: category,
      purchaseDate: purchaseDate,
      warrantyExpiresAt: warrantyExpiresAt,
      asContact: asContact,
      photos: photos,
      receipts: receipts,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  void write(BinaryWriter writer, Device obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.name)
      ..writeString(obj.brand)
      ..writeString(obj.model)
      ..writeByte(obj.category.index)
      ..writeInt(obj.purchaseDate.millisecondsSinceEpoch)
      ..writeInt(obj.warrantyExpiresAt.millisecondsSinceEpoch)
      ..writeBool(obj.asContact != null);
    if (obj.asContact != null) {
      writer.write(obj.asContact!);
    }
    writer
      ..writeList(obj.photos)
      ..writeList(obj.receipts)
      ..writeBool(obj.notes != null);
    if (obj.notes != null) {
      writer.writeString(obj.notes!);
    }
    writer
      ..writeInt(obj.createdAt.millisecondsSinceEpoch)
      ..writeInt(obj.updatedAt.millisecondsSinceEpoch);
  }
}
