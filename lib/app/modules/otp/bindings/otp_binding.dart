import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
