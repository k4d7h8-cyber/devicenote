import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
    try {
      final c = _controller;
      if (c == null || !c.value.isInitialized || c.value.isTakingPicture) return;

      final xfile = await c.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final photosDir = Directory('${appDir.path}/photos');
      if (!await photosDir.exists()) {
        await photosDir.create(recursive: true);
      }
      final ts = DateTime.now().millisecondsSinceEpoch;
      final ext = xfile.path.split('.').last;
      final destPath = '${photosDir.path}/photo_$ts.$ext';
      final saved = await File(xfile.path).copy(destPath);

      if (!mounted) return;
      Navigator.of(context).pop<String>(saved.path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('촬영 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카메라')),
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_controller == null || !_controller!.value.isInitialized) {
            return const Center(child: Text('카메라 초기화 실패', style: TextStyle(color: Colors.white)));
          }
          return Stack(
            children: [
              Center(child: CameraPreview(_controller!)),
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

