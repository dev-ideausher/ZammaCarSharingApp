import 'package:get/get.dart';

import '../controllers/pre_insurance_verification_controller.dart';

class PreInsuranceVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreInsuranceVerificationController>(
      () => PreInsuranceVerificationController(),
    );
  }
}
