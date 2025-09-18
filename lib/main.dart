import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/features/device/add_device_page.dart';
import 'package:devicenote/features/device/device_detail_page.dart';
import 'package:devicenote/features/home/home_page.dart';
import 'package:devicenote/features/settings/settings_page.dart';
import 'package:devicenote/services/notifications/notification_controller.dart';
import 'package:devicenote/services/notifications/notification_preferences.dart';
import 'package:devicenote/services/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await NotificationPreferences.create();
  final notificationService = LocalNotificationService();
  await notificationService.initialize();

  runApp(
    DeviceNoteApp(
      preferences: preferences,
      notificationService: notificationService,
    ),
  );
}

class DeviceNoteApp extends StatelessWidget {
  const DeviceNoteApp({
    super.key,
    required this.preferences,
    required this.notificationService,
  });

  final NotificationPreferences preferences;
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
        ChangeNotifierProvider(create: (_) => DeviceRepository()),
        ChangeNotifierProvider(
          create: (context) => NotificationController(
            service: notificationService,
            preferences: preferences,
            repository: context.read<DeviceRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'DeviceNote',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.light,
        ),
        routerConfig: router,
      ),
    );
  }
}
