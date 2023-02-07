import 'dart:convert';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

class RepeatedApiCalling extends GetxService{

  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;

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
  Future<int> cancelBooking(String bookingId) async {
    final instanceOfGlobalData = Get.find<GlobalData>();

    instanceOfGlobalData.loader.value = true;
    var body = {
      "cancelReason": "Not available"
    };
    try {

      final response = await APIManager.cancelBooking(body: body,
          bookingId: bookingId);
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));

      print("response.data : ${response.toString()}");

      instanceOfGlobalData.loader.value = false;

      showMySnackbar(title: "Msg", msg: "Ride canceled");

      return 1;
    } catch (e) {

      showMySnackbar(title: "Error", msg: "Error while cancel booking");

      instanceOfGlobalData.loader.value = false;
      return 0;
    }
  }
}