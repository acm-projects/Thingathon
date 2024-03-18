import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionController extends GetxController {
  @override
  void onInit() {
    requestCameraPermission();
    super.onInit();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  late List<CameraDescription> _cameras;
  late CameraController cameraController;
  late CameraImage cameraImage;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  requestCameraPermission() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      _cameras = await availableCameras();
      cameraController = CameraController(_cameras[0], ResolutionPreset.max);
      await cameraController.initialize();

      isCameraInitialized(true);
      update();
    } else if (cameraStatus.isDenied) {
      print("Camera permission denied");
      return;
    } else if (cameraStatus.isPermanentlyDenied) {
      print("Camera permission denied. Please change permissions in settings");
      return;
    }
  }

  objectDetector() async {}
}
