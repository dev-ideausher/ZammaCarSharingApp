import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/total_payment_model.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';

class TotalPaymentController extends GetxController {
  //TODO: Implement TotalPaymentController

Rx<TotalPayments> totalPayment = TotalPayments().obs;
RxString outputDate="".obs;
RxBool loader=false.obs;
RxInt nuberOfPayment=0.obs;
  @override
  void onInit() {
    super.onInit();
    getInProcessHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getInProcessHistory() async {
    try {
      loader.value=true;
      final response = await APIManager.getTotalPayments();
      totalPayment.value =
          TotalPayments.fromJson(jsonDecode(response.toString()));
      nuberOfPayment.value=(totalPayment.value.data?.length)!;
      loader.value=false;
      print("success");
    } catch (e) {
      loader.value=false;
      throw "issue while fetching total payements";
    }
  }

  convertDateTime(date){
   // final date = '2021-01-26T03:17:00.000000Z';
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd hh:mm a');
     outputDate.value = outputFormat.format(inputDate);
    print(outputDate.value);
  }
}
