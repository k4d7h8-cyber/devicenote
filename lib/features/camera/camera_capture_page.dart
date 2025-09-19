import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:devicenote/l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';

class CameraCapturePage extends StatefulWidget {
  const CameraCapturePage({super.key});

  @override
  State<CameraCapturePage> createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  CameraController? _controller;
  Future<void>? _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final back = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    final controller = CameraController(
      back,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _controller = controller;
    await controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onTakePicture() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final controller = _controller;
      if (controller == null ||
          !controller.value.isInitialized ||
          controller.value.isTakingPicture) {
        return;
      }

      final capture = await controller.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${appDir.path}/photos');
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final ext = capture.path.split('.').last;
      final destPath = '${photosDir.path}/photo_$timestamp.$ext';
      final saved = await File(capture.path).copy(destPath);

      if (!mounted) return;
      Navigator.of(context).pop<String>(saved.path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.cameraCaptureFailed(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.cameraTitle)),
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final controller = _controller;
          if (controller == null || !controller.value.isInitialized) {
            return Center(
              child: Text(
                l10n.cameraInitializationFailed,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return Stack(
            children: [
              Center(child: CameraPreview(controller)),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: _onTakePicture,
                    child: const Icon(Icons.camera, size: 32),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
