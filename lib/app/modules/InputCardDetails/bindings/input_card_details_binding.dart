import 'package:get/get.dart';

import '../controllers/input_card_details_controller.dart';

class InputCardDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputCardDetailsController>(
      () => InputCardDetailsController(),
    );
  }
}
