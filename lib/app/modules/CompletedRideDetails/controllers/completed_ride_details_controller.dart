import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/card_data_model.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/modules/models/saved_cards_model.dart';
import 'package:zammacarsharing/app/modules/models/transationdetails_model.dart';
import 'package:zammacarsharing/app/services/crypto.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';

class CompletedRideDetailsController extends GetxController {
  //TODO: Implement CompletedRideDetailsController

  LatLng center = LatLng(45.521563, -122.677433);
  Rx<TransactionDetails> transactionDetails = TransactionDetails().obs;
  Rx<savedCardsModel> savedCardsresponse = savedCardsModel().obs;
  RxDouble totalAmount=0.0.obs;
  RxDouble firstPayment=0.0.obs;
  RxDouble secondPayment=0.0.obs;
  RxList cardList = [].obs;
  RxString carNumber="XXXX XXXX XXXX XXXX".obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
   RxString pickupTimeConverted="".obs;
  RxString dropTimeConverted="".obs;
   RxString pickupAddress="".obs;
  RxString dropAddress="".obs;
  RxString durationOfRide="".obs;
  // Data Coming From RideHistory Controller
  final bookingId=Get.arguments[0];
  final model=Get.arguments[1];
  final date=Get.arguments[2];
  final index=Get.arguments[3];
  @override
  void onInit() {
    super.onInit();
    getrideHistory();
    getTransationDetails();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  getTransationDetails() async {

    try {

      final response = await APIManager.getPaymentHistory(bookingid: bookingId);
      transactionDetails.value = TransactionDetails.fromJson(jsonDecode(response.toString()));

          for(int i=0; i<transactionDetails.value.bookingTransactions!.length;i++){
            if(i==0){
              firstPayment.value=(transactionDetails.value.bookingTransactions?[i]?.totalPaidForBooking)!.toDouble();
              totalAmount.value=totalAmount.value+firstPayment.value;
              getCardDetails((transactionDetails.value.bookingTransactions?[0]?.stripePaymentDetail?.paymentMethod).toString());
            }
            if(i==1){
              secondPayment.value=(transactionDetails.value.bookingTransactions?[i]?.totalPaidForBooking)!.toDouble();
              totalAmount.value=totalAmount.value+secondPayment.value;
            }

    }
     print("");
    }catch(e){

    }

  }

  getCardDetails(String cardId) async {
    try {
      print("ride Start");

      final response = await APIManager.getSavedCards();
      savedCardsresponse.value = savedCardsModel.fromJson(
        jsonDecode(
          response.toString(),
        ),
      );


      savedCardsresponse.value.cards?.forEach((element) {

        if(element?.stripeCardId==cardId){
          var mData =
          json.decode(decryptAESCryptoJS(element!.encryptedCode.toString()));
          carNumber.value=mData['card_number'];

        }

      });

    } catch (e) {

    }
  }


  getrideHistory() async {

    try {

      final response = await APIManager.getfinalRideHistory();
      rideHistory.value = RideHistory.fromJson(jsonDecode(response.toString()));
      pickupAddress.value=(rideHistory.value.data?[index]?.pickupLocation?.address).toString();
      dropAddress.value=(rideHistory.value.data?[index]?.dropLocation?.address).toString();
      convertPickupDateTime(pickupTime: (rideHistory.value.data?[index]?.pickupTime).toString(),droptime: (rideHistory.value.data?[index]?.dropTime).toString());
    }catch(e){

    }

  }

  convertPickupDateTime({required String pickupTime,required String droptime}){
    print("Date Time Format : ${TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}");
    DateTime startDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}");
    DateTime endDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(droptime).toLocal()).format(Get.context!)}");
    final actualDifference=endDate.difference(startDate);
    durationOfRide.value=(actualDifference.inMinutes).toString();
   // return outputDate;
   // DateTime timeFormat = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
    pickupTimeConverted.value="${TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}";
dropTimeConverted.value="${TimeOfDay.fromDateTime(DateTime.parse(droptime).toLocal()).format(Get.context!)}";
  }
}
