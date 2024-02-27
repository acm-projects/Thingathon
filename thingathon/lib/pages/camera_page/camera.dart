import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;
Future<void> requestCameraPermission() async {
  final cameraStatus = await Permission.camera.request();
  if (cameraStatus.isGranted) {
    _cameras = await availableCameras();
  } else if (cameraStatus.isDenied) {
    print("Camera permission denied");
    return;
  } else if (cameraStatus.isPermanentlyDenied) {
    print("Camera permission denied. Please change permissions in settings");
    return;
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 500,
    );
  }
}
