import 'dart:convert';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/modules/models/transationdetails_model.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/globalData.dart';

class RideHistoryController extends GetxController {
  //TODO: Implement RideHistoryController

   Rx<RideHistory> rideHistory = RideHistory().obs;

   RxBool loader=false.obs;

   @override
  void onInit() {
    super.onInit();

    collectRideHistory();
  }
collectRideHistory(){
  getrideHistory();
}
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   getrideHistory() async {

    try {
      loader.value=true;
      final response = await APIManager.getRideHistory();
      print("");
      rideHistory.value = RideHistory.fromJson(jsonDecode(response.toString()));
      loader.value=false;
    }catch(e){
     loader.value=false;
    }

  }


}
