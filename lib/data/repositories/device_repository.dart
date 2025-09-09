import 'dart:collection';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// 기기 카테고리
enum DeviceCategory { tv, washer, computer, refrigerator, aircon, etc }

/// 기기 데이터 모델
@immutable
class Device {
  final String id; // uuid 또는 고유 문자열
  final String name;
  final String brand;
  final String model;
  final DeviceCategory category;
  final DateTime purchaseDate;
  final int warrantyMonths;
  final String? asContact;
  final List<String> imagePaths;
  final List<String> receiptPaths;

  const Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.category,
    required this.purchaseDate,
    required this.warrantyMonths,
    this.asContact,
    this.imagePaths = const [],
    this.receiptPaths = const [],
  });

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
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      asContact: asContact ?? this.asContact,
      imagePaths: imagePaths ?? this.imagePaths,
      receiptPaths: receiptPaths ?? this.receiptPaths,
    );
  }
}

/// 인메모리 리포지토리: CRUD + 시드 데이터
class DeviceRepository extends ChangeNotifier {
  final List<Device> _devices = [];

  DeviceRepository() {
    _seed();
  }

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

  /// 남은 보증기간(개월)
  int monthsRemaining(Device device, {DateTime? asOf}) {
    final now = asOf ?? DateTime.now();
    final elapsed = _monthsBetween(device.purchaseDate, now);
    final remaining = device.warrantyMonths - elapsed;
    return math.max(0, remaining);
  }

  // start ~ end 사이 경과 개월 수 (일자 보정)
  int _monthsBetween(DateTime start, DateTime end) {
    if (end.isBefore(start)) return 0;
    int months = (end.year - start.year) * 12 + (end.month - start.month);
    // 구매일의 '일'을 기준으로 아직 한 달이 안 지났다면 -1
    if (end.day < start.day) {
      months -= 1;
    }
    return math.max(0, months);
  }

  void _seed() {
    final now = DateTime.now();
    _devices.addAll([
      Device(
        id: 'seed-1',
        name: '삼성 TV',
        brand: 'Samsung',
        model: 'Q80B',
        category: DeviceCategory.tv,
        purchaseDate: now.subtract(const Duration(days: 200)),
        warrantyMonths: 24,
        asContact: '1588-3366',
      ),
      Device(
        id: 'seed-2',
        name: '맥북 프로',
        brand: 'Apple',
        model: 'M1 Pro 14',
        category: DeviceCategory.computer,
        purchaseDate: now.subtract(const Duration(days: 420)),
        warrantyMonths: 12,
        asContact: '080-333-4000',
      ),
    ]);
  }
}
