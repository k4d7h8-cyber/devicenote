// 최소 정의: Hive 애너테이션 전부 제거!
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
    required this.purchaseDate,
    required this.warrantyExpiresAt,
    this.asContact,
    this.photos = const [],
    this.receipts = const [],
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

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
    final now = DateTime.now();
    final expires = DateUtilsX.addMonths(purchaseDate, warrantyMonths);
    return Device(
      id: id ?? const Uuid().v4(),
      name: name,
      brand: brand,
      model: model,
      category: category,
      purchaseDate: purchaseDate,
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
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyExpiresAt: warrantyExpiresAt ?? this.warrantyExpiresAt,
      asContact: asContact ?? this.asContact,
      photos: photos ?? this.photos,
      receipts: receipts ?? this.receipts,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get daysUntilExpire => DateUtilsX.daysLeft(DateTime.now(), warrantyExpiresAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'brand': brand,
        'model': model,
        'category': category.name,
        'purchaseDate': DateUtilsX.formatYMD(purchaseDate),
        'warrantyExpiresAt': DateUtilsX.formatYMD(warrantyExpiresAt),
        'asContact': asContact?.toMap(),
        'photos': photos,
        'receipts': receipts,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Device.fromMap(Map<String, dynamic> map) {
    final purchase = DateTime.tryParse(map['purchaseDate'] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);
    final expire = DateTime.tryParse(map['warrantyExpiresAt'] ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);

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
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
