import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/services/localization/language_provider.dart';
import 'package:devicenote/services/localization/localization_controller.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:devicenote/services/notifications/notification_preferences.dart';
import 'package:devicenote/services/notifications/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/data/sources/hive_boxes.dart';
import 'package:devicenote/features/device/add_device_page.dart';
import 'package:devicenote/features/device/device_detail_page.dart';
import 'package:devicenote/features/home/home_page.dart';
import 'package:devicenote/features/settings/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBoxes.init();
  final preferences = await NotificationPreferences.create();
  final localizationController = await LocalizationController.create();
  final notificationService = LocalNotificationService();
  await notificationService.initialize();

  runApp(
    riverpod.ProviderScope(
      overrides: [
        appLocaleProvider.overrideWith((ref) => localizationController.locale),
      ],
      child: DeviceNoteApp(
        preferences: preferences,
        localizationController: localizationController,
        notificationService: notificationService,
      ),
    ),
  );
}

class DeviceNoteApp extends StatelessWidget {
  const DeviceNoteApp({
    super.key,
    required this.preferences,
    required this.localizationController,
    required this.notificationService,
  });

  final NotificationPreferences preferences;
  final LocalizationController localizationController;
  final NotificationService notificationService;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
            GoRoute(
              path: 'device/add',
              builder: (context, state) => const AddDevicePage(),
            ),
            GoRoute(
              path: 'device/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return DeviceDetailPage(id: id);
              },
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    final repo = context.read<DeviceRepository>();
                    final device = repo.findById(id);
                    return AddDevicePage(existing: device);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localizationController),
        ChangeNotifierProvider(create: (_) => DeviceRepository()),
        ChangeNotifierProvider(
          create: (context) => NotificationController(
            service: notificationService,
            preferences: preferences,
            repository: context.read<DeviceRepository>(),
          ),
        ),
      ],
      child: riverpod.Consumer(
        builder: (context, ref, _) {
          final locale = ref.watch(appLocaleProvider);

          return MaterialApp.router(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            locale: locale,
            supportedLocales: LocalizationController.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) {
                return LocalizationController.fallbackLocale;
              }
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale.languageCode &&
                    supported.countryCode == locale.countryCode) {
                  return supported;
                }
              }
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale.languageCode) {
                  return supported;
                }
              }
              return LocalizationController.fallbackLocale;
            },
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              brightness: Brightness.light,
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
