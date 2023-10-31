import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/pre_licence_verification_controller.dart';

class PreLicenceVerificationView
    extends GetView<PreLicenceVerificationController> {
  const PreLicenceVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title:  Text(
            'Licence Verification',
            style: GoogleFonts.urbanist(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
             
              width: 340.kw,
              height: 287.kh,
             // color: Colors.black,
              child: Image.asset("assets/images/poster.png",fit: BoxFit.cover),
            ),
            SizedBox(height: 24.kh,),
            Text("Driver’s licence verification",style: GoogleFonts.urbanist(fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 8.kh,),
                Text("To start using Zamma Cars, your city requires us to verify your driver’s licence. Please scan your valid driver’s licence to proceed",style: GoogleFonts.urbanist(color: ColorUtil.ZammaGrey),),
                Spacer(),
                ButtonDesign(name: "Next",onPressed: (){
                  Get.toNamed(Routes.LICENCE_VERIFICATION_FORM);
                }),
          ]),
        ));
  }
}
