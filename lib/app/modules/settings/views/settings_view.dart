import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/auth.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:zammacarsharing/app/services/globalData.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Obx(
          () => controller.instanceOfGlobalData.loader.value == true
              ? Center(
                  child: SizedBox(
                    width: 200.kh,
                    height: 100.kh,
                    child: Lottie.asset('assets/json/car_loader.json'),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 8.kh,
                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value ==
                            true
                        ? Container(
                            padding: EdgeInsets.all(16),
                            height: 200.kh,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hey, ${controller.logindetails.value.user?.name}",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 150.kw,
                                      height: 104.kh,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtil.ZammaGrey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                      ),
                                      child: Column(children: [
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/carIcon.svg"),
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        Text(
                                          "${controller.logindetails.value.user?.noOfRides}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        Text(
                                          "Rides",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff666666)),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      width: 150.kw,
                                      height: 104.kh,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtil.ZammaGrey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                      ),
                                      child: Column(children: [
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/location.svg"),
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        Text(
                                          "${controller.logindetails.value.user?.totalTravelKm}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 6.kh,
                                        ),
                                        Text(
                                          "Kilometers",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff666666)),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                        : Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                width: double.infinity,
                                height: 90.kh,
                                color: Colors.white,
                                child: Text(
                                  "Welcome, User",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32.kh,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 3.kh,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  width: double.infinity,
                                  height: 80.kh,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sign up!",
                                        style: TextStyle(
                                            color: ColorUtil.kPrimary,
                                            fontSize: 16.kh,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8.kh,
                                      ),
                                      Text(
                                        "Please register to book cars ",
                                        style: TextStyle(
                                          color: ColorUtil.ZammaGrey,
                                          fontSize: 14.kh,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 8.kh,
                    ),
                    ListTile(onTap: (){
                      if(controller.instanceOfGlobalData.isloginStatusGlobal.value == true){

                      Get.toNamed(Routes.PROFILE);
                      }else{
                        Get.toNamed(Routes.LOGIN);
                      }
                    },
                        leading:
                            SvgPicture.asset("assets/icons/profileSetting.svg"),
                        title: Transform.translate(
                            offset: Offset(-16, 0),
                            child: Text(
                              "Profile setting",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.kh,
                              ),
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                        tileColor: Colors.white),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true?  SizedBox(
                      height: 3.kh,
                    ):SizedBox(

                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true? InkWell(
                      onTap: () {

                          Get.toNamed(Routes.DOCUMENT_TYPE_LIST);
                         // Get.toNamed(Routes.VIEW_LICENCE);

                      },
                      child: ListTile(
                          leading: SvgPicture.asset("assets/icons/help.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 0),
                              child: Text(
                                "View Documents",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.kh,
                                ),
                              ),),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Colors.white),
                    ):SizedBox(),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true?  SizedBox(
                      height: 3.kh,
                    ):SizedBox(

                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true? InkWell(
                      onTap: () {
                        Get.toNamed(Routes.RIDE_HISTORY);
                      },
                      child: ListTile(
                          leading:
                              SvgPicture.asset("assets/icons/rideHistory.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 0),
                              child: Text(
                                "Ride History",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.kh,
                                ),
                              )),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Colors.white),
                    ):SizedBox(
                      height: 3.kh,
                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true?  SizedBox(
                      height: 3.kh,
                    ):SizedBox(

                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value == true? ListTile(
                        leading: SvgPicture.asset("assets/icons/payment.svg"),
                        title: Transform.translate(
                            offset: Offset(-16, 0),
                            child: Text(
                              "Payments",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.kh,
                              ),
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                        tileColor: Colors.white):SizedBox(
                      height: 3.kh,
                    ),
                    SizedBox(
                      height: 3.kh,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.HELP);
                      },
                      child: ListTile(
                          leading: SvgPicture.asset("assets/icons/help.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 0),
                              child: Text(
                                "Help",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.kh,
                                ),
                              )),
                          trailing: Icon(Icons.arrow_forward_ios),
                          tileColor: Colors.white),
                    ),
                    SizedBox(
                      height: 3.kh,
                    ),
                    controller.instanceOfGlobalData.isloginStatusGlobal.value ==
                            true
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
                                      content: Container(
                                        height: 100.kh,
                                        child: Column(children: [
                                          SizedBox(
                                            height: 20.kh,
                                          ),
                                          Text(
                                            "Are you sure want to \n logout ?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.kh),
                                          ),
                                        ]),
                                      ),
                                      actionsPadding: EdgeInsets.all(0),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 56.kh,
                                                  child: Center(
                                                    child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          color: ColorUtil
                                                              .kPrimary,
                                                          fontSize: 16.kh),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  /* controller.onBoardingStatus.value=false;
                                      Get.find<GetStorageService>().deleteLocation();
                                      Get.find<TokenCreateGenrate>().signOut();*/

                                                  await controller
                                                      .LogoutAnDeleteEveryThing();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorUtil.kPrimary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  height: 56.kh,
                                                  child: Center(
                                                    child: Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.kh),
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
                            },
                            child: ListTile(
                                leading:
                                    SvgPicture.asset("assets/icons/logout.svg"),
                                title: Transform.translate(
                                    offset: Offset(-16, 0),
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.kh,
                                      ),
                                    )),
                                trailing: Icon(Icons.arrow_forward_ios),
                                tileColor: Colors.white),
                          )
                        : SizedBox(),
                    Spacer(),
                    Column(
                      children: [
                        Text("Version 1.0",
                            style: TextStyle(color: ColorUtil.ZammaGrey)),
                        SizedBox(
                          height: 8.kh,
                        ),
                        Text(
                          "Developed by Idea Usher",
                          style: TextStyle(color: Color(0xff6B4EFF)),
                        ),
                        SizedBox(
                          height: 20.kh,
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
