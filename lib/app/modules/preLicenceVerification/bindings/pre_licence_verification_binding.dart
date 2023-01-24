import 'package:get/get.dart';

import '../controllers/pre_licence_verification_controller.dart';

class PreLicenceVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreLicenceVerificationController>(
      () => PreLicenceVerificationController(),
    );
  }
}
