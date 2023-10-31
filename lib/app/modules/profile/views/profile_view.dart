import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/modules/settings/controllers/settings_controller.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/modules/widgets/date_of_birth_design.dart';
import 'package:zammacarsharing/app/modules/widgets/text_filed.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 950.kh,
          padding: EdgeInsets.all(16),
          child: Obx(
            () => controller.instanceOfGlobalData.loader.value == true
                ? Center(
                    child: SizedBox(
                        width: 200.kh,
                        height: 100.kh,
                        child: Lottie.asset('assets/json/car_loader.json')),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.kh,
                      ),
                      InkWell(
                          onTap: () {
                            Get.find<SettingsController>().onBoardingStatus();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 25.kh,
                      ),
                      Text(
                        "My details are",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold, fontSize: 24.kh),
                      ),
                      SizedBox(
                        height: 10.kh,
                      ),
                      Text(
                        "Enter your personal details",
                        style: GoogleFonts.urbanist(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30.kh,
                      ),
                      Center(
                        child: controller.profilestatus.value != 0
                            ? Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  maxRadius: 60,
                                  backgroundImage:
                                      FileImage(controller.pickedImage.value),
                                ),
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "${controller.logindetails.value.user?.image}",
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        backgroundColor: Colors.grey.shade50,
                                        maxRadius: 60,
                                        backgroundImage: imageProvider
                                        //  FileImage(controller.pickedImage.value),
                                        ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: CircleAvatar(
                                    // backgroundColor: Colors.grey,
                                    maxRadius: 60,
                                    // backgroundImage:imageProvider
                                    //  FileImage(controller.pickedImage.value),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.grey.shade50,
                                  maxRadius: 60,
                                  child: Lottie.asset(
                                      'assets/json/default_profile.json'),
                                  //  FileImage(controller.pickedImage.value),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 30.kh,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorUtil.kPrimary,
                          ),
                          onPressed: () {
                            // controller.pickImage();
                            //  Get.toNamed(Routes.OTP);
                            showModalBottomSheet<void>(
                              backgroundColor: Color(0x00FFFFFF),
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200.kh,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            controller.pickImage();
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                            height: 60.kh,
                                            width: double.infinity,
                                            child: Center(
                                                child: Text(
                                              "Photo Gallery",
                                              style: GoogleFonts.urbanist(
                                                color: Color(0xff007AFF),
                                                fontSize: 18,
                                              ),
                                            )),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.pickFromCamera();
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                            height: 60.kh,
                                            width: double.infinity,
                                            child: Center(
                                                child: Text("Camera",
                                                    style: GoogleFonts.urbanist(
                                                      color: Color(0xff007AFF),
                                                      fontSize: 18,
                                                    ))),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                            height: 60.kh,
                                            width: double.infinity,
                                            child: Center(
                                                child: Text(
                                              "Cancle",
                                              style: GoogleFonts.urbanist(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                  child: Text('    Upload photo')), // <-- Text
                              SizedBox(
                                width: 15.kw,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.kh,
                      ),
                      Text(
                        "Name",
                        style: GoogleFonts.urbanist(
                            fontSize: 16.kh, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.kh,
                      ),
                      Obx(
                        () => TextFieldDesign(
                          hintText: 'Enter your name as per driver’s licence',
                          controller: controller.nameController.value,
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.urbanist(
                            fontSize: 16.kh, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.kh,
                      ),
                      TextFieldDesign(
                        controller: controller.emailController.value,
                        hintText: 'Email id',
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Text(
                        "Date of birth",
                        style: GoogleFonts.urbanist(
                            fontSize: 16.kh, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.kh,
                      ),
                      DataOfBirthDesign(
                        dateController: controller.dateController.value,
                        monthController: controller.monthController.value,
                        yearController: controller.yearController.value,
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Text(
                        "Gender",
                        style: GoogleFonts.urbanist(
                            fontSize: 16.kh, fontWeight: FontWeight.bold),
                      ),

                      Row(
                        children: [
                          Row(
                            children: [
                              Transform.translate(
                                offset: Offset(-16, 0),
                                child: Radio(
                                    activeColor: ColorUtil.kPrimary,
                                    value: "male",
                                    groupValue: controller.gender.value,
                                    onChanged: (value) {
                                      controller.gender.value =
                                          value.toString();
                                    }),
                              ),
                              Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: const Text("Male"))
                            ],
                          ),
                          SizedBox(
                            width: 80.kw,
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: ColorUtil.kPrimary,
                                  value: "female",
                                  groupValue: controller.gender.value,
                                  onChanged: (value) {
                                    controller.gender.value =
                                        value.toString(); //selected value
                                  }),
                              const Text("Female")
                            ],
                          ),
                        ],
                      ),
                      // Spacer(),
                      SizedBox(
                        height: 16.kh,
                      ),
                      controller.updateProfile.value == true
                          ? Center(
                              child: SizedBox(
                                  width: 200.kh,
                                  height: 100.kh,
                                  child: Lottie.asset(
                                      'assets/json/car_loader.json')),
                            )
                          : ButtonDesign(
                              onPressed: () {
                                controller.userOnBoard().then((value) {
                                  if (value == 1) {
                                    Get.toNamed(
                                        Routes.PRE_LICENCE_VERIFICATION);
                                  } else {
                                    print("Some issue while onboarding");
                                  }
                                });
                              },
                              name: "Next"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
