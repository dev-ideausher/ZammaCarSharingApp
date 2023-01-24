import 'dart:convert';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/services/auth.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/storage.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController
  Rx<bool> light = false.obs;
  Rx<bool> islogedInStatus=false.obs;
  final instanceOfGlobalData=Get.find<GlobalData>();
  Rx<logedInDetails> logindetails = logedInDetails().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
     onBoardingStatus();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  onBoardingStatus() async {
    instanceOfGlobalData.loader.value=true;
    try {
      final response = await APIManager.checkIsUserOnBoard();
      logindetails.value =
          logedInDetails.fromJson(jsonDecode(response.toString()));
      print("response.data : ${response}");

      Get.find<GetStorageService>().setisLoggedIn = true;
      instanceOfGlobalData.isloginStatusGlobal.value = true;
      instanceOfGlobalData.loader.value=false;
    } catch (e) {

      instanceOfGlobalData.loader.value=false;
    }
  }
  Future<void> LogoutAnDeleteEveryThing() async {
    try {
      Get.find<GetStorageService>().setisLoggedIn = false;
      instanceOfGlobalData.isloginStatusGlobal.value = false;
      await Auth().logout();
    } catch (e) {

    }
  }
}
