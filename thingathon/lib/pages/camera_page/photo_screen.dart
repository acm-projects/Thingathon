import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late CameraImage cameraImage;

  int _selectedCamIndex = 0;
  bool _isFrontCam = false;
  bool _isFlashOn = false;
  File? _capturedImage;

  bool _isReady = false;

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras[0], ResolutionPreset.max);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isReady = true;
        });
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
    } else if (cameraStatus.isDenied) {
      print("Camera permission denied");
      return;
    } else if (cameraStatus.isPermanentlyDenied) {
      print("Camera permission denied. Please change permissions in settings");
      return;
    }
  }

  void toggleFlash() {}

  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) return const Text("Loading...");
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CameraPreview(_controller),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                ),
                Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                ),
                Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
