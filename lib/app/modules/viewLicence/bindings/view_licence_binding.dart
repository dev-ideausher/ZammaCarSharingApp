import 'package:get/get.dart';

import '../controllers/view_licence_controller.dart';

class ViewLicenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewLicenceController>(
      () => ViewLicenceController(),
    );
  }
}
