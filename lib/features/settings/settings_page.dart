import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/localization/localization_controller.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationController>();
    final localization = context.watch<LocalizationController>();
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      builder: (context, layout) {
        final sectionWidth = layout.columns > 1
            ? layout.columnWidth(span: 2)
            : layout.columnWidth(span: layout.columns);
        final fullWidth = layout.columnWidth(span: layout.columns);
        final timeLabel = MaterialLocalizations.of(
          context,
        ).formatTimeOfDay(notifications.notificationTime);
        final languageLabel = _languageLabel(l10n, localization.locale);

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
                      title: Text(l10n.settingsNotificationsToggleTitle),
                      subtitle: Text(
                        notifications.notificationsEnabled
                            ? l10n.settingsNotificationsToggleEnabled
                            : l10n.settingsNotificationsToggleDisabled,
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
                      title: Text(l10n.settingsReminderTimeLabel),
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
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(l10n.settingsLanguageTitle),
                      subtitle: Text(languageLabel),
                      onTap: () => _showLanguagePicker(context),
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
                        l10n.settingsBackupSectionTitle,
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
                              child: Text(l10n.commonBackup),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement restore logic
                              },
                              child: Text(l10n.commonRestore),
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
                  title: Text(l10n.commonVersion),
                  subtitle: Text(
                    l10n.settingsVersionValue('1.0.0 (placeholder)'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _languageLabel(AppLocalizations l10n, Locale locale) {
    switch (locale.languageCode) {
      case 'ko':
        return l10n.languageKorean;
      case 'en':
      default:
        return l10n.languageEnglish;
    }
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.read<LocalizationController>();
    final locales = LocalizationController.supportedLocales;
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        final selected = controller.locale;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.settingsLanguagePickerTitle,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
              ),
              for (final locale in locales)
                RadioListTile<Locale>(
                  value: locale,
                  groupValue: selected,
                  title: Text(_languageLabel(l10n, locale)),
                  onChanged: (value) {
                    if (value == null) return;
                    controller.setLocale(value);
                    Navigator.of(sheetContext).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
