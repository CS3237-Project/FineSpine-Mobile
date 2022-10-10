import 'package:finespine/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureButton extends GetView<ScanController> {
  const CaptureButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 32,
        child: GestureDetector(
          onTap: () => controller.capture(),
          child: Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 6),
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ));
  }
}
