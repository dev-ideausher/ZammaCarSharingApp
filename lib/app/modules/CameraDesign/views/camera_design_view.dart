import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/camera_design_controller.dart';

class CameraDesignView extends GetView<CameraDesignController> {
  @override
  Widget build(BuildContext context) {
    if (controller.controllerr!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller.controllerr!),
    );
  }
}

