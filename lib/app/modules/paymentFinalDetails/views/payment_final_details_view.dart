import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/payment_final_details_controller.dart';

class PaymentFinalDetailsView extends GetView<PaymentFinalDetailsController> {
  const PaymentFinalDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentFinalDetailsController()).onInit();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // 2
        elevation: 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Payments Details',
          style: GoogleFonts.urbanist(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loader.value == true ?  Center(
          child: SizedBox(
              width: 200.kh,
              height: 100.kh,
              child: Lottie.asset('assets/json/car_loader.json')),
        ):Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
              20.kheightBox,
              Row(
                children: [
                  Text(
                    "Amount",
                    style: GoogleFonts.urbanist(
                        color: ColorUtil.kPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Spacer(),
                  Center(
                    child: Text('${controller.payments.value.amount}',
                        style: GoogleFonts.urbanist(
                            color: ColorUtil.kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),

              // 10.kheightBox,
              // Row(
              //   children: [
              //     Text(
              //       "Booking time",
              //       style: GoogleFonts.urbanist(
              //           color: ColorUtil.kPrimary,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16),
              //     ),
              //     Spacer(),
              //     Center(
              //       child: Text(
              //           '${controller.payments.value.bookingPaymentObject!.time}',
              //           style: GoogleFonts.urbanist(
              //               color: ColorUtil.kPrimary,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16)),
              //     ),
              //   ],
              // ),
              10.kheightBox,
              Row(
                children: [
                  Text(
                    "Booking plan",
                    style: GoogleFonts.urbanist(
                        color: ColorUtil.kPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Spacer(),
                  Center(
                    child: Text('${controller.payments.value.bookingPlan}',
                        style: GoogleFonts.urbanist(
                            color: ColorUtil.kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),
              10.kheightBox,
              Row(
                children: [
                  Text(
                    "Transaction Id",
                    style: GoogleFonts.urbanist(
                        color: ColorUtil.kPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Spacer(),
                  Center(
                    child: Text('${controller.payments.value.transactionId}',
                        style: GoogleFonts.urbanist(
                            color: ColorUtil.kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),
              10.kheightBox,
              Row(
                children: [
                  Text(
                    "Tax",
                    style: GoogleFonts.urbanist(
                        color: ColorUtil.kPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                        '${controller.payments.value.bookingPaymentObject!.tax}',
                        style: GoogleFonts.urbanist(
                            color: ColorUtil.kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),
              // 10.kheightBox,
              // Row(
              //   children: [
              //     Text("Mile",style: GoogleFonts.urbanist(color: ColorUtil.kPrimary,fontWeight: FontWeight.bold, fontSize: 16),),
              //     Spacer(),
              //     Center(
              //       child: Text(
              //           '${controller.payments.value.bookingPaymentObject!.mile}',
              //           style: GoogleFonts.urbanist(color: ColorUtil.kPrimary,fontWeight: FontWeight.bold, fontSize: 16)
              //       ),
              //     ),
              //
              //   ],
              // ),
              // 10.kheightBox,
              // Row(
              //   children: [
              //     Text(
              //       "Total travel Time",
              //       style: GoogleFonts.urbanist(
              //           color: ColorUtil.kPrimary,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16),
              //     ),
              //     Spacer(),
              //     Center(
              //       child: Text(
              //           '${controller.payments.value.bookingPaymentObject!.time}',
              //           style: GoogleFonts.urbanist(
              //               color: ColorUtil.kPrimary,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16)),
              //     ),
              //   ],
              // ),

              20.kheightBox,
              Row(
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.urbanist(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Spacer(),
                  Center(
                    child: Text('\$ ${controller.payments.value.amount}',
                        style: GoogleFonts.urbanist(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
