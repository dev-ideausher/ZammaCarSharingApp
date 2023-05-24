import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/input_card_details_controller.dart';

class InputCardDetailsView extends GetView<InputCardDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap: (){
        //  Get.find<SettingsController>().fetchLoginData();

        Navigator.pop(context);
      },
          child: Icon(Icons.arrow_back,color: Colors.black,)
      ),backgroundColor: Colors.white,elevation: 0.0,),
      body: Obx(
            () => Column(
          children: [

            CreditCardWidget(
              cardBgColor: ColorUtil.kPrimary,
              glassmorphismConfig: controller.useGlassMorphism.value ? Glassmorphism.defaultConfig() : null,
              cardNumber: controller.cardNumber.value,
              expiryDate: controller.expiryDate.value,
              cardHolderName: controller.cardHolderName.value,
              cvvCode: controller.cvvCode.value,
              showBackView: controller.isCvvFocused.value,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              // cardBgColor: ColorUtil.appPrimery,
              // backgroundImage:
              // controller.useBackgroundImage.value ? 'assets/card_bg.png' : null,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                // CustomCardTypeIcon(
                //   cardType: CardType.mastercard,
                //   cardImage: Image.asset(
                //     'assets/mastercard.png',
                //     height: 48,
                //     width: 48,
                //   ),
                // ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(

                        formKey: controller.formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: controller.cardNumber.value,
                        cvvCode: controller.cvvCode.value,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: controller.cardHolderName.value,
                        expiryDate: controller.expiryDate.value,
                        themeColor: ColorUtil.kPrimary,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: ColorUtil.kPrimary),
                          alignLabelWithHint: true,
                          enabled: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorUtil.kPrimary, width: 2),
                          ),
                        ),
                        expiryDateDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: ColorUtil.kPrimary),
                          alignLabelWithHint: true,
                          enabled: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorUtil.kPrimary, width: 2),
                          ),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: ColorUtil.kPrimary),
                          alignLabelWithHint: true,
                          enabled: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorUtil.kPrimary, width: 2),
                          ),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: ColorUtil.kPrimary),
                          alignLabelWithHint: true,
                          enabled: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorUtil.kPrimary, width: 2),
                          ),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: controller.onCreditCardModelChange,
                      ),
                      SizedBox(
                        height: 50.kh,
                      ),
                      SizedBox(width: double.infinity, // <-- match_parent

                        child: controller.addCardLoader.value==true?Center(child: Center(
                          child: SizedBox(
                            width: 200.kh,
                            height: 100.kh,
                            child: Lottie.asset('assets/json/car_loader.json'),
                          ),
                        ),):Padding(
                          padding: const EdgeInsets.fromLTRB(16,16,16,0),
                          child: ElevatedButton(style: ElevatedButton.styleFrom(
                            primary: ColorUtil.kPrimary, // background
                            onPrimary: Colors.white, // foreground
                          ),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ADD CARD'),
                            ),
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                print('valid!');
                                controller.addCard();
                              } else {
                                print('invalid!');
                              }
                            },
                          ),
                        ),
                      ),
                      /* Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: controller.loader.value == true
                            ? CircularProgressIndicator()
                            : ElevatedButton(style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                          child: Text(
                            "ADD",

                          ),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              print('valid!');
                              controller.addCard();
                            } else {
                              print('invalid!');
                            }
                          },

                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
