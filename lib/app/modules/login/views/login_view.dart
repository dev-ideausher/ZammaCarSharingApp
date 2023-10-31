import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: InkWell(onTap: (){
        //  Get.find<SettingsController>().fetchLoginData();
        Navigator.pop(context);
      },
          child: Icon(Icons.arrow_back,color: Colors.black,)
      ),backgroundColor: Colors.white,elevation: 0.0,),
      body: Container(
          padding: EdgeInsets.all(16),
          child:
              Obx(()=>
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "My phone number is",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 24.kh),
                    ),
                    SizedBox(
                      height: 10.kh,
                    ),
                    Text(
                      "we will text a code to verify your number",
                      style: GoogleFonts.urbanist(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 27.kh,
                    ),
                    Container(
                      width: 343.kw,
                      height: 80.kh,
                      child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.white),
                        child: IntlPhoneField(
                          dropdownTextStyle: GoogleFonts.urbanist(color: Colors.black),
                          cursorColor: Colors.white,
                          style: GoogleFonts.urbanist(
                            //fontFamily: 'Montserrat-Regular',
                            //fontSize: 1.kh,
                            color: Colors.black,
                          ),
                          //autofocus: false,
                          // style: GoogleFonts.urbanist(color: Colors.white),
                          //   controller:controller.textEditingController.value,
                          flagsButtonPadding: EdgeInsets.only(top: 10, bottom: 10, left: 12),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                           // hintText: 'Mobile Number',
                            hintStyle: GoogleFonts.urbanist(color: Colors.black),
                            contentPadding: EdgeInsets.only(left: 14.0, bottom: 14.0, top: 18.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: ColorUtil.ZammaGrey),
                            ),
                            // enabledBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: Color.fromRGBO(
                            //           255, 255, 255, 0.28)),
                            //
                            // ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {

                           controller.mobileNumber.value=phone.completeNumber;

                            ///  print("completeNumber: ${controller.finalNumber.value}");
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.kh,),
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style:  GoogleFonts.urbanist(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'By continuing you agree to our ',style: GoogleFonts.urbanist(color: Colors.grey)),
                          new TextSpan(text: 'Terms of Service ', style: GoogleFonts.urbanist(color: ColorUtil.kPrimary,decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                          new TextSpan(text: 'and ',style: GoogleFonts.urbanist(color: Colors.grey)),
                          new TextSpan(text: 'Privacy Policy', style:  GoogleFonts.urbanist(color: ColorUtil.kPrimary,decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    Spacer(),
                   controller.instanceOfGlobalData.loader.value==true?Center(child: SizedBox(width: 200.kh,height: 100.kh,child: Lottie.asset('assets/json/car_loader.json'))): ButtonDesign(onPressed: (){
                      controller.getOtpFunction();

                    },name: "Next",),


                  ],

          ),
              )),
    );
  }
}
