
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/controller/camera_controller.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CameraPermissionController>(
          init: CameraPermissionController(),
          builder: (controller) {
            return controller.isCameraInitialized.value
                ? CameraPreview(controller.cameraController)
                : const Center(child: Text("Loading Preview..."));
          }),
    );
  }
}
//
