import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/booking/controllers/booking_controller.dart';

class UserStatusController extends SuperController {
  @override
  void onDetached() {
    print("onDetached");
  }

  @override
  void onInactive() {
    print("onInactive");
  }

  @override
  void onPaused() {
    print("onPaused");
  }

  @override
  void onResumed() {
    print("onResumed");
    Get.find<BookingController>().getInProcessHistory();
    Get.find<BookingController>().getOnGoingHistory();
  }
}