import 'package:finespine/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finespine/theme/fonts.dart';

class RecordingStatus extends GetView<ScanController> {
  const RecordingStatus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 48,
        child: Container(
            height: 24,
            width: 120,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Text('RECORDING', style: TextStyles.recording(), textAlign: TextAlign.center,),
          ),
        );
  }
}
