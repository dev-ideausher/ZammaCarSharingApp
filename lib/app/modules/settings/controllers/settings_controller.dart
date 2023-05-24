import 'dart:convert';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
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
 // Rx<RideHistory> rideHistory = RideHistory().obs;
  RxBool loader=false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
   // getrideHistory();
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
      Get.find<GetStorageService>().setCustomUserId = (logindetails.value.user?.Id).toString();
      instanceOfGlobalData.isloginStatusGlobal.value = true;
      instanceOfGlobalData.loader.value=false;
    } catch (e) {

      instanceOfGlobalData.loader.value=false;
    }
  }
  /*getrideHistory() async {

    try {
      loader.value=true;
      final response = await APIManager.getRideHistory();
      rideHistory.value = RideHistory.fromJson(jsonDecode(response.toString()));
      loader.value=false;
    }catch(e){
      loader.value=false;
    }

  }*/
  Future<void> LogoutAnDeleteEveryThing() async {
    try {
      Get.find<GetStorageService>().setisLoggedIn = false;
      instanceOfGlobalData.isloginStatusGlobal.value = false;
      await Auth().logout();
    } catch (e) {

    }
  }
}
