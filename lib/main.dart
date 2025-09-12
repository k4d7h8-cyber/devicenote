import 'package:flutter/material.dart';
import 'package:devicenote/features/home/home_page.dart';

void main() {
  runApp(const DeviceNoteApp());
}

class DeviceNoteApp extends StatelessWidget {
  const DeviceNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeviceNote',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

1111111111111