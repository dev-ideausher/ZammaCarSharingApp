import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/auth.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.kh,
              ),
              Text(
                "My OTP is",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.kh),
              ),
              SizedBox(
                height: 10.kh,
              ),
              RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Check your SMS. We have sent you OTP at \n ',
                        style: TextStyle(color: Colors.grey)),
                    new TextSpan(
                        text:
                            '${controller.instanceOfOtpNeededData.mobileNumber}',
                        style: new TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 10.kh,
              ),
              OtpTextField(
                // showFieldAsBox: true,
                numberOfFields: 6,
                borderColor: ColorUtil.kPrimary,
                focusedBorderColor: ColorUtil.kPrimary,
                //  styles: otpTextStyles,
                showFieldAsBox: false,
                borderWidth: 3.0,
//runs when a code is typed in
                onCodeChanged: (String code) {
//handle validation or checks here if necessary
                },
//runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  controller.smsCode.value = verificationCode;
                },
              ),
              SizedBox(
                height: 30.kh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("I did not recieve a code ",
                      style: TextStyle(color: Colors.grey)),
                  InkWell(
                      onTap: () {
                        Auth().verifyPhone(
                            controller.instanceOfOtpNeededData.mobileNumber,
                            false);
                        controller.startTimer();
                      },
                      child: controller.reSendLoader.value == false
                          ? Text(
                              "Resend",
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "00:${controller.start.value}s",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.red),
                            ))
                ],
              ),
              Spacer(),
              controller.instanceOfGlobalData.loader.value == true
                  ? Center(
                      child: SizedBox(
                        width: 200.kh,
                        height: 100.kh,
                        child: Lottie.asset('assets/json/car_loader.json'),
                      ),
                    )
                  : ButtonDesign(
                      onPressed: () {
                        controller.verifyOtp();
                      },
                      name: "Next",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
