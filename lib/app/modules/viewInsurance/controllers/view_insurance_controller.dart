import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/modules/settings/controllers/settings_controller.dart';
import 'package:zammacarsharing/app/services/globalData.dart';

class ViewInsuranceController extends GetxController {
  //TODO: Implement ViewInsuranceController
  Rx<TextEditingController> insuranceController=TextEditingController().obs;
  Rx<TextEditingController> dateController=TextEditingController().obs;
  Rx<TextEditingController> monthController=TextEditingController().obs;
  Rx<TextEditingController> yearController=TextEditingController().obs;

  final instanceOfLoginData =
      Get.find<SettingsController>().logindetails.value.user?.insurance;
  final instanceOfGlobalData=Get.find<GlobalData>();
  Rx<logedInDetails> logindetails = logedInDetails().obs;

  final profilestatus = 0.obs;
  @override
  void onInit() {
    super.onInit();
    valueSetup();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  valueSetup() {
    insuranceController.value.text =
        (instanceOfLoginData?.insuranceNumber).toString();
    BreakDateFormat();
  }

  Future<void> BreakDateFormat() async {
    try {
      var str = (instanceOfLoginData?.validTill).toString();

      // print(str.substring(0,4));
      // print(str.substring(5,7));
      // print(str.substring(8,10));

      yearController.value.text = str.substring(6, 10);
      monthController.value.text = str.substring(3, 5);
      dateController.value.text = str.substring(0, 2);
    } catch (e) {}
  }
}
