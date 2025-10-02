import 'dart:collection';
import 'dart:math' as math;

import 'package:devicenote/core/utils/date_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'device_repository.g.dart';

@HiveType(typeId: 0)
enum DeviceCategory {
  @HiveField(0)
  tv,
  @HiveField(1)
  washer,
  @HiveField(2)
  computer,
  @HiveField(3)
  refrigerator,
  @HiveField(4)
  aircon,
  @HiveField(5)
  car,
  @HiveField(6)
  etc,
}

@HiveType(typeId: 1)
class Device extends HiveObject {
  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.category,
    required DateTime purchaseDate,
    required this.warrantyMonths,
    this.asContact,
    List<String>? photoFileNames,
    List<String>? receiptFileNames,
  }) : purchaseDate = DateUtilsX.normalizeToUtcDate(purchaseDate),
       photoFileNames = List.unmodifiable(photoFileNames ?? const []),
       receiptFileNames = List.unmodifiable(receiptFileNames ?? const []);

  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> photoFileNames;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String brand;

  @HiveField(4)
  final String model;

  @HiveField(5)
  final DeviceCategory category;

  @HiveField(6)
  final DateTime purchaseDate;

  @HiveField(7)
  final int warrantyMonths;

  @HiveField(8)
  final String? asContact;

  @HiveField(9)
  final List<String> receiptFileNames;

  List<String> get imagePaths => photoFileNames;
  List<String> get receiptPaths => receiptFileNames;

  Device copyWith({
    String? id,
    String? name,
    String? brand,
    String? model,
    DeviceCategory? category,
    DateTime? purchaseDate,
    int? warrantyMonths,
    String? asContact,
    List<String>? photoFileNames,
    List<String>? receiptFileNames,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      category: category ?? this.category,
      purchaseDate: purchaseDate != null
          ? DateUtilsX.normalizeToUtcDate(purchaseDate)
          : this.purchaseDate,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      asContact: asContact ?? this.asContact,
      photoFileNames: photoFileNames ?? this.photoFileNames,
      receiptFileNames: receiptFileNames ?? this.receiptFileNames,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'brand': brand,
    'model': model,
    'category': category.name,
    'purchaseDate': purchaseDate.toUtc().toIso8601String(),
    'warrantyMonths': warrantyMonths,
    'asContact': asContact,
    'photoFileNames': photoFileNames,
    'receiptFileNames': receiptFileNames,
  };

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      brand: map['brand'] as String? ?? '',
      model: map['model'] as String? ?? '',
      category: _parseCategory(map['category']),
      purchaseDate: _parseDate(map['purchaseDate']),
      warrantyMonths: (map['warrantyMonths'] as num?)?.toInt() ?? 0,
      asContact: map['asContact'] as String?,
      photoFileNames: (map['photoFileNames'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      receiptFileNames: (map['receiptFileNames'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  static DeviceCategory _parseCategory(dynamic value) {
    if (value is DeviceCategory) {
      return value;
    }
    if (value is int) {
      if (value >= 0 && value < DeviceCategory.values.length) {
        return DeviceCategory.values[value];
      }
    }
    if (value is String && value.isNotEmpty) {
      return DeviceCategory.values.firstWhere(
        (c) => c.name == value,
        orElse: () => DeviceCategory.etc,
      );
    }
    return DeviceCategory.etc;
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) {
      return DateUtilsX.normalizeToUtcDate(value);
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
    }
    if (value is String && value.isNotEmpty) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) {
        return DateUtilsX.normalizeToUtcDate(parsed);
      }
    }
    return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }
}

class DeviceRepository extends ChangeNotifier {
  DeviceRepository(this._box);

  final Box<Device> _box;

  UnmodifiableListView<Device> get devices =>
      UnmodifiableListView(_box.values.toList(growable: false));

  Device? findById(String id) => _box.get(id);

  Future<void> add(Device device) async {
    await _box.put(device.id, device);
    notifyListeners();
  }

  Future<void> update(Device device) async {
    await _box.put(device.id, device);
    notifyListeners();
  }

  Future<void> remove(String id) async {
    await _box.delete(id);
    notifyListeners();
  }

  int monthsRemaining(Device device, {DateTime? asOf}) {
    final nowUtc = (asOf ?? DateTime.now()).toUtc();
    final elapsed = _monthsBetween(device.purchaseDate, nowUtc);
    final remaining = device.warrantyMonths - elapsed;
    return math.max(0, remaining);
  }

  Future<Set<String>> getActivePhotoFileNames() async {
    final names = <String>{};
    for (final device in _box.values) {
      names.addAll(device.photoFileNames);
    }
    return names;
  }

  int _monthsBetween(DateTime start, DateTime end) {
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();
    if (endUtc.isBefore(startUtc)) return 0;
    int months =
        (endUtc.year - startUtc.year) * 12 + (endUtc.month - startUtc.month);
    if (endUtc.day < startUtc.day) {
      months -= 1;
    }
    return math.max(0, months);
  }
}
