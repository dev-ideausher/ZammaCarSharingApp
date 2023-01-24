import 'package:get/get.dart';

import '../controllers/licence_verification_form_controller.dart';

class LicenceVerificationFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicenceVerificationFormController>(
      () => LicenceVerificationFormController(),
    );
  }
}
