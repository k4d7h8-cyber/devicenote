import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(
        title: const Text('DeviceNote'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: '설정',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/device/add'),
        child: const Icon(Icons.add),
      ),
      builder: (context, layout) {
        final repo = context.watch<DeviceRepository>();
        final items = repo.devices;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            const SizedBox(height: 16),
            if (items.isEmpty)
              Container(
                height: 200,
                alignment: Alignment.center,
                child: const Text('등록된 기기가 없습니다.'),
              )
            else
              Wrap(
                spacing: layout.gutter,
                runSpacing: layout.gutter,
                children: [
                  for (final device in items)
                    SizedBox(
                      width: layout.columnWidth(),
                      child: _DeviceCard(
                        device: device,
                        monthsRemaining: repo.monthsRemaining(device),
                        onTap: () => context.push('/device/${device.id}'),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.monthsRemaining,
    required this.onTap,
  });

  final Device device;
  final int monthsRemaining;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remainLabel = monthsRemaining == 0 ? 'D-day' : 'D-$monthsRemaining m';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.devices, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      device.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${device.brand} · ${device.model}',
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  remainLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
