import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 70.kh,
          width: 250.kw,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  SizedBox(child: Lottie.asset('assets/json/car_loader.json')),
            ),
            SizedBox(
              width: 10.kw,
            ),
             Obx(()=>
                Text(
                "${controller.lodingMsg.value}",
                style: TextStyle(fontSize: 16),
            ),
             ),
          ]),
        )),
        child: Container(
          child: Obx(
            () => Stack(
              children: [
                Container(
                  height: 800.kh,
                  color: Colors.blue,
                  child: GoogleMap(
                    onMapCreated: (mapController) {
                      //  controller.mapCompleter.complete(mapController);
                    },
                    //  markers: controller.listOfMarker,
                    initialCameraPosition: CameraPosition(
                      target: controller.center,
                      zoom: 11.0,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(32, 32, 32, 0.54),
                      Color.fromRGBO(27, 27, 27, 0),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 50, 0, 0),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                controller.carBooking.value == true
                    ? carBooking(0.7)
                    : SizedBox(),
                controller.carInspection.value == true
                    ? carInspection(0.9)
                    : SizedBox(),
                controller.rideStart.value == true
                    ? rideStart(0.75)
                    : SizedBox(),
                controller.endrideInspection.value == true
                    ? endrideInspection(0.85)
                    : SizedBox(),
                controller.bookingPriceDetails.value == true
                    ? bookingPriceDetails(0.7)
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carBooking(double initialVal) {
    /*  if (!controller.checkTimer.value) controller.startTimer();*/
    if (!Get.find<GlobalData>().checkTimer.value)
      Get.find<GlobalData>().startTimer();
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 600.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      height: 2,
                      width: 100.kw,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 0, 0),
                      child: Column(
                        children: [
                          Text("Free Waiting",
                              style: TextStyle(color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              //  "${controller.minute.value}:${controller.start.value}",
                              "${Get.find<GlobalData>().minute.value}:${Get.find<GlobalData>().start.value}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.kh,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 500.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                          height: 100.kh,
                          width: 260.kw,
                          child: Center(
                            child: Image.asset("assets/images/bigCars.png"),
                          ),
                        ),
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                            height: 35.kh,
                            width: 165.kw,
                            decoration: BoxDecoration(
                              color: ColorUtil.kPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                              "${controller.model}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/battery.svg"),
                                Text(
                                  "320 KM%",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 35.kh,
                                width: 100.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/controlone.svg",
                                      color: Color(0xFF5F5F5F),
                                    ),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    Text(
                                      "Control 1",
                                      style: TextStyle(
                                        color: Color(0xFF5F5F5F),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                height: 35.kh,
                                width: 100.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/controltwo.svg",
                                      color: Color(0xFF5F5F5F),
                                    ),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    Text(
                                      "Control 2",
                                      style: TextStyle(
                                        color: Color(0xFF5F5F5F),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        SizedBox(
                          height: 44.kh,
                        ),

                        Obx(
                          () => controller.instanceOfGlobalData.loader.value ==
                                  true
                              ? Center(
                                  child: SizedBox(),
                                )
                              : ButtonDesign(
                                  name: "Verify and Inspect",
                                  onPressed: () {
                                    controller
                                        .qrBarCodeScannerDialogPlugin.value
                                        .getScannedQrBarCode(
                                            context: context,
                                            onCode: (code) {
                                              controller.code.value =
                                                  code.toString();
                                              print("qr code: ${controller.code.value}");
                                              if (controller.code.value ==
                                                  controller.instanceOfGlobalData.QNR.value) {
                                                showMySnackbar(title: "Symbol Drive", msg: "Verified successfully");
                                                print("if qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");
                                                controller.carInspection.value = true;
                                              }
                                              else{
                                                showMySnackbar(title: "Error", msg: "You have not booked this car");
                                                print("else qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");

                                                //   controller.carInspection.value = true;
                                              }
                                            });

                                  }),
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: Obx(
                            () => controller
                                        .instanceOfGlobalData.loader.value ==
                                    true
                                ? Center(
                                    child: SizedBox(
                                        width: 344.kw,
                                        height: 100.kh,
                                        child: Lottie.asset(
                                            'assets/json/car_loader.json')),
                                  )
                                : OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.5,
                                          color: ColorUtil.kPrimary),
                                    ),
                                    label: Text('Cancel a trip',
                                        style: TextStyle(
                                            color: ColorUtil.kPrimary)),
                                    icon: SvgPicture.asset(
                                        "assets/icons/canclebuttonicon.svg"),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
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
                                                height: 100.kh,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 20.kh,
                                                  ),
                                                  Text(
                                                    "Are you sure want to cancel this ride?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.kh),
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 56.kh,
                                                          child: Center(
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
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
                                                          controller
                                                              .cancelBooking()
                                                              .then((value) {
                                                            Get.offNamed(
                                                                Routes.HOME);
                                                          });

                                                          Navigator.pop(
                                                              context);
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
                                                              "Yes, cancel ride",
                                                              style: TextStyle(
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
                                    },
                                  ),
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
              /*  Positioned(bottom: 0,
                //alignment: FractionalOffset.topCenter,
                child: Container(
                  child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }

  Widget carInspection(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 750.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      height: 2,
                      width: 100.kw,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                  // fontSize: 24.kh,
                                  color: ColorUtil.ZammaBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                controller.carInspection.value = false;
                                Scaffold.of(context).showBodyScrim(false, 0.0);
                              },
                              child: SvgPicture.asset("assets/icons/cross.svg",
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Column(
                        children: [
                          Text("Free Waitig",
                              style: TextStyle(color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => controller.loader.value == true
                                ? CircularProgressIndicator()
                                : Text(
                                    "${controller.instanceOfGlobalData.minute.value}:${controller.instanceOfGlobalData.start.value}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.kh,
                                        color: Colors.white),
                                  ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.kh),
                  height: 600.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.kh,
                        ),
                        Text(
                          "Click respective side of images",
                          style: TextStyle(fontSize: 16.kh),
                        ),
                        SizedBox(
                          height: 24.kh,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {

                                        controller.pickFromCamera("front");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.frontHood.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Front hood",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("leftside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.leftSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Left Side",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("rightside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.rightSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Right Side",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("backside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.backSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Back Side",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 40.kh,
                        ),

                        Obx(
                          () => controller.instanceOfGlobalData.loader.value ==
                                  true
                              ? Center(
                                  child: SizedBox(
                                      width: 200.kh,
                                      height: 56.kh,
                                      child: Lottie.asset(
                                          'assets/json/car_loader.json')),
                                )
                              : ButtonDesign(
                                  name: "Done",
                                  onPressed: () {
                                    controller
                                        .uploadInspectionImage("S")
                                        .then((value) {
                                      if (value == 1) {
                                        context.loaderOverlay.show();
                                        controller
                                            .putImoblizerUnlock("unlocked")
                                            .then((value) {
                                          if (value != "locked") {
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              context.loaderOverlay.hide();
                                              controller.rideStart.value = true;
                                              controller.carInspection.value =
                                                  false;
                                            });
                                          }
                                        });
                                      } else {
                                        showMySnackbar(
                                            title: "Error",
                                            msg: "Error while inspection");
                                      }
                                    });
                                    //controller.rideStart.value = true;
                                  }),
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: Obx(
                            () => controller
                                        .instanceOfGlobalData.loader.value ==
                                    true
                                ? Center(
                                    child: SizedBox(),
                                  )
                                : OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.5,
                                          color: ColorUtil.kPrimary),
                                    ),
                                    label: Text('Cancel a trip',
                                        style: TextStyle(
                                            color: ColorUtil.kPrimary)),
                                    icon: SvgPicture.asset(
                                        "assets/icons/canclebuttonicon.svg"),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
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
                                                height: 100.kh,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 20.kh,
                                                  ),
                                                  Text(
                                                    "Are you sure want to cancel this ride?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.kh),
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 56.kh,
                                                          child: Center(
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
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
                                                          controller
                                                              .cancelBooking()
                                                              .then((value) {
                                                            Get.offNamed(
                                                                Routes.HOME);
                                                          });

                                                          Navigator.pop(
                                                              context);
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
                                                              "Yes, cancel ride",
                                                              style: TextStyle(
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
                                    },
                                  ),
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
              /*  Positioned(bottom: 0,
                //alignment: FractionalOffset.topCenter,
                child: Container(
                  child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }

  Widget rideStart(double initialVal) {
    if (!controller.instanceOfGlobalData.checkRideTimer.value)
      controller.instanceOfGlobalData.rideTimer();
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 0.75,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 750.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      height: 2,
                      width: 100.kw,
                      color: Colors.white,
                    )),
                    /*Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                // fontSize: 24.kh,
                                  color: ColorUtil.ZammaBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                               // controller.rideStart.value = false;
                                Scaffold.of(context).showBodyScrim(false, 0.0);
                              },
                              child: SvgPicture.asset("assets/icons/cross.svg",
                                  color: Colors.white),
                            ),
                          ]),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 0, 0),
                      child: Column(
                        children: [
                          Text("Onging Trip",
                              style: TextStyle(color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.kh,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 650.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                          height: 100.kh,
                          width: 260.kw,
                          child: Center(
                            child: Image.asset("assets/images/bigCars.png"),
                          ),
                        ),
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                            height: 35.kh,
                            width: 165.kw,
                            decoration: BoxDecoration(
                              color: ColorUtil.kPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                              "${controller.model}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/battery.svg"),
                                Text(
                                  "320 KM%",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Obx(()=>controller.imoblizerUnlockLoader.value==true?SizedBox(
                            //     width: 40.kh,
                            //     height: 40.kh,
                            //     child: Lottie.asset(
                            //         'assets/json/car_loader.json')):
                            //    Column(
                            //     children: [
                            //       InkWell(onTap: (){
                            //         if(controller.imoblizerStatus.value.state=="locked"){
                            //           controller.putImoblizerUnlock("unlocked");
                            //         }else{
                            //           showMySnackbar(title: "Msg", msg: "Already Unlocked Imoblizer Lock");
                            //         }
                            //
                            //       },child: Icon(Icons.lock_open_outlined,color: controller.imoblizerStatus.value.state=="locked"?ColorUtil.kPrimary:ColorUtil.ZammaGrey,size: 44.kh)),
                            //     Text("Unlock \n Immobilizer",textAlign: TextAlign.center)
                            //     ],
                            //   ),
                            // ),
                            //   Obx(()=>controller.imoblizerLockLoader.value==true?SizedBox(
                            //       width: 40.kh,
                            //       height: 40.kh,
                            //       child: Lottie.asset(
                            //           'assets/json/car_loader.json')):
                            //       Column(
                            //       children: [
                            //          InkWell(onTap: (){
                            //            if(controller.imoblizerStatus.value.state=="locked"){
                            //              showMySnackbar(title: "Msg", msg: "Already Immobilizer");
                            //            }else{
                            //              controller.putImoblizerLock("locked");
                            //            }
                            //         },child: Icon(Icons.lock_outline,color: controller.imoblizerStatus.value.state=="locked"?ColorUtil.ZammaGrey:ColorUtil.kPrimary,size: 44.kh)),
                            //         Text("Lock \n Immobilizer",textAlign: TextAlign.center)
                            //       ],
                            //     ),
                            //   ),
                            Obx(
                              () => controller.UnlockLoader.value == true
                                  ? SizedBox(
                                      width: 40.kh,
                                      height: 40.kh,
                                      child: Lottie.asset(
                                          'assets/json/car_loader.json'))
                                  : Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (controller
                                                      .lockModel.value.state ==
                                                  "locked") {
                                                controller
                                                    .putUnlock("unlocked");
                                              } else {
                                                showMySnackbar(
                                                    title: "Msg",
                                                    msg:
                                                        "Already Unlocked Central Lock");
                                              }
                                            },
                                            child: Icon(
                                                Icons.lock_open_outlined,
                                                color: controller.lockModel
                                                            .value.state ==
                                                        "locked"
                                                    ? ColorUtil.kPrimary
                                                    : ColorUtil.ZammaGrey,
                                                size: 44.kh)),
                                        Text("Unlock Central \n Lock",
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                            ),
                            Obx(
                              () => controller.lockLoader.value == true
                                  ? SizedBox(
                                      width: 40.kh,
                                      height: 40.kh,
                                      child: Lottie.asset(
                                          'assets/json/car_loader.json'))
                                  : Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (controller
                                                      .lockModel.value.state ==
                                                  "locked") {
                                                showMySnackbar(
                                                    title: "Msg",
                                                    msg:
                                                        "Already locked Central Lock");
                                              } else {
                                                controller.putLock("locked");
                                              }
                                            },
                                            child: Icon(Icons.lock_outline,
                                                color: controller.lockModel
                                                            .value.state ==
                                                        "locked"
                                                    ? ColorUtil.ZammaGrey
                                                    : ColorUtil.kPrimary,
                                                size: 44.kh)),
                                        Text("Lock Central \n Lock",
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 35.kh,
                                width: 165.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/report.svg",
                                      color: Color(0xFF5F5F5F),
                                    ),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    InkWell(onTap:(){
                                      Get.toNamed(Routes.REPORT_AN_ISSUE,arguments: [controller.bookingId]);
                                    } ,
                                      child: Text(
                                        "Report a problem",
                                        style: TextStyle(
                                          color: Color(0xFF5F5F5F),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        SizedBox(
                          height: 10.kh,
                        ),
                        ListTile(
                            leading: Text(
                              "Order Summary",
                              style: TextStyle(fontSize: 16.kh),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios)),
                        SizedBox(
                          height: 10.kh,
                        ),

                        ButtonDesign(
                            name: "Pause and close the door",
                            onPressed: () {
                              //controller.carBooking.value = false;
                              // Get.toNamed(Routes.LOGIN);
                            }),
                        SizedBox(
                          height: 10.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.5, color: ColorUtil.kPrimary),
                            ),
                            label: Text('Complete the trip',
                                style: TextStyle(color: ColorUtil.kPrimary)),
                            icon: SvgPicture.asset("assets/icons/complete.svg"),
                            onPressed: () {
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
                                            "Are you sure want to end this ride?",
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
                                                      "No",
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
                                                  controller.endrideInspection
                                                      .value = true;
                                                  /* controller.onBoardingStatus.value=false;
                                        Get.find<GetStorageService>().deleteLocation();
                                        Get.find<TokenCreateGenrate>().signOut();*/
                                                  // controller.enrideInspection.value = true;
                                                  //  controller.rideStart.value = false;
                                                  /*  await controller
                                                      .LogoutAnDeleteEveryThing();*/

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
                                                      "Yes, End ride",
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
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget endrideInspection(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.8,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            Container(
              height: 650.kh,
              decoration: BoxDecoration(
                color: ColorUtil.kPrimary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                    height: 2,
                    width: 100.kw,
                    color: Colors.white,
                  )),
                  /*Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(offset:Offset(0,-50),
                            child: Text(
                              "",
                              style: TextStyle(
                                // fontSize: 24.kh,
                                  color: ColorUtil.ZammaBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.endrideInspection.value = false;
                              Scaffold.of(context).showBodyScrim(false, 0.0);
                            },
                            child: Transform.translate(offset: Offset(0,-16),
                              child: SvgPicture.asset("assets/icons/cross.svg",
                                  color: Colors.white),
                            ),
                          ),
                        ]),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 34, 0, 0),
                    child: Column(
                      children: [
                        Text("Onging Trip",
                            style: TextStyle(color: Color(0xFFB4BCE1))),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.kh,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.kh),
                height: 550.kh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.kh,
                      ),
                      Text(
                        "Click respective side of images",
                        style: TextStyle(fontSize: 16.kh),
                      ),
                      SizedBox(
                        height: 24.kh,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("front");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.frontHood.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Front hood",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("leftside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.leftSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Left Side",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.kh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("rightside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.rightSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Right Side",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("backside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.backSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Back Side",
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40.kh,
                      ),

                      Obx(
                        () => controller.instanceOfGlobalData.loader.value ==
                                true
                            ? Center(
                                child: SizedBox(
                                    width: 200.kh,
                                    height: 56.kh,
                                    child: Lottie.asset(
                                        'assets/json/car_loader.json')),
                              )
                            : ButtonDesign(
                                name: "Done",
                                onPressed: () {
                                  if (controller.frontImageStatus.value == 0 || controller.leftImageStatus.value == 0 ||
                                      controller.rightImageStatus.value == 0 || controller.backImageStatus == 0) {
                                    showMySnackbar(title: "Error",
                                        msg: "All image mandatory");
                                  }else {
                                    controller.lodingMsg.value =
                                    "Checking central lock";
                                    context.loaderOverlay.show();
                                    controller.putAutoCentralLock("locked")
                                        .then((value) {
                                      if (value == "locked") {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          controller.lodingMsg.value =
                                          "Checking immobilizer lock";
                                          controller
                                              .putImoblizerLock("locked").then((
                                              value) {
                                            if (value == "locked") {
                                              Future.delayed(
                                                  const Duration(
                                                      seconds: 1), () {
                                                context.loaderOverlay.hide();
                                                controller
                                                    .uploadInspectionImage("E")
                                                    .then((value) {
                                                  if (value == 1) {
                                                    controller
                                                        .bookingPriceDetails
                                                        .value = true;
                                                    controller.endrideInspection
                                                        .value =
                                                    false;
                                                    controller.rideStart.value =
                                                    false;
                                                    controller.carBooking
                                                        .value = false;
                                                  } else {
                                                    showMySnackbar(
                                                        title: "Error",
                                                        msg: "Error while inspection");
                                                  }
                                                });
                                              });
                                            } else {
                                              Future.delayed(
                                                  const Duration(
                                                      seconds: 1), () {
                                                context.loaderOverlay.hide();
                                                showMySnackbar(title: "Error",
                                                    msg: "Error while updating immobilizer lock");
                                                controller.lodingMsg.value =
                                                "Analyzing your car";
                                              });
                                            }
                                          });
                                        });
                                      }
                                      else {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          context.loaderOverlay.hide();
                                          showMySnackbar(title: "Error",
                                              msg: "Error while updating central lock");
                                          controller.lodingMsg.value =
                                          "Analyzing your car";
                                        });
                                      }
                                    });
                                  }
                                      /*controller
                                          .putImoblizerLock("locked")
                                          .then((value) {
                                        if (value == "locked") {
                                          Future.delayed(
                                              const Duration(seconds: 1), () {
                                            context.loaderOverlay.hide();
                                            controller.bookingPriceDetails
                                                .value = true;
                                            controller.endrideInspection.value =
                                                false;
                                            controller.rideStart.value = false;
                                            controller.carBooking.value = false;
                                          });
                                        }
                                      });*/


                                  // Get.toNamed(Routes.LOGIN);
                                }),
                      ),
                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
              ),
            ),
            /*  Positioned(bottom: 0,
              //alignment: FractionalOffset.topCenter,
              child: Container(
                child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
              ),
            ),*/
          ],
        );
      },
    );
  }

  Widget bookingPriceDetails(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            Container(
              height: 800.kh,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                        height: 2,
                        width: 100.kw,
                        color: ColorUtil.kPrimary,
                      )),

                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Travel Time",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "${controller.finalTralvelTime.value} min",
                              style: TextStyle(
                                  color: Color(0xff008000) ,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Distance",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "0 miles",
                              style: TextStyle(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Paid Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.paidAmount.value}",
                              style: TextStyle(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.finalTotalAmount.value}",
                              style: TextStyle(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Waiting Charges",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraWaitingCharge.value}",
                              style: TextStyle(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Extra Travel Charges",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraTravelTimeCharge.value}",
                              style: TextStyle(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total payble then ",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.kh,
                              ),
                            ),
                            Text(
                              "\$${double.parse((controller.totalFare.value).toStringAsFixed(3))}",
                              style: TextStyle(
                                  color: Color(0xffFF0000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.kh,
                      ),
                      Center(
                        child: Obx(
                          () => controller.instanceOfGlobalData.loader.value ==
                                  true
                              ? Center(
                                  child: SizedBox(
                                      width: 200.kh,
                                      height: 100.kh,
                                      child: Lottie.asset(
                                          'assets/json/car_loader.json')),
                                )
                              : Container(
                                  child: ButtonDesign(
                                      name: "Pay",
                                      onPressed: () {
                                        if((controller.totalFare.value)>0) {
                                          Get.toNamed(Routes.SAVED_CARDS,
                                              arguments: [
                                                controller.bookingId,
                                                "End",
                                                "",
                                                false,
                                                "${controller.bookingType.value}",
                                                double.parse((controller.totalFare.value).toStringAsFixed(3)),
                                                (controller.finalDistanceTravel.value),(controller.finalTralvelTime.value)
                                              ]);
                                        }
                                        else{
                                          Get.offAllNamed(Routes.HOME);
                                          showMySnackbar(
                                              title: "Msg",
                                              msg: "Payment Successful");
                                        }
                                      }),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 10.kh,
                      ),

                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
