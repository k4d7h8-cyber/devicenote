import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/localization/language_provider.dart';
import 'package:devicenote/services/localization/localization_controller.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

const Map<String, String> _languageDisplayNames = {
  'bn': 'Bengali',
  'en': 'English',
  'es': 'Spanish',
  'es-MX': 'Spanish (Mexico)',
  'ha': 'Hausa',
  'hi': 'Hindi',
  'id': 'Indonesian',
  'ko': 'Korean',
  'pt': 'Portuguese',
  'pt-BR': 'Portuguese (Brazil)',
  'ru': 'Russian',
  'ur': 'Urdu',
  'zh': 'Chinese',
  'zh-Hans': 'Chinese (Simplified)',
};

class SettingsPage extends riverpod.ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final notifications = context.watch<NotificationController>();
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
        final selectedLocale = ref.watch(appLocaleProvider);
        final languageLabel = _languageLabel(l10n, selectedLocale);

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
                      onTap: () => _showLanguageDialog(context, ref),
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
}

String _languageLabel(AppLocalizations l10n, Locale locale) {
  final tag = locale.toLanguageTag();
  switch (tag) {
    case 'en':
      return l10n.languageEnglish;
    case 'ko':
      return l10n.languageKorean;
    default:
      return _languageDisplayNames[tag] ?? locale.languageCode;
  }
}

Future<void> _showLanguageDialog(
  BuildContext context,
  riverpod.WidgetRef ref,
) async {
  final controller = context.read<LocalizationController>();
  final locales = AppLocalizations.supportedLocales;
  final selected = ref.read(appLocaleProvider);

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext)!;
      return AlertDialog(
        title: Text(l10n.settingsLanguagePickerTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final locale in locales)
                ListTile(
                  title: Text(_languageLabel(l10n, locale)),
                  trailing: selected == locale ? const Icon(Icons.check) : null,
                  selected: selected == locale,
                  onTap: () async {
                    if (selected == locale) {
                      Navigator.of(dialogContext).pop();
                      return;
                    }
                    final navigator = Navigator.of(dialogContext);
                    ref.read(appLocaleProvider.notifier).state = locale;
                    navigator.pop();
                    await controller.setLocale(locale);
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}
