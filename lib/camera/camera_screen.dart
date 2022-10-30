import 'package:finespine/camera/camera_message.dart';
import 'package:finespine/camera/recording_status.dart';
import 'package:finespine/camera/connected_status.dart';
import 'package:finespine/camera/disconnected_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../scan_controller.dart';
import 'camera_viewer.dart';

class CameraScreen extends GetView<ScanController> {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(builder: (controller) {
      if (!controller.isInitialised) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              alignment: Alignment.center,
              children: const [
                DisconnectedStatus(),
                CameraMessage('Camera off'),
              ],
            ));
      }
      if (controller.isActivated.value == false) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              alignment: Alignment.center,
              children: const [
                ConnectedStatus(),
                CameraMessage('Posture Detection Paused'),
              ],
            ));
      }
      return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.center,
            children: const [
              CameraViewer(),
              // CaptureButton(),
              RecordingStatus(),
              ConnectedStatus(),
            ],
          ));
    });
  }
}
