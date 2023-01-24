import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/otp_used_class.dart';
import 'package:zammacarsharing/app/services/storage.dart';

class GlobalData extends GetxService{
Rx<bool> isloginStatusGlobal=false.obs;
Rx<bool> loader=false.obs;
final userId="".obs;
final instanceOfOtpNeededData=OtpNeededData().obs;
  @override
  void onInit() {
    super.onInit();
    isloginStatusGlobal.value=Get.find<GetStorageService>().getisLoggedIn;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}