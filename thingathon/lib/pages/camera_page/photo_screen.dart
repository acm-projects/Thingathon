import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thingathon/pages/camera_page/image_display.dart';

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
  bool _isFlashOn = true;
  bool _isCapturing = false;
  File? _capturedImage;

  bool _isReady = false;

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.request();
    if (!(await Permission.storage.status.isGranted)) {
      await Permission.storage.request();
    }
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

  Future<void> _initCamera(_selectedCamIndex) async {
    _controller =
        CameraController(_cameras[_selectedCamIndex], ResolutionPreset.max);

    try {
      await _controller.initialize();
      setState(() {
        if (_selectedCamIndex == 0) {
          _isFrontCam = false;
        } else {
          _isFrontCam = true;
        }
      });
    } catch (e) {
      print("e");
    }

    if (mounted) {
      setState(() {});
    }
  }

  void toggleFlash() {
    if (_isFlashOn) {
      _controller.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      _controller.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  void flipCamera() async {
    if (_controller != null) {
      await _controller.dispose();
    }

    _selectedCamIndex = (_selectedCamIndex + 1) % _cameras.length;
    _initCamera(_selectedCamIndex);
  }

  void capturePhoto() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    //final Directory appDir = await pathProvider.getApplicationSupportDirectory();
    //final String capturePath = path.join(appDir.path, '${DateTime.now()}.jpg');

    if (_controller.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        _isCapturing = true;
      });

      final XFile capturedImage = await _controller.takePicture();
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageDisplay(imageFile: capturedImage)));
      }
    } catch (e) {
      print("Error capturing photo");
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    String currentObject = "Tree";

    if (!_isReady) return const Text("Loading...");
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text(
              '$formattedDate: $currentObject',
              style: GoogleFonts.poppins(
                  color: const Color(0xFFFF8159),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    child: AspectRatio(
                        aspectRatio: 1, child: CameraPreview(_controller))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      toggleFlash();
                    },
                    child: _isFlashOn
                        ? const Icon(
                            Icons.flash_on,
                            color: Color(0xFFFF8159),
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.flash_off,
                            color: Color(0xFFFF8159),
                            size: 30.0,
                          ),
                  ),
                  const SizedBox(width: 35),
                  GestureDetector(
                    onTap: () {
                      capturePhoto();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.circle,
                      color: Color(0xFFFF8159),
                      size: 60.0,
                    ),
                  ),
                  const SizedBox(width: 35),
                  GestureDetector(
                    onTap: () {
                      flipCamera();
                    },
                    child: const Icon(
                      Icons.flip_camera_android,
                      color: Color(0xFFFF8159),
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
