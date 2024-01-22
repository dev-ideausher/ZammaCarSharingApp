import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/booking/controllers/booking_controller.dart';
import 'package:zammacarsharing/app/modules/home/controllers/home_controller.dart';
import 'package:zammacarsharing/app/modules/models/card_data_model.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/saved_cards_model.dart';
import 'package:zammacarsharing/app/services/crypto.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:http/http.dart' as http;

import '../../../services/dialog_helper.dart';

class SavedCardsController extends GetxController {
  //TODO: Implement SavedCardsController

  RxBool loader = false.obs;
  RxInt totalSavedCard = 0.obs;
  RxList cardList = [].obs;
  Rx<savedCardsModel> savedCardsresponse = savedCardsModel().obs;

  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  var bookingId = Get.arguments[0];
  var model = Get.arguments[1];
  var seetCapacity = Get.arguments[2];
  var boolvale = Get.arguments[3];
  var planType = Get.arguments[4];
  var amount = Get.arguments[5];
  var miles = Get.arguments[6];
  var time = Get.arguments[7];

  @override
  void onInit() {
    fetchCardList();
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

  fetchCardList() {
    getCardDetails();
  }

  getCardDetails() async {
    try {
      print("ride Start");
      loader.value = true;
      cardList.value.clear();
      final response = await APIManager.getSavedCards();
      savedCardsresponse.value = savedCardsModel.fromJson(
        jsonDecode(
          response.toString(),
        ),
      );

      totalSavedCard.value = (savedCardsresponse.value.cards?.length)!;
      savedCardsresponse.value.cards?.forEach((element) {
        var mData =
            json.decode(decryptAESCryptoJS(element!.encryptedCode.toString()));
        cardList.value.add(CardDataModel(
            cardNumber: mData['card_number'],
            cardCvc: mData['card_cvc'],
            cardDate: mData['card_date'],
            cardId: element.stripeCardId.toString(),
            cardHolderName: mData['cardHolderName']));
      });
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  var bookingdata = CreateBookinModel().obs;


  Future<int> payViaCard(index) async {
    try {
      DialogHelper.showLoading();
      var body={};
      if(planType=="basic") {

        if (model != "End") {
          body = {
            "carId": Get.find<HomeController>().carId.value,
            "qnr":Get.find<HomeController>().qnr.value,
            "pickupLocation": {
              "type": "Point",
              "coordinates": [Get.find<HomeController>().selectedCarLatitude.value, Get.find<HomeController>().selectedCarLongitude.value],
              "address": Get.find<HomeController>().pickupAddress.value
            },
            "card_id": savedCardsresponse.value.cards?[index]?.stripeCardId,
            "amount": amount,
            "paymentStep": "initialPayment",
            "bookingPlan": planType,
            "bookingPaymentObject": {
              "mile": 0,
              "time": 0,
              "tax": 0
            }
          };
        }
        else {
          body = {

            "card_id": savedCardsresponse.value.cards?[index]?.stripeCardId,
            "amount": amount,
            "paymentStep": "finalPayment",
            "bookingPlan": planType,
            "bookingPaymentObject": {
              "mile": 0,
              "time": 0,
              "tax": 0
            }
          };
        }

        if (model != "End") {
          final response = await APIManager.createBooking(body: body);
          bookingdata.value = CreateBookinModel.fromJson(jsonDecode(response.toString()));;
          log("Response is this : ${response}");

          if (response.statusCode == 200 || response.statusCode == 201) {
            await DialogHelper.hideDialog();

            print("Payment done");

            return 1;
            // return Album.fromJson(jsonDecode(response.body));
          } else {
            await DialogHelper.hideDialog();

            return 0;
          }



        }else{
          final response = await APIManager.payment(body: body,bookingId: bookingId);
          //bookingdata.value = CreateBookinModel.fromJson(jsonDecode(response.toString()));;
          log("Response is this : ${response}");

          if (response.statusCode == 200 || response.statusCode == 201) {
            await DialogHelper.hideDialog();

            print("Payment done");

            return 1;
            // return Album.fromJson(jsonDecode(response.body));
          } else {
            await DialogHelper.hideDialog();

            return 0;
          }



        }





      }


      else{
        if (model != "End") {

          body = {
            "carId": Get.find<HomeController>().carId.value,
            "qnr":Get.find<HomeController>().qnr.value,
            "pickupLocation": {
              "type": "Point",
              "coordinates": [Get.find<HomeController>().selectedCarLatitude.value, Get.find<HomeController>().selectedCarLongitude.value],
              "address": Get.find<HomeController>().pickupAddress.value
            },
            "card_id": savedCardsresponse.value.cards?[index]?.stripeCardId,
            "amount": amount,
            "paymentStep": "initialPayment",
            "bookingPlan": planType,
            "bookingPaymentObject": {
              "mile": miles,
              "time": time,
              "tax": 0
            }
          };
        }
        else {
          body = {
            "card_id": savedCardsresponse.value.cards?[index]?.stripeCardId,
            "amount": amount,
            "paymentStep": "finalPayment",
            "bookingPlan": planType,
            "bookingPaymentObject": {
              "mile": miles,
              "time": time,
              "tax": 0
            }
          };
        }

        if(model != "End"){
          final response = await APIManager.createBooking(body: body
            // {
            //   "carId": Get.find<HomeController>().carId.value,
            //   "qnr":Get.find<HomeController>().qnr.value,
            //   "pickupLocation": {
            //     "type": "Point",
            //     "coordinates": [Get.find<HomeController>().selectedCarLatitude.value, Get.find<HomeController>().selectedCarLongitude.value],
            //     "address": Get.find<HomeController>().pickupAddress.value
            //   },
            //   "card_id": savedCardsresponse.value.cards?[index]?.stripeCardId,
            //   "amount": amount,
            //   "paymentStep": "initialPayment",
            //   "bookingPlan": planType,
            //   "bookingPaymentObject": {
            //     "mile": 0,
            //     "time": 0,
            //     "tax": 0
            //   }
            // }

          );
          bookingdata.value = CreateBookinModel.fromJson(jsonDecode(response.toString()));

          if (response.statusCode == 200 || response.statusCode == 201) {
            print("Payment done");
            await DialogHelper.hideDialog();

            return 1;
            // return Album.fromJson(jsonDecode(response.body));
          } else {
            await DialogHelper.hideDialog();

            return 0;
          }

        }else{

          final response = await APIManager.payment(
              bookingId: bookingId, body: body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            print("Payment done");
            await DialogHelper.hideDialog();

            return 1;
            // return Album.fromJson(jsonDecode(response.body));
          } else {
            await DialogHelper.hideDialog();

            return 0;
          }

        }
      }

    } catch (e) {
      await DialogHelper.hideDialog();

      return 0;
    }

  }

  Future<int> cancelBooking() async {
   // final instanceOfGlobalData = Get.find<GlobalData>();

   // instanceOfGlobalData.loader.value = true;
    var body = {"cancelReason": "Not available"};
    try {
      final response =
          await APIManager.cancelBooking(body: body, bookingId: bookingId);
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));

      print("response.data : ${response.toString()}");

     // instanceOfGlobalData.timer.cancel();
      return 1;
    } catch (e) {
     // instanceOfGlobalData.loader.value = false;

      return 0;
    }
  }
}
