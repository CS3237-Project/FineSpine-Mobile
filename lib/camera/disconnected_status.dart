import 'package:finespine/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/fonts.dart';

class DisconnectedStatus extends GetView<ScanController> {
  const DisconnectedStatus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60,
        right: 32,
        child: Container(
            height: 20,
            width: 120,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
          child: Text('⚠ DISCONNECTED', style: TextStyles.connection(), textAlign: TextAlign.center,),
          ),
        );
  }
}
