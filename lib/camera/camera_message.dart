import 'package:finespine/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/fonts.dart';

class CameraMessage extends GetView<ScanController> {
  final String displayText;
  const CameraMessage(this.displayText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 80,
        width: 200,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            displayText,
            style: TextStyles.cameraMessage(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
