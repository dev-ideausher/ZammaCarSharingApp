import 'package:get/get.dart';

import '../controllers/total_payment_controller.dart';

class TotalPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TotalPaymentController>(
      () => TotalPaymentController(),
    );
  }
}
