import 'package:uuid/uuid.dart';
import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/data/models/enums.dart';
import 'package:devicenote/data/models/as_contact.dart';

class Device {
  final String id;
  final String name;
  final String brand;
  final String model;
  final DeviceCategory category;
  final DateTime purchaseDate;
  final DateTime warrantyExpiresAt;
  final AsContact? asContact;
  final List<String> photos;
  final List<String> receipts;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.category,
    required DateTime purchaseDate,
    required DateTime warrantyExpiresAt,
    this.asContact,
    this.photos = const [],
    this.receipts = const [],
    this.notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : purchaseDate = DateUtilsX.normalizeToUtcDate(purchaseDate),
        warrantyExpiresAt = DateUtilsX.normalizeToUtcDate(warrantyExpiresAt),
        createdAt = createdAt.toUtc(),
        updatedAt = updatedAt.toUtc();

  factory Device.createWithMonths({
    String? id,
    required String name,
    required String brand,
    required String model,
    required DeviceCategory category,
    required DateTime purchaseDate,
    required int warrantyMonths,
    AsContact? asContact,
    List<String> photos = const [],
    List<String> receipts = const [],
    String? notes,
  }) {
    final normalizedPurchase = DateUtilsX.normalizeToUtcDate(purchaseDate);
    final now = DateTime.now().toUtc();
    final expires = DateUtilsX.addMonths(normalizedPurchase, warrantyMonths);
    return Device(
      id: id ?? const Uuid().v4(),
      name: name,
      brand: brand,
      model: model,
      category: category,
      purchaseDate: normalizedPurchase,
      warrantyExpiresAt: expires,
      asContact: asContact,
      photos: photos,
      receipts: receipts,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  Device copyWith({
    String? id,
    String? name,
    String? brand,
    String? model,
    DeviceCategory? category,
    DateTime? purchaseDate,
    DateTime? warrantyExpiresAt,
    AsContact? asContact,
    List<String>? photos,
    List<String>? receipts,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      warrantyExpiresAt: warrantyExpiresAt != null
          ? DateUtilsX.normalizeToUtcDate(warrantyExpiresAt)
          : this.warrantyExpiresAt,
      asContact: asContact ?? this.asContact,
      photos: photos ?? this.photos,
      receipts: receipts ?? this.receipts,
      notes: notes ?? this.notes,
      createdAt: (createdAt ?? this.createdAt).toUtc(),
      updatedAt: (updatedAt ?? this.updatedAt).toUtc(),
    );
  }

  int get daysUntilExpire =>
      DateUtilsX.daysLeft(DateTime.now().toUtc(), warrantyExpiresAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'brand': brand,
        'model': model,
        'category': category.name,
        'purchaseDate': purchaseDate.toUtc().toIso8601String(),
        'warrantyExpiresAt': warrantyExpiresAt.toUtc().toIso8601String(),
        'asContact': asContact?.toMap(),
        'photos': photos,
        'receipts': receipts,
        'notes': notes,
        'createdAt': createdAt.toUtc().toIso8601String(),
        'updatedAt': updatedAt.toUtc().toIso8601String(),
      };

  factory Device.fromMap(Map<String, dynamic> map) {
    DateTime parseDate(String? value) {
      if (value == null || value.isEmpty) {
        return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
      }
      final parsed = DateTime.tryParse(value);
      if (parsed == null) {
        return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
      }
      return DateUtilsX.normalizeToUtcDate(parsed);
    }

    DateTime parseTimestamp(String? value) {
      if (value == null || value.isEmpty) {
        return DateTime.now().toUtc();
      }
      final parsed = DateTime.tryParse(value);
      if (parsed == null) {
        return DateTime.now().toUtc();
      }
      return parsed.toUtc();
    }

    final purchase = parseDate(map['purchaseDate'] as String?);
    final expire = parseDate(map['warrantyExpiresAt'] as String?);

    return Device(
      id: map['id'] as String,
      name: (map['name'] ?? '') as String,
      brand: (map['brand'] ?? '') as String,
      model: (map['model'] ?? '') as String,
      category: DeviceCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => DeviceCategory.other,
      ),
      purchaseDate: purchase,
      warrantyExpiresAt: expire,
      asContact: map['asContact'] != null
          ? AsContact.fromMap(Map<String, dynamic>.from(map['asContact']))
          : null,
      photos: (map['photos'] as List?)?.cast<String>() ?? const [],
      receipts: (map['receipts'] as List?)?.cast<String>() ?? const [],
      notes: map['notes'] as String?,
      createdAt: parseTimestamp(map['createdAt'] as String?),
      updatedAt: parseTimestamp(map['updatedAt'] as String?),
    );
  }
}
