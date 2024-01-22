import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/widgets/snack_bar_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/auth.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var mobileNumber = "".obs;
 final instanceOfGlobalData=Get.find<GlobalData>();
Rx<bool> loader=false.obs;
  @override
  void onInit() {
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

  getOtpFunction() {

    instanceOfGlobalData.loader.value=true;

    if (mobileNumber.value == "") {

      showMySnackbar(title: "Error",msg: "Field must not be empty");
      instanceOfGlobalData.loader.value = false;

    }
    else{
      Get.put(Auth());
      Get.find<Auth>().verifyPhone(mobileNumber.value,true);

    }

  }
}
