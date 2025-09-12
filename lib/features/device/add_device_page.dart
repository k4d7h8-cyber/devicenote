import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _modelCtrl = TextEditingController();
  final _purchaseDateCtrl = TextEditingController();
  final _warrantyCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  DeviceCategory? _category;
  DateTime? _purchaseDate;

  final _dateFmt = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _brandCtrl.dispose();
    _modelCtrl.dispose();
    _purchaseDateCtrl.dispose();
    _warrantyCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  String _requiredLabel(String base) => '$base*';

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _purchaseDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(now) ? now : initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() {
        _purchaseDate = picked;
        _purchaseDateCtrl.text = _dateFmt.format(picked);
      });
    }
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final repo = context.read<DeviceRepository>();
    final id = const Uuid().v4();
    final warranty = int.parse(_warrantyCtrl.text);

    final device = Device(
      id: id,
      name: _nameCtrl.text.trim(),
      brand: _brandCtrl.text.trim(),
      model: _modelCtrl.text.trim(),
      category: _category!,
      purchaseDate: _purchaseDate!,
      warrantyMonths: warranty,
      asContact: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
    );

    repo.add(device);

    final snack = const SnackBar(
      content: Text('저장되었습니다.'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (mounted) Navigator.of(context).pop();
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기기 등록'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1) 카테고리
                DropdownButtonFormField<DeviceCategory>(
                  value: _category,
                  decoration: InputDecoration(
                    labelText: _requiredLabel('카테고리 '),
                    border: const OutlineInputBorder(),
                  ),
                  items: DeviceCategory.values
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(_categoryLabel(c)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v),
                  validator: (v) => v == null ? '카테고리는 필수 선택입니다.' : null,
                ),
                const SizedBox(height: 12),
                // 2) 브랜드
                TextFormField(
                  controller: _brandCtrl,
                  decoration: InputDecoration(
                    labelText: _requiredLabel('브랜드 '),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '브랜드는 필수 입력입니다.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // 3) 모델명 (기존 이름)
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    labelText: _requiredLabel('모델명 '),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '모델명은 필수 입력입니다.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // 4) 모델번호 (기존 모델)
                TextFormField(
                  controller: _modelCtrl,
                  decoration: InputDecoration(
                    labelText: _requiredLabel('모델번호 '),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '모델번호는 필수 입력입니다.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _purchaseDateCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: _requiredLabel('구입일 '),
                    hintText: '날짜 선택',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: const OutlineInputBorder(),
                  ),
                  onTap: _pickDate,
                  validator: (_) {
                    if (_purchaseDate == null) return '구입일은 필수 입력입니다.';
                    final now = DateTime.now();
                    if (_purchaseDate!.isAfter(DateTime(now.year, now.month, now.day))) {
                      return '구입일은 오늘 이후로 선택할 수 없습니다.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _warrantyCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    labelText: _requiredLabel('보증기간(년/개월) '),
                    hintText: '0 ~ 120',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '보증기간은 필수 입력입니다.';
                    final n = int.tryParse(v);
                    if (n == null) return '숫자만 입력할 수 있습니다.';
                    if (n < 0 || n > 120) return '보증기간은 0에서 120 사이여야 합니다.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: '고객센터',
                    hintText: '예) 1588-0000, 010-1234-5678',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null; // 선택 사항
                    final ok = RegExp(r'^[0-9-]+$').hasMatch(v.trim());
                    if (!ok) return '숫자와 - 만 입력할 수 있습니다.';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // 왼쪽: 저장, 오른쪽: 취소로 위치 스왑
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onSave,
                        child: const Text('저장'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onCancel,
                        child: const Text('취소'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _categoryLabel(DeviceCategory c) {
    switch (c) {
      case DeviceCategory.tv:
        return 'TV';
      case DeviceCategory.washer:
        return '세탁기';
      case DeviceCategory.computer:
        return '컴퓨터';
      case DeviceCategory.refrigerator:
        return '냉장고';
      case DeviceCategory.aircon:
        return '에어컨';
      case DeviceCategory.car:
        return '자동차';
      case DeviceCategory.etc:
        return '기타';
    }
  }
}
