import 'package:get/get.dart';

import '../controllers/completed_ride_details_controller.dart';

class CompletedRideDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedRideDetailsController>(
      () => CompletedRideDetailsController(),
    );
  }
}
