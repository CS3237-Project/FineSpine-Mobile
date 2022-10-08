import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:finespine/scan_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CameraViewer extends GetView<ScanController> {
  const CameraViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(builder: (controller) {
      if (!controller.isInitialised) {
        return Container();
      }
      return SizedBox(
        child: CameraPreview(controller.cameraController),
        height: Get.height,
        width: Get.width,
      );
    });
  }
}
