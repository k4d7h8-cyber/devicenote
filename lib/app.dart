import 'package:flutter/material.dart';
import 'package:devicenote/core/router.dart';

class DeviceNoteApp extends StatelessWidget {
  const DeviceNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeviceNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          // Triple the default 56dp size -> 168dp
          sizeConstraints: BoxConstraints.tightFor(width: 168, height: 168),
          shape: CircleBorder(),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
