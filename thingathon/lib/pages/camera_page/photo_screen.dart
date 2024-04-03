import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> _initCamera(selectedCamIndex) async {
    _controller =
        CameraController(_cameras[selectedCamIndex], ResolutionPreset.max);

    try {
      await _controller.initialize();
      setState(() {
        if (selectedCamIndex == 0) {
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
    await _controller.dispose();
  
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
      File imageFile = File(capturedImage.path);
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageDisplay(imageFile: imageFile)));
      }

      // String imagePath = capturedImage.path;
      // await GallerySaver.saveImage(imagePath);

      // final String filePath = '$capturePath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      // _capturedImage = File(capturedImage.path);
      // _capturedImage!.renameSync(filePath);
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
    if (!_isReady) return const Text("Loading...");
    return SafeArea(
      child: Center(
        child: Column(
          children: [
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
              padding: const EdgeInsets.all(10.0),
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
