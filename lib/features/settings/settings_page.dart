import 'dart:convert';
import 'dart:io';

import 'package:devicenote/data/repositories/backup_repository.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/l10n/app_localizations_extensions.dart';
import 'package:devicenote/responsive_layout.dart';
import 'package:devicenote/services/localization/language_provider.dart';
import 'package:devicenote/services/localization/localization_controller.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends riverpod.ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _onBackupPressed(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    try {
      final backupRepository = BackupRepository();
      final json = backupRepository.exportToJson();
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toUtc().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final fileName = 'devicenote_backup_$timestamp.json';
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(json, flush: true);

      final xFile = XFile(
        file.path,
        mimeType: 'application/json',
        name: fileName,
      );

      await Share.shareXFiles([
        xFile,
      ], subject: l10n.settingsBackupSectionTitle);

      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.settingsBackupSuccess(fileName))),
      );
    } catch (_) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.settingsBackupFailure)),
      );
    }
  }

  Future<void> _onRestorePressed(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        dialogTitle: l10n.settingsRestorePickerTitle,
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );
    } catch (_) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.settingsRestoreFailure)),
      );
      return;
    }

    if (result == null || result.files.isEmpty) {
      return;
    }

    try {
      final file = result.files.first;
      String jsonStr;

      if (file.bytes != null && file.bytes!.isNotEmpty) {
        jsonStr = utf8.decode(file.bytes!);
      } else if (file.path != null) {
        jsonStr = await File(file.path!).readAsString();
      } else {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.settingsRestoreFailure)),
        );
        return;
      }

      final backupRepository = BackupRepository();
      final (added, updated, failed) = await backupRepository.importFromJson(
        jsonStr,
      );

      if (!context.mounted) return;

      if (failed == -1) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.settingsRestoreInvalid)),
        );
        return;
      }

      if (failed > 0) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.settingsRestorePartial(added, updated, failed)),
          ),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.settingsRestoreResult(added, updated))),
        );
      }

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(l10n.settingsBackupSectionTitle),
            content: Text(l10n.settingsRestoreRestartPrompt),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.settingsRestoreLater),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  SystemNavigator.pop();
                },
                child: Text(l10n.settingsRestoreRestartNow),
              ),
            ],
          );
        },
      );
    } catch (_) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.settingsRestoreFailure)),
      );
    }
  }

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final notifications = context.watch<NotificationController>();
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffold(
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
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFBEE3F8),
                            Color(0xFFC6F6D5),
                          ],
                        ),
                      ),
                      child: SwitchListTile(
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
                    ),
                    const Divider(height: 0),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFBEE3F8),
                            Color(0xFFC6F6D5),
                          ],
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.schedule),
                        title: Text(l10n.settingsReminderTimeLabel),
                        subtitle: Text(timeLabel),
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: notifications.notificationTime,
                            builder: (pickerContext, child) =>
                                Localizations.override(
                                  context: pickerContext,
                                  locale: l10n.locale,
                                  child: child,
                                ),
                          );
                          if (picked != null) {
                            await notifications.setNotificationTime(picked);
                          }
                        },
                      ),
                    ),
                    const Divider(height: 0),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFBEE3F8),
                            Color(0xFFC6F6D5),
                          ],
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.language),
                        title: Text(l10n.settingsLanguageTitle),
                        subtitle: Text(languageLabel),
                        onTap: () => _showLanguageDialog(context, ref),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: sectionWidth,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBEE3F8),
                        Color(0xFFC6F6D5),
                      ],
                    ),
                  ),
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
                              onPressed: () => _onBackupPressed(context),
                              child: Text(l10n.commonBackup),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _onRestorePressed(context),
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
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBEE3F8),
                        Color(0xFFC6F6D5),
                      ],
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(l10n.commonVersion),
                    subtitle: Text(
                      l10n.settingsVersionValue(l10n.settingsVersionPlaceholder),
                    ),
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
  switch (locale.toLanguageTag()) {
    case 'bn':
      return l10n.languageBengali;
    case 'en':
      return l10n.languageEnglish;
    case 'es':
      return l10n.languageSpanish;
    case 'es-MX':
      return l10n.languageSpanishMexico;
    case 'hi':
      return l10n.languageHindi;
    case 'id':
      return l10n.languageIndonesian;
    case 'ko':
      return l10n.languageKorean;
    case 'pt':
      return l10n.languagePortuguese;
    case 'pt-BR':
      return l10n.languagePortugueseBrazil;
    case 'ru':
      return l10n.languageRussian;
    case 'ur':
      return l10n.languageUrdu;
    case 'zh':
      return l10n.languageChinese;
    case 'zh-Hans':
      return l10n.languageChineseSimplified;
    default:
      return locale.toLanguageTag();
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
