import 'dart:async';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/otp_used_class.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/auth.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
RxString smsCode="".obs;
Rx<bool>reSendLoader=false.obs;
late OtpNeededData instanceOfOtpNeededData ;
final instanceOfGlobalData=Get.find<GlobalData>();
  @override
  void onInit() {
    super.onInit();
    instanceOfOtpNeededData = Get.arguments[0];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  verifyOtp() {
    instanceOfGlobalData.loader.value=true;
    reSendLoader.value=true;
    if(smsCode.value==""){
      showMySnackbar(title: "Error",msg: "Field must not be empty");
    }else{
      Auth().verifyOTP(phoneNumber:instanceOfOtpNeededData.mobileNumber,verificationId: instanceOfOtpNeededData.veryFicationId,smsCode: smsCode.value ).then((value){
        if(value==true){

          instanceOfGlobalData.loader.value=false;
          Get.offNamed(Routes.PROFILE);
          //reSendLoader.value=false;
        }else{
          instanceOfGlobalData.loader.value=false;
         // reSendLoader.value=false;
        }

      });
    }
  }
late Timer timer;
var start = 30.obs;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  timer = new Timer.periodic(
    oneSec,
        (Timer timer) {
      if (start == 0) {

        timer.cancel();
        start.value = 30;
        reSendLoader.value=false;
      } else {
        reSendLoader.value=true;
        start--;

      }
    },
  );
}
}
