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
        scaffoldBackgroundColor: Colors.transparent,
      ),
      builder: (context, child) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBEE3F8),
              Color(0xFFC6F6D5),
            ],
          ),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
