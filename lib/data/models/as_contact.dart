// 최소 정의: Hive 애너테이션 전부 제거!
class AsContact {
  final String name;
  final String phone;
  final String? memo;

  const AsContact({required this.name, required this.phone, this.memo});

  AsContact copyWith({String? name, String? phone, String? memo}) {
    return AsContact(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'phone': phone, 'memo': memo};

  factory AsContact.fromMap(Map<String, dynamic> map) {
    return AsContact(
      name: (map['name'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      memo: map['memo'] as String?,
    );
  }
}
