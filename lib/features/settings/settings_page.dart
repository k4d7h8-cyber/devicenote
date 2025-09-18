import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationController>();

    return ResponsiveScaffold(
      appBar: AppBar(title: const Text('Settings')),
      builder: (context, layout) {
        final sectionWidth = layout.columns > 1
            ? layout.columnWidth(span: 2)
            : layout.columnWidth(span: layout.columns);
        final fullWidth = layout.columnWidth(span: layout.columns);

        final timeLabel = MaterialLocalizations.of(
          context,
        ).formatTimeOfDay(notifications.notificationTime);

        return Wrap(
          spacing: layout.gutter,
          runSpacing: layout.gutter,
          children: [
            SizedBox(
              width: sectionWidth,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      title: const Text('Enable Notifications'),
                      subtitle: Text(
                        notifications.notificationsEnabled
                            ? 'Warranty reminders will be delivered according to your device settings.'
                            : 'Turn on to receive warranty reminders before warranties expire.',
                      ),
                      value: notifications.notificationsEnabled,
                      onChanged: (value) async {
                        await notifications.setGlobalEnabled(
                          context: context,
                          enabled: value,
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.schedule),
                      title: const Text('Reminder time'),
                      subtitle: Text(timeLabel),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: notifications.notificationTime,
                        );
                        if (picked != null) {
                          await notifications.setNotificationTime(picked);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: sectionWidth,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Backup & Restore',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement backup logic
                              },
                              child: const Text('Backup'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement restore logic
                              },
                              child: const Text('Restore'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: fullWidth,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Version'),
                  subtitle: const Text('1.0.0 (placeholder)'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
