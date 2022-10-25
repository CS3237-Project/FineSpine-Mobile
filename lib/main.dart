import 'package:finespine/camera/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'global_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
      title: "FineSpine",
      initialBinding: GlobalBindings(),
    );
  }


}
