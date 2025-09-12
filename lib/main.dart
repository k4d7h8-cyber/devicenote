import 'package:flutter/material.dart';
import 'package:devicenote/features/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:devicenote/data/repositories/device_repository.dart';

void main() {
  runApp(const DeviceNoteApp());
}

class DeviceNoteApp extends StatelessWidget {
  const DeviceNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceRepository(),
      child: MaterialApp(
        title: 'DeviceNote',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.light,
        ),
        home: const HomePage(),
      ),
    );
  }
}
