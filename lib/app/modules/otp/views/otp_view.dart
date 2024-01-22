import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autodetect/sms_autodetect.dart';
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

    if(!controller.checkTimer.value)
      controller.startTimer();
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
                style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 24.kh),
              ),
              SizedBox(
                height: 10.kh,
              ),
              RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style:  GoogleFonts.urbanist(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Check your SMS. We have sent you OTP at \n ',
                        style: GoogleFonts.urbanist(color: Colors.grey)),
                    new TextSpan(
                        text:
                            '${(controller.instanceOfOtpNeededData.mobileNumber).substring(0, 3)}*******${(controller.instanceOfOtpNeededData.mobileNumber).substring((controller.instanceOfOtpNeededData.mobileNumber).length - 3,(controller.instanceOfOtpNeededData.mobileNumber).length)}',
                        style:  GoogleFonts.urbanist(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 40.kh,
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                appContext: Get.context!,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 6) {
                    return "Please enter valid OTP";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  fieldOuterPadding: EdgeInsets.only(left: 2, right: 2),
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40.kh,
                  fieldWidth: 50.kw,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.black54,
                  selectedFillColor: Colors.white,
                  inactiveColor: Colors.black54,
                  activeColor: Colors.black54,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                autoDismissKeyboard: false,
                controller: controller.OTPController.value,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                  controller.smsCode.value = v.removeAllWhitespace;
                },
                onTap: () {
                  print("Pressed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
//               OtpTextField(
//                 // showFieldAsBox: true,
//                 numberOfFields: 6,
//                 borderColor: ColorUtil.kPrimary,
//                 focusedBorderColor: ColorUtil.kPrimary,
//                 //  styles: otpGoogleFonts.urbanists,
//                 showFieldAsBox: false,
//                 borderWidth: 3.0,
// //runs when a code is typed in
//                 onCodeChanged: (String code) {
// //handle validation or checks here if necessary
//                 },
// //runs when every textfield is filled
//                 onSubmit: (String verificationCode) {
//                   controller.smsCode.value = verificationCode;
//                 },
//               ),
              SizedBox(
                height: 30.kh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("I did not recieve a code ",
                      style: GoogleFonts.urbanist(color: Colors.grey)),
                  InkWell(
                      onTap: () {
                        Auth().verifyPhone(
                            controller.instanceOfOtpNeededData.mobileNumber,
                            false);
                        if(!(controller.timer.isActive))
                        controller.startTimer();
                      },
                      child: controller.reSendLoader.value == false
                          ? Text(
                              "Resend",
                              style: GoogleFonts.urbanist(
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "00:${controller.start.value}s",
                              style: GoogleFonts.urbanist(
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
