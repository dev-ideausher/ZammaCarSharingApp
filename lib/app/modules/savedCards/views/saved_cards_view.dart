import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/modules/booking/controllers/booking_controller.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

import '../controllers/saved_cards_controller.dart';

class SavedCardsView extends GetView<SavedCardsController> {
  const SavedCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:() async {
      controller.cancelBooking();
      return true;
    },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorUtil.kPrimary,
          onPressed: () {
            // Add your onPressed code here!
            Get.toNamed(Routes.INPUT_CARD_DETAILS);
          },
          icon: Icon(Icons.add_card),
          label: Text("Add your card details"),
        ),

        /*FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Get.toNamed(Routes.INPUT_CARD_DETAILS);
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:  Text(
            'Cards',
            style: GoogleFonts.urbanist(color: Colors.black),

          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [],
        ),
        body: Obx(
          () => controller.loader.value == true
              ? Center(
                  child: SizedBox(
                    width: 200.kh,
                    height: 100.kh,
                    child: Lottie.asset('assets/json/car_loader.json'),
                  ),
                )
              : controller.totalSavedCard.value == 0
                  ? Container(
                      child: Center(
                        child: SizedBox(
                            height: 150.kh,
                            width: 150.kh,
                            child: SvgPicture.asset(
                                "assets/icons/NoCardAvailable.svg")),
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          controller.savedCardsresponse.value.cards?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async{


                           await controller.payViaCard(index).then((value) {
                              if (value == 1) {
                                if (controller.model == "End")
                                {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(
                                              0, 8.kh, 0, 0),
                                          content: Container(
                                            height: 250.kh,
                                            child: Column(children: [

                                              Column(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    padding: EdgeInsets.all(35),
                                                    decoration: BoxDecoration(
                                                      //  color: themeColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      "assets/images/card.png",
                                                      fit: BoxFit.contain,color: ColorUtil.kPrimary,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Your \$${controller.amount} payment completed successfully.",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.urbanist(fontWeight:
                                                    FontWeight.bold,
                                                        fontSize: 20.kh),

                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                          actionsPadding: EdgeInsets.all(0),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      //Get.back();
                                                      Get.offAllNamed(Routes.HOME);

                                                    },
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        color: ColorUtil
                                                            .kPrimary,
                                                        borderRadius:
                                                        BorderRadius.only(bottomLeft: Radius.circular(
                                                            10),
                                                            bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                      height: 56.kh,
                                                      child: Center(
                                                        child: Text(
                                                          "Home",
                                                          style: GoogleFonts.urbanist(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              16.kh),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });

                                }
                                else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(
                                              0, 8.kh, 0, 0),
                                          content: Container(
                                            height: 250.kh,
                                            child: Column(children: [

                                              Column(
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    padding: EdgeInsets.all(35),
                                                    decoration: BoxDecoration(
                                                      //  color: themeColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      "assets/images/card.png",
                                                      fit: BoxFit.contain,color: ColorUtil.kPrimary,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Your \$${controller.amount} payment completed successfully.",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.urbanist(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 20.kh),
                                                  ),
                                                  SizedBox(height: 5.kh,),
                                                  Text(
                                                    "Enjoy your trip!",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.urbanist(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: ColorUtil.kPrimary,
                                                        fontSize: 20.kh),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                          actionsPadding: EdgeInsets.all(0),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Get.back();
                                                      // Get.offAllNamed(Routes.HOME);
                                                      controller.cancelBooking().then((value){
                                                        if(value==1){
                                                          Get.back();
                                                          Get.offAllNamed(Routes.HOME);
                                                        }
                                                      });

                                                    },
                                                    child: Container(
                                                      height: 56.kh,
                                                      child: Center(
                                                        child: Text(
                                                          "Cancel Ride",
                                                          style: GoogleFonts.urbanist(
                                                              color: ColorUtil
                                                                  .kPrimary,
                                                              fontSize:
                                                              16.kh),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      Get.back();
                                                      Get.offNamed(Routes.BOOKING, arguments: [
                                                        (controller.bookingId),
                                                        (controller.model),
                                                        (controller.seetCapacity),
                                                        controller.boolvale
                                                      ]);

                                                    },
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        color: ColorUtil
                                                            .kPrimary,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                      height: 56.kh,
                                                      child: Center(
                                                        child: Text(
                                                          "Continue ride",
                                                          style: GoogleFonts.urbanist(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              16.kh),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });


                                }
                              } else {
                        //          controller.cancelBooking().then((value){
                        //   if(value==1){
                        //     Get.back();
                        //   }
                        // });
                                print("problem while making payment");
                              }
                            });
                          },
                          child: CreditCardWidget(
                            cardNumber: controller.cardList.value[index].cardNumber,
                            expiryDate: controller.cardList.value[index].cardDate,
                            cardHolderName: controller
                                        .cardList.value[index].cardHolderName ==
                                    null
                                ? ""
                                : controller.cardList.value[index].cardHolderName,
                            cvvCode: controller.cardList.value[index].cardCvc,
                            //  labelCardHolder: "",
                            obscureCardNumber: false,
                            backgroundImage: "assets/images/logo.png",
                            cardBgColor: ColorUtil.kPrimary,
                            isSwipeGestureEnabled: true,
                            isHolderNameVisible: true,
                            isChipVisible: true,
                            obscureCardCvv: false,
                            showBackView: false,
                            onCreditCardWidgetChange:
                                (CreditCardBrand) {}, //true when you want to show cvv(back) view
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
