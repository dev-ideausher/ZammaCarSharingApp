import 'package:get/get.dart';

import '../controllers/view_insurance_controller.dart';

class ViewInsuranceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewInsuranceController>(
      () => ViewInsuranceController(),
    );
  }
}
