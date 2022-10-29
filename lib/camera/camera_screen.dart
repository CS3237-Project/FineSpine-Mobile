import 'package:finespine/camera/capture_button.dart';
import 'package:finespine/camera/recording_status.dart';
import 'package:finespine/camera/connected_status.dart';
import 'package:flutter/material.dart';
import 'camera_viewer.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:Stack(
      alignment: Alignment.center,
      children: const [
        CameraViewer(),
        // CaptureButton(),
        RecordingStatus(),
        ConnectedStatus(),
      ],
    ));
  }
}
