import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/utils/category_display.dart';
import 'package:flutter/material.dart';

class DeviceGridCard extends StatelessWidget {
  const DeviceGridCard({
    super.key,
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
    final l10n = AppLocalizations.of(context)!;
    final remainLabel = monthsRemaining == 0
        ? l10n.homeDDayLabel
        : l10n.homeDdayMonthsLabel(monthsRemaining);

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
                  Icon(
                    categoryIcon(device.category),
                    color: theme.colorScheme.primary,
                  ),
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
                l10n.homeDeviceBrandModel(device.brand, device.model),
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
