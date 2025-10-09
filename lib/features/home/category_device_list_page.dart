import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/features/home/widgets/device_grid_card.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/utils/category_display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryDeviceListPage extends StatelessWidget {
  const CategoryDeviceListPage({
    super.key,
    required this.category,
  });

  final DeviceCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repo = context.watch<DeviceRepository>();
    final filteredDevices = repo.devices
        .where((device) => device.category == category)
        .toList(growable: false);
    final title = categoryDisplayName(l10n, category);

    return ResponsiveScaffold(
      appBar: AppBar(
        title: filteredDevices.isEmpty ? null : Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddDevice(context),
        tooltip: l10n.homeAddDeviceTooltip,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFBEE3F8),
                Color(0xFFC6F6D5),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: const SizedBox.expand(
            child: Center(
              child: Icon(
                Icons.add,
                size: 36,
              ),
            ),
          ),
        ),
      ),
      builder: (context, layout) {
        if (filteredDevices.isEmpty) {
          final theme = Theme.of(context);
          final messages = categoryEmptyMessageLines(l10n);
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messages.first,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  messages.length > 1 ? messages[1] : '',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Wrap(
              spacing: layout.gutter,
              runSpacing: layout.gutter,
              children: [
                for (final device in filteredDevices)
                  SizedBox(
                    width: DeviceGridCard.widthForLayout(layout),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: DeviceGridCard(
                        device: device,
                        monthsRemaining: repo.monthsRemaining(device),
                        onTap: () => context.push('/device/${device.id}'),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openAddDevice(BuildContext context) {
    context.push('/device/add?category=${category.name}');
  }
}
