import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/total_payment_controller.dart';

class TotalPaymentView extends GetView<TotalPaymentController> {
  const TotalPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        elevation: 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Payments',
          style: GoogleFonts.urbanist( color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loader.value==true?Center(
          child: SizedBox(
              width: 200.kh,
              height: 100.kh,
              child: Lottie.asset('assets/json/car_loader.json')),
        ):controller.nuberOfPayment.value>0?ListView.builder(
          itemCount: controller.totalPayment.value.data?.length,
          itemBuilder: (context, index) {
            controller.convertDateTime(controller.totalPayment.value.data?[index]?.createdAt);
            return Card(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                      text:' ${controller.outputDate.value} ',
                      style: GoogleFonts.urbanist(color: ColorUtil.kPrimary,fontWeight: FontWeight.bold, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          /*text: '${controller.totalPayment.value.data?[index]?.transactionId}',*/
                          style:
                          GoogleFonts.urbanist(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                ),
                subtitle:Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,10),
                  child: RichText(
                    text: TextSpan(
                        text:' Payment Id : ',
                        style: GoogleFonts.urbanist(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text:' ${controller.totalPayment.value.data?[index]?.transactionId} ', //'${controller.totalPayment.value.data?[index]?.amount}',
                            style:
                            GoogleFonts.urbanist(color: Colors.grey, fontSize: 18),
                          )
                        ]),
                  ),
                ),
                trailing: RichText(
                  text: TextSpan(
                      text:'-\$ ${controller.totalPayment.value.data?[index]?.amount} ',
                      style: GoogleFonts.urbanist(color: Color(0xff008000),fontWeight: FontWeight.bold, fontSize: 24),
                      children: <TextSpan>[
                        TextSpan(
                          /*text: '${controller.totalPayment.value.data?[index]?.transactionId}',*/
                          style:
                          GoogleFonts.urbanist(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                ),
              ),
            );
          },
        ):Center(child: Text("no payment details available !"),)
      ),
    );
  }
}
