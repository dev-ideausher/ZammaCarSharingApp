import 'package:get/get.dart';

import '../controllers/payment_final_details_controller.dart';

class PaymentFinalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentFinalDetailsController>(
      () => PaymentFinalDetailsController(),
    );
  }
}
