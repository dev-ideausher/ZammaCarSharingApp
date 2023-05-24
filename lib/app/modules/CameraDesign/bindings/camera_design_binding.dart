import 'package:get/get.dart';

import '../controllers/camera_design_controller.dart';

class CameraDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraDesignController>(
      () => CameraDesignController(),
    );
  }
}
