import 'dart:collection';
import 'dart:math' as math;
import 'package:devicenote/core/utils/date_utils.dart';
import 'package:flutter/foundation.dart';

/// Device category metadata stored in memory.
enum DeviceCategory { tv, washer, computer, refrigerator, aircon, car, etc }

@immutable
class Device {
  final String id;
  final String name;
  final String brand;
  final String model;
  final DeviceCategory category;
  final DateTime purchaseDate;
  final int warrantyMonths;
  final String? asContact;
  final List<String> imagePaths;
  final List<String> receiptPaths;

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.category,
    required DateTime purchaseDate,
    required this.warrantyMonths,
    this.asContact,
    this.imagePaths = const [],
    this.receiptPaths = const [],
  }) : purchaseDate = DateUtilsX.normalizeToUtcDate(purchaseDate);

  Device copyWith({
    String? id,
    String? name,
    String? brand,
    String? model,
    DeviceCategory? category,
    DateTime? purchaseDate,
    int? warrantyMonths,
    String? asContact,
    List<String>? imagePaths,
    List<String>? receiptPaths,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      category: category ?? this.category,
      purchaseDate:
          purchaseDate != null ? DateUtilsX.normalizeToUtcDate(purchaseDate) : this.purchaseDate,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      asContact: asContact ?? this.asContact,
      imagePaths: imagePaths ?? this.imagePaths,
      receiptPaths: receiptPaths ?? this.receiptPaths,
    );
  }
}

class DeviceRepository extends ChangeNotifier {
  final List<Device> _devices = [];

  DeviceRepository();

  UnmodifiableListView<Device> get devices => UnmodifiableListView(_devices);

  Device? findById(String id) {
    try {
      return _devices.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  void add(Device device) {
    _devices.add(device);
    notifyListeners();
  }

  void update(Device device) {
    final index = _devices.indexWhere((d) => d.id == device.id);
    if (index != -1) {
      _devices[index] = device;
      notifyListeners();
    }
  }

  void remove(String id) {
    _devices.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  int monthsRemaining(Device device, {DateTime? asOf}) {
    final nowUtc = (asOf ?? DateTime.now()).toUtc();
    final elapsed = _monthsBetween(device.purchaseDate, nowUtc);
    final remaining = device.warrantyMonths - elapsed;
    return math.max(0, remaining);
  }

  int _monthsBetween(DateTime start, DateTime end) {
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();
    if (endUtc.isBefore(startUtc)) return 0;
    int months = (endUtc.year - startUtc.year) * 12 + (endUtc.month - startUtc.month);
    if (endUtc.day < startUtc.day) {
      months -= 1;
    }
    return math.max(0, months);
  }
}
