import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zammacarsharing/app/modules/savedCards/controllers/saved_cards_controller.dart';
import 'package:zammacarsharing/app/services/crypto.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/storage.dart';
class InputCardDetailsController extends GetxController {
  //TODO: Implement InputCardDetailsController
  final cardNumber = ''.obs;
  final expiryDate = ''.obs;
  final cardHolderName = ''.obs;
  final cvvCode = ''.obs;
  final isCvvFocused = false.obs;
  final useGlassMorphism = false.obs;
  final useBackgroundImage = false.obs;
  OutlineInputBorder? border;
  final stringsss = ''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final count = 0.obs;
  final addCardLoader=false.obs;

  performEncryption() {
    print('''{
 "card_number": "${cardNumber.value}",
  "card_date": ${expiryDate.value},
  "card_cvc":"${cvvCode.value}"
  }''');

    stringsss.value = encryptAESCryptoJS(
        '{"card_number":"${cardNumber.value}","card_date":"${expiryDate.value.toString().replaceAll("/", "-")}","card_cvc":"${cvvCode.value}","cardHolderName":"${cardHolderName.value}"}'
            .toString()
            .trim());
    print("Card Details  : ${stringsss}");
    //print("Card Details  : ${decryptAESCryptoJS('{"card_number":"${cardNumber.value}","card_date":"${expiryDate.value.toString().replaceAll("/", "-")}","card_cvc":"${cvvCode.value}"}').toString().trim()}");
  }
  addCard() async {
    addCardLoader.value=true;
    try {
      performEncryption();
      String token = Get
          .find<GetStorageService>()
          .jwToken;

      final url = Endpoints.addCardDetails;
      var headers = {
        "accept": "application/json",
        "token": token,
        'Content-Type': 'application/json',
      };
      var body = {
        "code":stringsss.value
      };

      print(headers);
      final response = await http.post(
          Uri.parse(url), headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 ||response.statusCode == 201) {
        print("data ;;;;;;");
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var value = jsonDecode(response.body);
        Get.find<SavedCardsController>().fetchCardList();
        addCardLoader.value=false;
        Get.back();
        //userdetails.value=userDeteails.fromJson(value);


        // return Album.fromJson(jsonDecode(response.body));
      } else {
        //updateProfileLoade.value = false;
        /*Get.snackbar(
          "Message",
          "Failed to update profile",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );*/
        addCardLoader.value=false;
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception(
            'status code is ${response.statusCode} ${response.body}');
      }
    }catch(e){
      addCardLoader.value=false;
    }
  }


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

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

  void increment() => count.value++;

  void updateCardDetail() {}
}
