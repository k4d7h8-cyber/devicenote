import 'dart:io';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/data/sources/hive_boxes.dart';
import 'package:devicenote/features/device/add_device_page.dart';
import 'package:devicenote/features/device/device_detail_page.dart';
import 'package:devicenote/features/home/home_page.dart';
import 'package:devicenote/features/home/category_device_list_page.dart';
import 'package:devicenote/features/settings/settings_page.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:devicenote/services/localization/language_provider.dart';
import 'package:devicenote/services/localization/localization_controller.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:devicenote/services/notifications/notification_preferences.dart';
import 'package:devicenote/services/notifications/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb &&
      (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow(
      const WindowOptions(
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: false,
      ),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DeviceCategoryAdapter().typeId)) {
    Hive.registerAdapter(DeviceCategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(DeviceAdapter().typeId)) {
    Hive.registerAdapter(DeviceAdapter());
  }

  final devicesBox = await Hive.openBox<Device>(HiveBoxes.deviceBoxName);
  await HiveBoxes.init(preOpened: devicesBox);

  final preferences = await NotificationPreferences.create();
  final localizationController = await LocalizationController.create();
  final notificationService = LocalNotificationService();
  await notificationService.initialize();

  final deviceRepository = DeviceRepository(devicesBox);
  final notificationController = NotificationController(
    service: notificationService,
    preferences: preferences,
    repository: deviceRepository,
  );

  runApp(
    riverpod.ProviderScope(
      overrides: [
        appLocaleProvider.overrideWith((ref) => localizationController.locale),
      ],
      child: DeviceNoteApp(
        preferences: preferences,
        localizationController: localizationController,
        notificationService: notificationService,
        deviceRepository: deviceRepository,
        notificationController: notificationController,
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
    required this.deviceRepository,
    required this.notificationController,
  });

  final NotificationPreferences preferences;
  final LocalizationController localizationController;
  final NotificationService notificationService;
  final DeviceRepository deviceRepository;
  final NotificationController notificationController;

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
              path: 'category/:category',
              builder: (context, state) {
                final value = state.pathParameters['category'];
                final category = DeviceCategory.values.firstWhere(
                  (c) => c.name == value,
                  orElse: () => DeviceCategory.etc,
                );
                return CategoryDeviceListPage(category: category);
              },
            ),
            GoRoute(
              path: 'device/add',
              builder: (context, state) {
                final param = state.uri.queryParameters['category'];
                DeviceCategory? initialCategory;
                if (param != null) {
                  initialCategory = DeviceCategory.values.firstWhere(
                    (c) => c.name == param,
                    orElse: () => DeviceCategory.etc,
                  );
                }
                return AddDevicePage(initialCategory: initialCategory);
              },
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
        ChangeNotifierProvider.value(value: deviceRepository),
        ChangeNotifierProvider.value(value: notificationController),
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
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
