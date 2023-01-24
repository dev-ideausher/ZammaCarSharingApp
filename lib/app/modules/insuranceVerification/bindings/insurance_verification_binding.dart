import 'package:get/get.dart';

import '../controllers/insurance_verification_controller.dart';

class InsuranceVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsuranceVerificationController>(
      () => InsuranceVerificationController(),
    );
  }
}
