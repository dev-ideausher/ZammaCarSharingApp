import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/total_payment_model.dart';

class PaymentFinalDetailsController extends GetxController {
  //TODO: Implement PaymentFinalDetailsController
  var payments = TotalPaymentsData().obs;
  final count = 0.obs;
  var loader = false.obs;
  @override
  void onInit() {
    loader.value = true;
     payments.value = Get.arguments[0];
    loader.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
