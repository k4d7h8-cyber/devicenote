import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeviceDetailPage extends StatelessWidget {
  final String id;
  const DeviceDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<DeviceRepository>();
    final device = repo.findById(id);

    if (device == null) {
      return ResponsiveScaffold(
        appBar: AppBar(title: const Text('상세')),
        builder: (context, layout) =>
            const Center(child: Text('기기를 찾을 수 없습니다.')),
      );
    }

    final dateFmt = DateFormat('yyyy-MM-dd');

    return ResponsiveScaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '수정',
            onPressed: () => context.push('/device/${device.id}/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: '삭제',
            onPressed: () => _confirmDelete(context, repo, device.id),
          ),
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: '엑셀 내보내기',
            onPressed: () {
              // TODO: Implement Excel export
            },
          ),
        ],
      ),
      builder: (context, layout) {
        final cardWidth = layout.columnWidth();
        final cards = [
          _InfoCard(
            title: 'Category',
            value: _categoryLabel(device.category),
            icon: Icons.category,
          ),
          _InfoCard(
            title: 'Brand',
            value: device.brand,
            icon: Icons.storefront,
          ),
          _InfoCard(
            title: 'Model Name',
            value: device.name,
            icon: Icons.devices,
          ),
          _InfoCard(
            title: 'Model No.',
            value: device.model,
            icon: Icons.confirmation_number,
          ),
          _InfoCard(
            title: 'Purchase Date',
            value: dateFmt.format(device.purchaseDate),
            icon: Icons.event,
          ),
          _InfoCard(
            title: 'Warranty (months)',
            value: device.warrantyMonths.toString(),
            icon: Icons.verified_user,
          ),
          _InfoCard(
            title: 'Customer Center',
            value: device.asContact ?? '-',
            icon: Icons.phone,
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: layout.gutter,
              runSpacing: layout.gutter,
              children: [
                for (final card in cards)
                  SizedBox(width: cardWidth, child: card),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/device/${device.id}/edit'),
                    icon: const Icon(Icons.edit),
                    label: const Text('수정'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelete(context, repo, device.id),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('삭제'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    DeviceRepository repo,
    String id,
  ) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('삭제하시겠어요?'),
        content: const Text('해당 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (yes == true) {
      repo.remove(id);
      if (context.mounted) context.pop();
    }
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
