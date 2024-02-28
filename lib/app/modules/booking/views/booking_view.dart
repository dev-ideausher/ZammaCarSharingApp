import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
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
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 70.kh,
          width: 250.kw,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
              child:
                  SizedBox(child: Lottie.asset('assets/json/car_loader.json')),
            ),
            SizedBox(
              width: 10.kw,
            ),
            Obx(
              () => Text(
                controller.lodingMsg.value,
                style: GoogleFonts.urbanist(fontSize: 16),
              ),
            ),
          ]),
        )),
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
                  ? carBooking(0.6)
                  : SizedBox(),
              controller.carInspection.value == true
                  ? carInspection(0.9)
                  : SizedBox(),
              controller.rideStart.value == true ? rideStart(0.75) : SizedBox(),
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
    );
  }

  Widget carBooking(double initialVal) {
    /*  if (!controller.checkTimer.value) controller.startTimer();*/
    /*  if (!Get.find<GlobalData>().checkTimer.value)
      Get.find<GlobalData>().startTimer();*/
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.1,
      maxChildSize: 0.6,
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
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      height: 2,
                      width: 100.kw,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 0),
                      child: Column(
                        children: [
                          Text("Free Waiting",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => controller.loader.value == true
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    //  "${controller.minute.value}:${controller.start.value}",
                                    "${controller.instanceOfGlobalData.waitingRideTime.value}",
                                    // "${Get.find<GlobalData>().minute.value}:${Get.find<GlobalData>().start.value}",
                                    style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.kh,
                                      color: controller.instanceOfGlobalData
                                                  .extraWaiting.value ==
                                              true
                                          ? Colors.red
                                          : Colors.white,
                                    )),
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
                          height: 25.kh,
                        ),
                        Obx(
                          () => CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "${controller.getBookingDetailsModel.value.data?.car?.images?[0]}",
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              height: 140.kh,
                              width: 260.kw,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 100.kh,
                                width: 260.kw,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 100.kh,
                                width: 260.kw,
                              ),
                            ),
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
                                child: Text("${controller.model}",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white,
                                    )))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/battery.svg"),
                                Obx(
                                  () => Text(
                                    "${controller.getBookingDetailsModel.value.data?.car?.fuelLevel} ${controller.getBookingDetailsModel.value.data?.car?.fuelType == "fule" ? "Liter" : "%"}",
                                    style: GoogleFonts.urbanist(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
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
                                width: 120.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.speed),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    Obx(
                                      () => SizedBox(
                                        width: 90.kw,
                                        child: Center(
                                          child: Text(
                                            "Mileage : ${controller.getBookingDetailsModel.value.data?.car?.mileage}",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF5F5F5F),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            InkWell(
                              onTap: () {
                                controller.openMap();
                              },
                              child: Container(
                                  height: 35.kh,
                                  width: 120.kw,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFF5F5F5F))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      SizedBox(
                                        width: 5.kh,
                                      ),
                                      Text(
                                        "Map view",
                                        style: GoogleFonts.urbanist(
                                          color: Color(0xFF5F5F5F),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10.kh,
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
                                    //     controller.openMap();

                                    /* controller
                                        .qrBarCodeScannerDialogPlugin.value
                                        .getScannedQrBarCode(
                                            context: context,
                                            onCode: (code) {
                                              controller.code.value =
                                                  code.toString();
                                              print("qr code: ${controller.code.value}");
                                              if (controller.code.value ==
                                                  Get.find<GetStorageService>().getQNR) {
                                                showMySnackbar(title: "Symbol Drive", msg: "Verified successfully");
                                                print("if qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");
                                                controller.carInspection.value = true;
                                              }
                                              else{
                                                showMySnackbar(title: "Error", msg: "You have not booked this car");
                                                print("else qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");


                                              }

                                            });*/
                                    controller.carInspection.value = true;
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
                                        style: GoogleFonts.urbanist(
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
                                                    style: GoogleFonts.urbanist(
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
                                                              style: GoogleFonts
                                                                  .urbanist(
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
                                                              style: GoogleFonts
                                                                  .urbanist(
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                            const Spacer(),
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
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: Column(
                        children: [
                          Text("Free Waiting",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => controller.loader.value == true
                                ? const CircularProgressIndicator()
                                : Text(
                                    "${controller.instanceOfGlobalData.waitingRideTime.value}",
                                    // "${controller.instanceOfGlobalData.minute.value}:${controller.instanceOfGlobalData.start.value}",
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.kh,
                                        color: controller.instanceOfGlobalData
                                                    .extraWaiting.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
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
                          style: GoogleFonts.urbanist(fontSize: 16.kh),
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
                                                controller.frontHood.value ??
                                                    File("")),
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
                                            "Front Side",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  //838087
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
                                                controller.leftSide.value ??
                                                    File("")),
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
                                            style: GoogleFonts.urbanist(
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
                                                controller.rightSide.value ??
                                                    File("")),
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
                                            style: GoogleFonts.urbanist(
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
                                                controller.backSide.value ??
                                                    File("")),
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
                                            style: GoogleFonts.urbanist(
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
                                  onPressed: () async {
                                    await controller.startRide(context);
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
                                        style: GoogleFonts.urbanist(
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
                                                    style: GoogleFonts.urbanist(
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
                                                              style: GoogleFonts
                                                                  .urbanist(
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
                                                              style: GoogleFonts
                                                                  .urbanist(
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
    if (!controller.instanceOfGlobalData.checkRideTicker.value)
      controller.getOnGoingHistory();
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
                  //     crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text("Ongoing Trip",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => controller.loader.value == true
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    controller
                                        .instanceOfGlobalData.rideTime.value,
                                    /* "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",*/
                                    style: GoogleFonts.urbanist(
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
                        Obx(
                          () => CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "${controller.getBookingDetailsModel.value.data?.car?.images?[0]}",
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              height: 140.kh,
                              width: 260.kw,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 100.kh,
                                width: 260.kw,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 100.kh,
                                width: 260.kw,
                              ),
                            ),
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
                              style: GoogleFonts.urbanist(
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
                                Obx(
                                  () => Text(
                                    "${controller.getBookingDetailsModel.value.data?.car?.fuelLevel == null ? "0" : controller.getBookingDetailsModel.value.data?.car?.fuelLevel} ${controller.getBookingDetailsModel.value.data?.car?.fuelType == "fule" ? "Liter" : "%"}",
                                    style: GoogleFonts.urbanist(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
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
                                                    title: "Message",
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
                                                    title: "Message",
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
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.REPORT_AN_ISSUE,
                                            arguments: [controller.bookingId]);
                                      },
                                      child: Text(
                                        "Report a problem",
                                        style: GoogleFonts.urbanist(
                                          color: Color(0xFF5F5F5F),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        /* SizedBox(
                          height: 10.kh,
                        ),
                        ListTile(
                            leading: Text(
                              "Order Summary",
                              style: GoogleFonts.urbanist(fontSize: 16.kh),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios)),*/
                        SizedBox(
                          height: 20.kh,
                        ),

                        Obx(
                          () => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Ride status :",
                                style: GoogleFonts.urbanist(
                                  color: ColorUtil.kPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              controller.getBookingDetailsModel.value.data?.car
                                          ?.ignition ==
                                      "off"
                                  ? Center(
                                      child: Text(
                                      "Paused",
                                      style: GoogleFonts.urbanist(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                                  : Text(
                                      "Driving",
                                      style: GoogleFonts.urbanist(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), // <-- Text
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20.kh,
                        ),
                        InkWell(
                          onTap: () {
                            controller.openMapRide();
                          },
                          child: Container(
                              height: 35.kh,
                              width: 120.kw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      width: 0.5, color: Color(0xFF5F5F5F))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map_outlined),
                                  SizedBox(
                                    width: 5.kh,
                                  ),
                                  Text(
                                    "Map view",
                                    style: GoogleFonts.urbanist(
                                      color: Color(0xFF5F5F5F),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 20.kh,
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
                                style: GoogleFonts.urbanist(
                                    color: ColorUtil.kPrimary)),
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
                                            style: GoogleFonts.urbanist(
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
                                                      style:
                                                          GoogleFonts.urbanist(
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
                                                      style:
                                                          GoogleFonts.urbanist(
                                                              color:
                                                                  Colors.white,
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
                //crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: GoogleFonts.urbanist(
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
                    padding: const EdgeInsets.fromLTRB(16.0, 34, 16, 0),
                    child: Column(
                      children: [
                        Text("Ongoing Trip",
                            style:
                                GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            "${controller.instanceOfGlobalData.rideTime.value}",
                            /*  "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",*/
                            style: GoogleFonts.urbanist(
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
                        style: GoogleFonts.urbanist(fontSize: 16.kh),
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
                                              controller.frontHood.value ??
                                                  File("")),
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
                                          "Front Side",
                                          style: GoogleFonts.urbanist(
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
                                              controller.leftSide.value ??
                                                  File("")),
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
                                          style: GoogleFonts.urbanist(
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
                                              controller.rightSide.value ??
                                                  File("")),
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
                                          style: GoogleFonts.urbanist(
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
                                              controller.backSide.value ??
                                                  File("")),
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
                                          style: GoogleFonts.urbanist(
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
                        () =>
                            controller.instanceOfGlobalData.loader.value == true
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
                                      //TODO End ride
                                      // controller.verifyAndInspect(
                                      //     context, RideStatus.end);
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "${controller.finalTralvelTime.value} min",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      /* SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Milage",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "${controller.milage.value} ",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000) ,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),*/
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "0 miles",
                              style: GoogleFonts.urbanist(
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.paidAmount.value}",
                              style: GoogleFonts.urbanist(
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.finalTotalAmount.value}",
                              style: GoogleFonts.urbanist(
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraWaitingCharge.value}",
                              style: GoogleFonts.urbanist(
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
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraTravelTimeCharge.value}",
                              style: GoogleFonts.urbanist(
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
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.kh,
                              ),
                            ),
                            Text(
                              "\$${double.parse((controller.totalFare.value).toStringAsFixed(3))}",
                              style: GoogleFonts.urbanist(
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
                                      onPressed: () async {
                                        if ((controller.totalFare.value) > 0) {
                                          await controller
                                              .getTransationDetails();
                                          Get.toNamed(Routes.SAVED_CARDS,
                                              arguments: [
                                                controller.bookingId == ""
                                                    ? controller.rideHistory
                                                        .value.data![0]!.Id
                                                    : controller.bookingId,
                                                "End",
                                                "",
                                                false,
                                                "${controller.bookingType.value}",
                                                double.parse(
                                                    (controller.totalFare.value)
                                                        .toStringAsFixed(3)),
                                                (controller
                                                    .finalDistanceTravel.value),
                                                (controller
                                                    .finalTralvelTime.value)
                                              ]);
                                        } else {
                                          Get.offAllNamed(Routes.HOME);
                                          showMySnackbar(
                                              title: "Message",
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
