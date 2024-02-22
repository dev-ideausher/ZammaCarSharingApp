import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/modules/savedCards/controllers/saved_cards_controller.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //const HomeView({Key? key}) : super(key: key);
  static final CameraPosition kGoogle = const CameraPosition(
    target: LatLng(37.42796133580664, -122.885749655962),
    zoom: -25.0,
  );

  @override
  Widget build(BuildContext context) {
    //Get.find<HomeController>().onInit();

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Obx(
          () => Stack(
            children: [
              Container(
                height:
                    Get.find<GlobalData>().isloginStatusGlobal.value == false
                        ? 610.kh
                        : 695.kh,
                //    color: Colors.blue,
                child: controller.mapLoader.value
                    ? Center(
                        child: SizedBox(
                            width: 200.kh,
                            height: 100.kh,
                            child: Lottie.asset('assets/json/car_loader.json')))
                    : controller.isMapLoaded.value
                        ? GoogleMap(
                            // on below line setting camera position
                            initialCameraPosition: kGoogle,
                            // on below line specifying map type.
                            mapType: MapType.normal,
                            // on below line setting user location enabled.
                            myLocationEnabled: true,
                            // on below line setting compass enabled.
                            compassEnabled: true,
                            markers: Set.of(controller.listOfMarker.value),
                            // on below line specifying controller on map complete.
                            onMapCreated: (GoogleMapController mcontroller) {
                              controller.mapCompleter.complete(mcontroller);
                            },
                          )
                        : Center(
                            child: Text(
                            "Location permission requied.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.kh),
                          )),

                /*GoogleMap(
                  onMapCreated: (mapController) {
                    controller.mapCompleter.complete(mapController);
                  },
                  markers: controller.listOfMarker,
                  initialCameraPosition: CameraPosition(
                    target: controller.center,
                    zoom: -25.0,
                  ),
                ),*/
              ),

              Get.find<GetStorageService>().getisLoggedIn == false
                  ? Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 165.kh,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(30.kw, 16.kh, 30.kw, 16.kh),
                            height: 75.kh,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => Get.find<GlobalData>()
                                              .isloginStatusGlobal
                                              .value ==
                                          false
                                      ? InkWell(
                                          onTap: () {
                                            /* showMaterialModalBottomSheet(
                                              enableDrag: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0)),
                                              ),
                                              context: context,
                                              builder: (context) => Container(
                                                height: 300.kh,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      topLeft:
                                                          Radius.circular(20.0)),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                24.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Radar",
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize:
                                                                        24.kh,
                                                                    color: ColorUtil
                                                                        .ZammaBlack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/icons/cross.svg"),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 24.kh,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .fromLTRB(
                                                            16.0, 16, 16, 0),
                                                        child: Text(
                                                          "Distance",
                                                          style: GoogleFonts.urbanist(
                                                              color: ColorUtil
                                                                  .ZammaGrey,
                                                              fontSize: 15.kh),
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => Slider(
                                                          inactiveColor:
                                                              ColorUtil.ZammaGrey,
                                                          activeColor:
                                                              ColorUtil.kPrimary,
                                                          thumbColor:
                                                              Colors.white,
                                                          value: controller
                                                              .currentSliderValue
                                                              .value,
                                                          max: 100,
                                                          divisions: 5,
                                                          label: controller
                                                              .currentSliderValue
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged:
                                                              (double value) {
                                                            controller
                                                                .currentSliderValue
                                                                .value = value;
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 34.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                0.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Amet minim mollit non deserunt ullamco\nest sit aliqua dolor do ",
                                                                style: GoogleFonts.urbanist(
                                                                    color: ColorUtil
                                                                        .ZammaGrey),
                                                              ),
                                                              Obx(
                                                                () => Switch(
                                                                  // This bool value toggles the switch.
                                                                  value:
                                                                      controller
                                                                          .light
                                                                          .value,
                                                                  activeColor:
                                                                      ColorUtil
                                                                          .kPrimary,
                                                                  onChanged: (bool
                                                                      value) {
                                                                    // This is called when the user toggles the switch.

                                                                    controller
                                                                            .light
                                                                            .value =
                                                                        value;
                                                                  },
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 30.kh,
                                                      ),
                                                      Center(
                                                        child: ButtonDesign(
                                                            name: "Turn on",
                                                            onPressed: () {}),
                                                      )
                                                    ]),
                                              ),
                                            );*/
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5.kh,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/radar.svg"),
                                              SizedBox(
                                                height: 10.kh,
                                              ),
                                              Text(
                                                "Radar",
                                                style: GoogleFonts.urbanist(
                                                    fontSize: 15.kh,
                                                    color: ColorUtil.ZammaGrey),
                                              )
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            /*showMaterialModalBottomSheet(
                                              enableDrag: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0)),
                                              ),
                                              context: context,
                                              builder: (context) => Container(
                                                height: 300.kh,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      topLeft:
                                                          Radius.circular(20.0)),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                24.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Radar",
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize:
                                                                        24.kh,
                                                                    color: ColorUtil
                                                                        .ZammaBlack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/icons/cross.svg"),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 24.kh,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .fromLTRB(
                                                            16.0, 16, 16, 0),
                                                        child: Text(
                                                          "Distance",
                                                          style: GoogleFonts.urbanist(
                                                              color: ColorUtil
                                                                  .ZammaGrey,
                                                              fontSize: 15.kh),
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => Slider(
                                                          inactiveColor:
                                                              ColorUtil.ZammaGrey,
                                                          activeColor:
                                                              ColorUtil.kPrimary,
                                                          thumbColor:
                                                              Colors.white,
                                                          value: controller
                                                              .currentSliderValue
                                                              .value,
                                                          max: 100,
                                                          divisions: 5,
                                                          label: controller
                                                              .currentSliderValue
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged:
                                                              (double value) {
                                                            controller
                                                                .currentSliderValue
                                                                .value = value;
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 34.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                0.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Amet minim mollit non deserunt ullamco\nest sit aliqua dolor do ",
                                                                style: GoogleFonts.urbanist(
                                                                    color: ColorUtil
                                                                        .ZammaGrey),
                                                              ),
                                                              Obx(
                                                                () => Switch(
                                                                  // This bool value toggles the switch.
                                                                  value:
                                                                      controller
                                                                          .light
                                                                          .value,
                                                                  activeColor:
                                                                      ColorUtil
                                                                          .kPrimary,
                                                                  onChanged: (bool
                                                                      value) {
                                                                    // This is called when the user toggles the switch.

                                                                    controller
                                                                            .light
                                                                            .value =
                                                                        value;
                                                                  },
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 30.kh,
                                                      ),
                                                      Center(
                                                        child: ButtonDesign(
                                                            name: "Turn off",
                                                            onPressed: () {}),
                                                      )
                                                    ]),
                                              ),
                                            );*/
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5.kh,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/radar.svg"),
                                              SizedBox(
                                                height: 10.kh,
                                              ),
                                              Text(
                                                "Radar",
                                                style: GoogleFonts.urbanist(
                                                    fontSize: 15.kh,
                                                    color: ColorUtil.ZammaGrey),
                                              )
                                            ],
                                          ),
                                        )),
                                  InkWell(
                                    onTap: () {
                                      controller.cars.value = true;
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/cars.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Cars",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // controller.zone.value = true;
                                      Get.toNamed(Routes.ZONE);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/zone.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Zone",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SETTINGS);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/setting.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Setting",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          Container(
                            child: ButtonDesign(
                                name: "Login",
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN);
                                }),
                          ),
                        ]),
                      ),
                    )
                  : Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 90.kh,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(30.kw, 16.kh, 30.kw, 0),
                            height: 70.kh,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => Get.find<GlobalData>()
                                              .isloginStatusGlobal
                                              .value ==
                                          false
                                      ? InkWell(
                                          onTap: () {
                                            /* showMaterialModalBottomSheet(
                                              enableDrag: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0)),
                                              ),
                                              context: context,
                                              builder: (context) => Container(
                                                height: 300.kh,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      topLeft:
                                                          Radius.circular(20.0)),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                24.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Radar",
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize:
                                                                        24.kh,
                                                                    color: ColorUtil
                                                                        .ZammaBlack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/icons/cross.svg"),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 24.kh,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .fromLTRB(
                                                            16.0, 16, 16, 0),
                                                        child: Text(
                                                          "Distance",
                                                          style: GoogleFonts.urbanist(
                                                              color: ColorUtil
                                                                  .ZammaGrey,
                                                              fontSize: 15.kh),
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => Slider(
                                                          inactiveColor:
                                                              ColorUtil.ZammaGrey,
                                                          activeColor:
                                                              ColorUtil.kPrimary,
                                                          thumbColor:
                                                              Colors.white,
                                                          value: controller
                                                              .currentSliderValue
                                                              .value,
                                                          max: 100,
                                                          divisions: 5,
                                                          label: controller
                                                              .currentSliderValue
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged:
                                                              (double value) {
                                                            controller
                                                                .currentSliderValue
                                                                .value = value;
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 34.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                0.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Amet minim mollit non deserunt ullamco\nest sit aliqua dolor do ",
                                                                style: GoogleFonts.urbanist(
                                                                    color: ColorUtil
                                                                        .ZammaGrey),
                                                              ),
                                                              Obx(
                                                                () => Switch(
                                                                  // This bool value toggles the switch.
                                                                  value:
                                                                      controller
                                                                          .light
                                                                          .value,
                                                                  activeColor:
                                                                      ColorUtil
                                                                          .kPrimary,
                                                                  onChanged: (bool
                                                                      value) {
                                                                    // This is called when the user toggles the switch.

                                                                    controller
                                                                            .light
                                                                            .value =
                                                                        value;
                                                                  },
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 30.kh,
                                                      ),
                                                      Center(
                                                        child: ButtonDesign(
                                                            name: "Turn on",
                                                            onPressed: () {}),
                                                      )
                                                    ]),
                                              ),
                                            );*/
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5.kh,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/radar.svg"),
                                              SizedBox(
                                                height: 10.kh,
                                              ),
                                              Text(
                                                "Radar",
                                                style: GoogleFonts.urbanist(
                                                    fontSize: 15.kh,
                                                    color: ColorUtil.ZammaGrey),
                                              )
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            /*showMaterialModalBottomSheet(
                                              enableDrag: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0)),
                                              ),
                                              context: context,
                                              builder: (context) => Container(
                                                height: 300.kh,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      topLeft:
                                                          Radius.circular(20.0)),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                24.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Radar",
                                                                style: GoogleFonts.urbanist(
                                                                    fontSize:
                                                                        24.kh,
                                                                    color: ColorUtil
                                                                        .ZammaBlack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/icons/cross.svg"),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 24.kh,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .fromLTRB(
                                                            16.0, 16, 16, 0),
                                                        child: Text(
                                                          "Distance",
                                                          style: GoogleFonts.urbanist(
                                                              color: ColorUtil
                                                                  .ZammaGrey,
                                                              fontSize: 15.kh),
                                                        ),
                                                      ),
                                                      Obx(
                                                        () => Slider(
                                                          inactiveColor:
                                                              ColorUtil.ZammaGrey,
                                                          activeColor:
                                                              ColorUtil.kPrimary,
                                                          thumbColor:
                                                              Colors.white,
                                                          value: controller
                                                              .currentSliderValue
                                                              .value,
                                                          max: 100,
                                                          divisions: 5,
                                                          label: controller
                                                              .currentSliderValue
                                                              .value
                                                              .round()
                                                              .toString(),
                                                          onChanged:
                                                              (double value) {
                                                            controller
                                                                .currentSliderValue
                                                                .value = value;
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 34.kh,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                16.kw,
                                                                0.kh,
                                                                16.kw,
                                                                0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Amet minim mollit non deserunt ullamco\nest sit aliqua dolor do ",
                                                                style: GoogleFonts.urbanist(
                                                                    color: ColorUtil
                                                                        .ZammaGrey),
                                                              ),
                                                              Obx(
                                                                () => Switch(
                                                                  // This bool value toggles the switch.
                                                                  value:
                                                                      controller
                                                                          .light
                                                                          .value,
                                                                  activeColor:
                                                                      ColorUtil
                                                                          .kPrimary,
                                                                  onChanged: (bool
                                                                      value) {
                                                                    // This is called when the user toggles the switch.

                                                                    controller
                                                                            .light
                                                                            .value =
                                                                        value;
                                                                  },
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 30.kh,
                                                      ),
                                                      Center(
                                                        child: ButtonDesign(
                                                            name: "Turn off",
                                                            onPressed: () {}),
                                                      )
                                                    ]),
                                              ),
                                            );*/
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5.kh,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/radar.svg"),
                                              SizedBox(
                                                height: 10.kh,
                                              ),
                                              Text(
                                                "Radar",
                                                style: GoogleFonts.urbanist(
                                                    fontSize: 15.kh,
                                                    color: ColorUtil.ZammaGrey),
                                              )
                                            ],
                                          ),
                                        )),
                                  InkWell(
                                    onTap: () {
                                      controller.cars.value = true;
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/cars.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Cars",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //controller.zone.value = true;
                                      Get.toNamed(Routes.ZONE);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/zone.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Zone",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.SETTINGS);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/setting.svg"),
                                        SizedBox(
                                          height: 10.kh,
                                        ),
                                        Text(
                                          "Setting",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 15.kh,
                                              color: ColorUtil.ZammaGrey),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ]),
                      ),
                    ),
              controller.cars.value == true ? cars(0.5) : SizedBox(),
              controller.carDetails.value == true
                  ? carDetails(0.7)
                  : SizedBox(),
              controller.zone.value == true ? zone(0.4) : SizedBox(),
              controller.customePrice.value == true
                  ? customePrice(0.7)
                  : SizedBox(),
              controller.bookingPriceDetails.value == true
                  ? bookingPriceDetails(0.7)
                  : SizedBox(),

              /* controller.carBooking.value == true ? carBooking(0.75) : SizedBox(),*/
              /* controller.carInspection.value == true
                  ? carInspection(0.9)
                  : SizedBox(),*/
              // controller.rideStart.value == true ? rideStart(0.75) : SizedBox(),
              // controller.enrideInspection.value == true
              //     ? enrideInspection(0.85)
              //     : SizedBox(),

            ],
          ),
        )),
      ),
    );
  }

  Widget cars(double initialVal) {
    // Get.find<HomeController>().getCarsAndCategories();
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.3,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        if (initialVal == 0.0) scrollController.dispose();
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 Center(
                  child: Container(
                height: 2,
                width: 100.kw,
                color: ColorUtil.kPrimary,
                  ),
                 ),
                Container(
                height: 30.kh,
                margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cars",
                        style: GoogleFonts.urbanist(
                            fontSize: 24.kh,
                            color: ColorUtil.ZammaBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          controller.tapAttention.value = 0;
                          controller.cars.value = false;

                          Scaffold.of(context).showBodyScrim(false, 0.0);
                        },
                        child: SvgPicture.asset("assets/icons/cross.svg"),
                      ),
                    ]),
                ),
                SizedBox(
                height: 20.kh,
                ),
                Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                height: 50.kh,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.categoriesModels.value.category?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.tapAttention.value = index;
                          controller.getSelectCategoyCars("${(controller.categoriesModels.value.category?[index]?.name)?.toLowerCase()}");
                        },
                        child : Obx(
                          () => Container(
                            margin         : EdgeInsets.fromLTRB(12.kh, 0.kh, 0.kh, 16.kh),
                            padding        : EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration     : BoxDecoration(
                              color        : controller.tapAttention.value == index
                                           ? ColorUtil.kPrimary
                                           : Colors.white,
                              border       : Border.all(color: ColorUtil.ZammaGrey),
                              borderRadius : BorderRadius.all(Radius.circular(4),),
                            ),
                            child      : Center(
                              child    : Text("${controller.categoriesModels.value.category?[index]?.name}",
                                style  : GoogleFonts.urbanist(color : controller.tapAttention.value == index ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),


                  Obx(
                   () => Expanded(child: controller.instanceOfGlobalData.loader.value == true
                      ? Column(
                          children: [
                            Center(child: SizedBox(
                                  width: 200.kh,
                                  height: 200.kh,
                                  child: Lottie.asset('assets/json/car_loader.json'),),
                            ),
                          ],
                        )
                      : controller.carsModel.value.cars?.isEmpty == true
                          ? Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 200.kh,
                                    width: 200.kw,
                                    child:
                                        Image.asset("assets/images/no_car.png"),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: controller.carsModel.value.cars?.length,
                              itemBuilder: (contex, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.model.value       = "${controller.carsModel.value.cars?[index]?.brand} ${controller.carsModel.value.cars?[index]?.model}";
                                    controller.carImage.value    = (controller.carsModel.value.cars?[index]?.images?[0]).toString();
                                    controller.seatCapcity.value = (controller.carsModel.value.cars?[index]?.seatCapacity).toString();
                                    controller.milage.value      = (controller.carsModel.value.cars?[index]?.mileage).toString();
                                    controller.fuelType.value    = (controller.carsModel.value.cars?[index]?.fuelType).toString();
                                    controller.fuelLavel.value   = (controller.carsModel.value.cars?[index]?.fuelLevel).toString();
                                    controller.carId.value       = (controller.carsModel.value.cars?[index]?.Id).toString();
                                    controller.qnr.value         = (controller.carsModel.value.cars?[index]?.qnr).toString();
                                    controller.selectedCarLatitude.value  = (controller.carsModel.value.cars?[index]?.position?.coordinates?[1])!;
                                    controller.selectedCarLongitude.value = (controller.carsModel.value.cars?[index]?.position?.coordinates?[0])!;
                                    //  controller.cars.value = false;
                                    controller.carDetails.value = true;
                                    Get.find<GetStorageService>().setQNR      = "${controller.qnr.value = (controller.carsModel.value.cars?[index]?.qnr).toString()}";
                                    controller.instanceOfGlobalData.QNR.value = "${controller.qnr.value = (controller.carsModel.value.cars?[index]?.qnr).toString()}";
                                    print("qnr Value : ${controller.qnr.value = (controller.carsModel.value.cars?[index]?.qnr).toString()}");
                                    controller.cars.value = false;
                                  },
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      height: 80.kh,
                                      margin:
                                          EdgeInsets.fromLTRB(16, 16, 16, 0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtil.ZammaGrey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "${controller.carsModel.value.cars?[index]?.images?[0]}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 10, 10),
                                              width: 100.kh,
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
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                //  height: 100.kh,
                                                width: 100.kh,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(4),
                                                  ),
                                                  // shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            /*  errorWidget: (context, url, error) =>
                                                SvgPicture.asset("assets/SVG/profiledefault.svg"),*/
                                          ),
                                          /* Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 10, 10),
                                            width: 100.kh,
                                            child: Image.asset(...
                                                "assets/images/carImage.png"),
                                          ),*/
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.carsModel.value.cars?[index]?.brand} ${controller.carsModel.value.cars?[index]?.model}",
                                                style: GoogleFonts.urbanist(
                                                    color: ColorUtil.kPrimary,
                                                    fontSize: 16.kh,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${controller.carsModel.value.cars?[index]?.fuelType} , seat capacity: ${controller.carsModel.value.cars?[index]?.seatCapacity}",
                                                style: GoogleFonts.urbanist(
                                                    color: ColorUtil.ZammaGrey,
                                                    fontSize: 14.kh),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              }),
                ),
              ),
              SizedBox(
                height: 30.kh,
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget carDetails(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 900.kh,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Container(
                          height: 2,
                          width: 100.kw,
                          color: ColorUtil.kPrimary,
                        )),
                        Container(
                          height: 30.kh,
                          margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 24.kh,
                                      color: ColorUtil.ZammaBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.carDetails.value = false;
                                    Scaffold.of(context)
                                        .showBodyScrim(false, 0.0);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/cross.svg"),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 30.kh,
                        ),
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${controller.carImage.value}",
                          imageBuilder: (context, imageProvider) => Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            height: 150.kh,
                            width: 260.kw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          /*  errorWidget: (context, url, error) =>  SvgPicture.asset("assets/SVG/profiledefault.svg"),*/
                        ),

                        /* Container(
                          height: 100.kh,
                          width: 260.kw,
                          child: Center(
                            child: Image.asset("assets/images/bigCars.png"),
                          ),
                        ),*/

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
                              "${controller.model.value}",
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
                                Text(
                                  "${controller.fuelLavel.value} ${controller.fuelType.value == "fuel" ? " Liter" : " %"}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.speed),
                                Obx(
                                  () => Text(
                                    "${controller.milage.value}",
                                    style: GoogleFonts.urbanist(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity.value}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 8.kh,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Divider(
                            thickness: 1,
                            color: ColorUtil.ZammaGrey,
                          ),
                        ),
                        ListTile(
                            leading: SvgPicture.asset(
                                "assets/icons/featureicon.svg"),
                            title: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text("Feature 1",
                                    style:
                                        GoogleFonts.urbanist(fontSize: 18.kh))),
                            subtitle: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text(
                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                  style:
                                      GoogleFonts.urbanist(color: Colors.black),
                                ))),
                        SizedBox(
                          height: 8.kh,
                        ),
                        ListTile(
                            leading: SvgPicture.asset(
                                "assets/icons/featureicon.svg"),
                            title: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text(
                                  "Feature 2",
                                  style: GoogleFonts.urbanist(fontSize: 18.kh),
                                )),
                            subtitle: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text(
                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                  style:
                                      GoogleFonts.urbanist(color: Colors.black),
                                ))),
                        SizedBox(
                          height: 8.kh,
                        ),
                        ListTile(
                            leading: SvgPicture.asset(
                                "assets/icons/featureicon.svg"),
                            title: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text("Feature 3",
                                    style:
                                        GoogleFonts.urbanist(fontSize: 18.kh))),
                            subtitle: Transform.translate(
                                offset: Offset(-16, 10),
                                child: Text(
                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                  style:
                                      GoogleFonts.urbanist(color: Colors.black),
                                ))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Divider(
                            thickness: 1,
                            color: ColorUtil.ZammaGrey,
                          ),
                        ),
                        Container(
                          height: 80.kh,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.planTapAttention.value = index;

                                    if (index == 0) {
                                      controller.getCarPricing();
                                      controller.bookingPriceDetails.value =
                                          false;
                                      controller.customePrice.value = true;

                                      controller.planTapAttention.value = 100;
                                      controller.carDetails.value = false;
                                    }
                                    if (index == 1) {
                                      controller.customePrice.value = false;
                                      controller.bookingPriceDetails.value =
                                          true;

                                      controller.planTapAttention.value = 100;
                                      controller.carDetails.value = false;
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    height: 50.kh,
                                    width: 160.kw,
                                    decoration: BoxDecoration(
                                        color:
                                            controller.planTapAttention.value ==
                                                    index
                                                ? ColorUtil.kPrimary
                                                : Colors.white,
                                        border: Border.all(
                                          color: ColorUtil.kPrimary,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                        child: Text(
                                      "${index == 0 ? "Custom Plan" : "Basic Plan"}",
                                      style: GoogleFonts.urbanist(
                                          color: controller
                                                      .planTapAttention.value ==
                                                  index
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                );
                              }),
                        ),
                        /*Obx(() =>
                            Get.find<GlobalData>().isloginStatusGlobal == false
                                ? Container(
                                    child: ButtonDesign(
                                        name: "Login",
                                        onPressed: () {
                                          Get.toNamed(Routes.LOGIN);
                                        }),
                                  )
                                : Container(
                                    child: ButtonDesign(
                                        name: "Book",
                                        onPressed: () {
                                          //carbooking should be true in bookingPriceDetails
                                          controller.bookingPriceDetails.value =
                                              true;
                                          controller.carDetails.value = false;
                                          // controller.carDetails.value = false;
                                          // controller.carBooking.value = true;
                                          // Get.toNamed(Routes.RIDE_BOOKED);
                                        }),
                                  )),*/

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

  Widget zone(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.3,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        if (initialVal == 0.0) scrollController.dispose();
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Container(
                height: 2,
                width: 100.kw,
                color: ColorUtil.kPrimary,
              )),
              Container(
                height: 30.kh,
                margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Zone",
                        style: GoogleFonts.urbanist(
                            fontSize: 24.kh,
                            color: ColorUtil.ZammaBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          controller.zone.value = false;
                          Scaffold.of(context).showBodyScrim(false, 0.0);
                        },
                        child: SvgPicture.asset("assets/icons/cross.svg"),
                      ),
                    ]),
              ),
              SizedBox(
                height: 30.kh,
              ),
            ]),
          ),
        );
      },
    );
  }

  // Widget carBooking(double initialVal) {
  //   controller.startTimer();
  //   return DraggableScrollableSheet(
  //     initialChildSize: initialVal,
  //     minChildSize: 0.7,
  //     maxChildSize: 0.75,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Stack(
  //         children: [
  //           Container(
  //             height: 750.kh,
  //             decoration: BoxDecoration(
  //               color: ColorUtil.kPrimary,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20.0),
  //                   topLeft: Radius.circular(20.0)),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                     child: Container(
  //                   height: 2,
  //                   width: 100.kw,
  //                   color: Colors.white,
  //                 )),
  //                 Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "",
  //                           style: GoogleFonts.urbanist(
  //                               // fontSize: 24.kh,
  //                               color: ColorUtil.ZammaBlack,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         InkWell(
  //                           onTap: () {
  //                             controller.carBooking.value = false;
  //                             Scaffold.of(context).showBodyScrim(false, 0.0);
  //                           },
  //                           child: SvgPicture.asset("assets/icons/cross.svg",
  //                               color: Colors.white),
  //                         ),
  //                       ]),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
  //                   child: Column(
  //                     children: [
  //                       Text("Free Waitig",
  //                           style: GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Obx(
  //                         () => Text(
  //                           "${controller.minute.value}:${controller.start.value}",
  //                           style: GoogleFonts.urbanist(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 28.kh,
  //                               color: Colors.white),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               height: 500.kh,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(20.0),
  //                     topLeft: Radius.circular(20.0)),
  //               ),
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     /*Container(
  //                       height: 30.kh,
  //                       margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               "",
  //                               style: GoogleFonts.urbanist(
  //                                   fontSize: 24.kh,
  //                                   color: ColorUtil.ZammaBlack,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                             InkWell(
  //                               onTap: () {
  //                                 controller.carDetails.value = false;
  //                                 Scaffold.of(context)
  //                                     .showBodyScrim(false, 0.0);
  //                               },
  //                               child:
  //                               SvgPicture.asset("assets/icons/cross.svg"),
  //                             ),
  //                           ]),
  //                     ),*/
  //                     SizedBox(
  //                       height: 30.kh,
  //                     ),
  //                     Container(
  //                       height: 100.kh,
  //                       width: 260.kw,
  //                       child: Center(
  //                         child: Image.asset("assets/images/bigCars.png"),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 30.kh,
  //                     ),
  //                     Container(
  //                         height: 35.kh,
  //                         width: 165.kw,
  //                         decoration: BoxDecoration(
  //                           color: ColorUtil.kPrimary,
  //                           borderRadius: BorderRadius.all(Radius.circular(20)),
  //                         ),
  //                         child: Center(
  //                             child: Text(
  //                           "${controller.model.value}",
  //                           style: GoogleFonts.urbanist(
  //                             color: Colors.white,
  //                           ),
  //                         ))),
  //                     SizedBox(
  //                       height: 20.kh,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Column(
  //                           children: [
  //                             SvgPicture.asset("assets/icons/battery.svg"),
  //                             Text(
  //                               "320 KM%",
  //                               style: GoogleFonts.urbanist(fontSize: 14),
  //                             ),
  //                           ],
  //                         ),
  //                         Column(
  //                           children: [
  //                             SvgPicture.asset("assets/icons/pepole.svg"),
  //                             Text(
  //                               "${controller.seatCapcity.value}",
  //                               style: GoogleFonts.urbanist(fontSize: 14),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 20.kh,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Container(
  //                             height: 35.kh,
  //                             width: 100.kw,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(20)),
  //                                 border: Border.all(
  //                                     width: 0.5, color: Color(0xFF5F5F5F))),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 SvgPicture.asset(
  //                                   "assets/icons/controlone.svg",
  //                                   color: Color(0xFF5F5F5F),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 5.kh,
  //                                 ),
  //                                 Text(
  //                                   "Control 1",
  //                                   style: GoogleFonts.urbanist(
  //                                     color: Color(0xFF5F5F5F),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                         Container(
  //                             height: 35.kh,
  //                             width: 100.kw,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(20)),
  //                                 border: Border.all(
  //                                     width: 0.5, color: Color(0xFF5F5F5F))),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 SvgPicture.asset(
  //                                   "assets/icons/controltwo.svg",
  //                                   color: Color(0xFF5F5F5F),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 5.kh,
  //                                 ),
  //                                 Text(
  //                                   "Control 2",
  //                                   style: GoogleFonts.urbanist(
  //                                     color: Color(0xFF5F5F5F),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                       ],
  //                     ),
  //
  //                     SizedBox(
  //                       height: 44.kh,
  //                     ),
  //
  //                     Obx(()=>controller.instanceOfGlobalData.loader.value==true?Center(
  //       child: SizedBox(
  //
  //      ),
  //       )
  //                      : ButtonDesign(
  //                           name: "Go to the inspection",
  //                           onPressed: () {
  //                             controller.carInspection.value = true;
  //                             controller.carBooking.value = false;
  //                             // Get.toNamed(Routes.LOGIN);
  //                           }),
  //                     ),
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //
  //                     SizedBox(
  //                       width: 344.kw,
  //                       height: 56.kh,
  //                       child: Obx(()=>controller.instanceOfGlobalData.loader.value==true?Center(
  //                         child: SizedBox(
  //                             width: 344.kw,
  //                             height: 100.kh,
  //                             child: Lottie.asset('assets/json/car_loader.json')),
  //                       ):
  //                          OutlinedButton.icon(
  //                           style: OutlinedButton.styleFrom(
  //                             side: BorderSide(
  //                                 width: 1.5, color: ColorUtil.kPrimary),
  //                           ),
  //                           label: Text('Cancel a trip',
  //                               style: GoogleFonts.urbanist(color: ColorUtil.kPrimary)),
  //                           icon: SvgPicture.asset(
  //                               "assets/icons/canclebuttonicon.svg"),
  //                           onPressed: () {
  //                             showDialog(
  //                                 context: context,
  //                                 builder: (BuildContext context) {
  //                                   return AlertDialog(
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(10.0),
  //                                     ),
  //                                     contentPadding:
  //                                         EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
  //                                     content: Container(
  //                                       height: 100.kh,
  //                                       child: Column(children: [
  //                                         SizedBox(
  //                                           height: 20.kh,
  //                                         ),
  //                                         Text(
  //                                           "Are you sure want to cancel this ride?",
  //                                           textAlign: TextAlign.center,
  //                                           style: GoogleFonts.urbanist(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 20.kh),
  //                                         ),
  //                                       ]),
  //                                     ),
  //                                     actionsPadding: EdgeInsets.all(0),
  //                                     actions: [
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.spaceEvenly,
  //                                         children: [
  //                                           Expanded(
  //                                             child: InkWell(
  //                                               onTap: () {
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child: Container(
  //                                                 height: 56.kh,
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     "No",
  //                                                     style: GoogleFonts.urbanist(
  //                                                         color:
  //                                                             ColorUtil.kPrimary,
  //                                                         fontSize: 16.kh),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             child: InkWell(
  //                                               onTap: () async {
  //                                               controller.cancelBooking();
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                   color: ColorUtil.kPrimary,
  //                                                   borderRadius:
  //                                                       BorderRadius.only(
  //                                                           bottomRight:
  //                                                               Radius.circular(
  //                                                                   10)),
  //                                                 ),
  //                                                 height: 56.kh,
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     "Yes, cancel ride",
  //                                                     style: GoogleFonts.urbanist(
  //                                                         color: Colors.white,
  //                                                         fontSize: 16.kh),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   );
  //                                 });
  //                           },
  //                         ),
  //                       ),
  //                     )
  //                     // SizedBox(
  //                     //   height: 10.kh,
  //                     // ),
  //                   ]),
  //             ),
  //           ),
  //           /*  Positioned(bottom: 0,
  //             //alignment: FractionalOffset.topCenter,
  //             child: Container(
  //               child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
  //             ),
  //           ),*/
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget carInspection(double initialVal) {
  //   return DraggableScrollableSheet(
  //     initialChildSize: initialVal,
  //     minChildSize: 0.7,
  //     maxChildSize: 0.9,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Stack(
  //         children: [
  //           Container(
  //             height: 750.kh,
  //             decoration: BoxDecoration(
  //               color: ColorUtil.kPrimary,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20.0),
  //                   topLeft: Radius.circular(20.0)),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                     child: Container(
  //                   height: 2,
  //                   width: 100.kw,
  //                   color: Colors.white,
  //                 )),
  //                 Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "",
  //                           style: GoogleFonts.urbanist(
  //                               // fontSize: 24.kh,
  //                               color: ColorUtil.ZammaBlack,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         InkWell(
  //                           onTap: () {
  //                             controller.carInspection.value = false;
  //                             Scaffold.of(context).showBodyScrim(false, 0.0);
  //                           },
  //                           child: SvgPicture.asset("assets/icons/cross.svg",
  //                               color: Colors.white),
  //                         ),
  //                       ]),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
  //                   child: Column(
  //                     children: [
  //                       Text("Free Waitig",
  //                           style: GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Obx(
  //                         () => Text(
  //                           "${controller.minute.value}:${controller.start.value}",
  //                           style: GoogleFonts.urbanist(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 28.kh,
  //                               color: Colors.white),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               padding: EdgeInsets.all(16.kh),
  //               height: 600.kh,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(20.0),
  //                     topLeft: Radius.circular(20.0)),
  //               ),
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(
  //                       height: 16.kh,
  //                     ),
  //                     Text(
  //                       "Click respective side of images",
  //                       style: GoogleFonts.urbanist(fontSize: 16.kh),
  //                     ),
  //                     SizedBox(
  //                       height: 24.kh,
  //                     ),
  //
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Obx(
  //                           () => Stack(
  //                             children: [
  //                               InkWell(
  //                                   onTap: () {
  //                                     controller.pickFromCamera("front");
  //                                   },
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(5),
  //                                     height: 157.kh,
  //                                     width: 157.kw,
  //                                     decoration: BoxDecoration(
  //                                       color: Color(0xFFF2F2F2),
  //                                       borderRadius: BorderRadius.only(
  //                                         topRight: Radius.circular(10.0),
  //                                         topLeft: Radius.circular(10.0),
  //                                         bottomRight: Radius.circular(10.0),
  //                                         bottomLeft: Radius.circular(10.0),
  //                                       ),
  //                                       image: DecorationImage(
  //                                         image: FileImage(
  //                                             controller.frontHood.value),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Container(
  //                                   margin: EdgeInsets.all(10.kh),
  //                                   height: 35.kh,
  //                                   width: 100.kw,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(20)),
  //                                       border: Border.all(
  //                                           width: 0.5,
  //                                           color: Color(0xFF5F5F5F))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         "Front hood",
  //                                         style: GoogleFonts.urbanist(
  //                                           color: Color(0xFF000000),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )),
  //                               Positioned.fill(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: SvgPicture.asset(
  //                                         "assets/icons/camera.svg")),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         Obx(
  //                           () => Stack(
  //                             children: [
  //                               InkWell(
  //                                   onTap: () {
  //                                     controller.pickFromCamera("leftside");
  //                                   },
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(5),
  //                                     height: 157.kh,
  //                                     width: 157.kw,
  //                                     decoration: BoxDecoration(
  //                                       color: Color(0xFFF2F2F2),
  //                                       borderRadius: BorderRadius.only(
  //                                         topRight: Radius.circular(10.0),
  //                                         topLeft: Radius.circular(10.0),
  //                                         bottomRight: Radius.circular(10.0),
  //                                         bottomLeft: Radius.circular(10.0),
  //                                       ),
  //                                       image: DecorationImage(
  //                                         image: FileImage(
  //                                             controller.leftSide.value),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Container(
  //                                   margin: EdgeInsets.all(10.kh),
  //                                   height: 35.kh,
  //                                   width: 100.kw,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(20)),
  //                                       border: Border.all(
  //                                           width: 0.5,
  //                                           color: Color(0xFF5F5F5F))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         "Left Side",
  //                                         style: GoogleFonts.urbanist(
  //                                           color: Color(0xFF000000),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )),
  //                               Positioned.fill(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: SvgPicture.asset(
  //                                         "assets/icons/camera.svg")),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Obx(
  //                           () => Stack(
  //                             children: [
  //                               InkWell(
  //                                   onTap: () {
  //                                     controller.pickFromCamera("rightside");
  //                                   },
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(5),
  //                                     height: 157.kh,
  //                                     width: 157.kw,
  //                                     decoration: BoxDecoration(
  //                                       color: Color(0xFFF2F2F2),
  //                                       borderRadius: BorderRadius.only(
  //                                         topRight: Radius.circular(10.0),
  //                                         topLeft: Radius.circular(10.0),
  //                                         bottomRight: Radius.circular(10.0),
  //                                         bottomLeft: Radius.circular(10.0),
  //                                       ),
  //                                       image: DecorationImage(
  //                                         image: FileImage(
  //                                             controller.rightSide.value),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Container(
  //                                   margin: EdgeInsets.all(10.kh),
  //                                   height: 35.kh,
  //                                   width: 100.kw,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(20)),
  //                                       border: Border.all(
  //                                           width: 0.5,
  //                                           color: Color(0xFF5F5F5F))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         "Right Side",
  //                                         style: GoogleFonts.urbanist(
  //                                           color: Color(0xFF000000),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )),
  //                               Positioned.fill(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: SvgPicture.asset(
  //                                         "assets/icons/camera.svg")),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         Obx(
  //                           () => Stack(
  //                             children: [
  //                               InkWell(
  //                                   onTap: () {
  //                                     controller.pickFromCamera("backside");
  //                                   },
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(5),
  //                                     height: 157.kh,
  //                                     width: 157.kw,
  //                                     decoration: BoxDecoration(
  //                                       color: Color(0xFFF2F2F2),
  //                                       borderRadius: BorderRadius.only(
  //                                         topRight: Radius.circular(10.0),
  //                                         topLeft: Radius.circular(10.0),
  //                                         bottomRight: Radius.circular(10.0),
  //                                         bottomLeft: Radius.circular(10.0),
  //                                       ),
  //                                       image: DecorationImage(
  //                                         image: FileImage(
  //                                             controller.backSide.value),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Container(
  //                                   margin: EdgeInsets.all(10.kh),
  //                                   height: 35.kh,
  //                                   width: 100.kw,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(20)),
  //                                       border: Border.all(
  //                                           width: 0.5,
  //                                           color: Color(0xFF5F5F5F))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       Text(
  //                                         "Back Side",
  //                                         style: GoogleFonts.urbanist(
  //                                           color: Color(0xFF000000),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )),
  //                               Positioned.fill(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: SvgPicture.asset(
  //                                         "assets/icons/camera.svg")),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     SizedBox(
  //                       height: 40.kh,
  //                     ),
  //
  //                     Obx(
  //                       () =>
  //                           controller.instanceOfGlobalData.loader.value == true
  //                               ? Center(
  //                                   child: SizedBox(
  //                                       width: 200.kh,
  //                                       height: 56.kh,
  //                                       child: Lottie.asset(
  //                                           'assets/json/car_loader.json')),
  //                                 )
  //                               : ButtonDesign(
  //                                   name: "Done",
  //                                   onPressed: () {
  //                                     controller.rideStart.value=true;
  //                                     controller.carInspection.value=false;
  //                                     /*controller.uploadInspectionImage().then((value) {
  //                                       if(value==1){
  //                                           controller.rideStart.value=true;
  //                                            controller.carInspection.value=false;
  //                                       }else{
  //                                         showMySnackbar(title: "Error", msg: "Error while inspection");
  //                                       }
  //
  //                                     });*/
  //
  //                                     // Get.toNamed(Routes.LOGIN);
  //                                   }),
  //                     ),
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //
  //                     SizedBox(
  //                       width: 344.kw,
  //                       height: 56.kh,
  //                       child: Obx(()=>controller.instanceOfGlobalData.loader.value == true
  //                           ? Center(
  //                         child: SizedBox(
  //
  //                             ),
  //                       ):
  //                          OutlinedButton.icon(
  //                           style: OutlinedButton.styleFrom(
  //                             side: BorderSide(
  //                                 width: 1.5, color: ColorUtil.kPrimary),
  //                           ),
  //                           label: Text('Cancel a trip',
  //                               style: GoogleFonts.urbanist(color: ColorUtil.kPrimary)),
  //                           icon: SvgPicture.asset(
  //                               "assets/icons/canclebuttonicon.svg"),
  //                           onPressed: () {
  //                             showDialog(
  //                                 context: context,
  //                                 builder: (BuildContext context) {
  //                                   return AlertDialog(
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(10.0),
  //                                     ),
  //                                     contentPadding:
  //                                     EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
  //                                     content: Container(
  //                                       height: 100.kh,
  //                                       child: Column(children: [
  //                                         SizedBox(
  //                                           height: 20.kh,
  //                                         ),
  //                                         Text(
  //                                           "Are you sure want to cancel this ride?",
  //                                           textAlign: TextAlign.center,
  //                                           style: GoogleFonts.urbanist(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 20.kh),
  //                                         ),
  //                                       ]),
  //                                     ),
  //                                     actionsPadding: EdgeInsets.all(0),
  //                                     actions: [
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                         MainAxisAlignment.spaceEvenly,
  //                                         children: [
  //                                           Expanded(
  //                                             child: InkWell(
  //                                               onTap: () {
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child: Container(
  //                                                 height: 56.kh,
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     "No",
  //                                                     style: GoogleFonts.urbanist(
  //                                                         color:
  //                                                         ColorUtil.kPrimary,
  //                                                         fontSize: 16.kh),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             child: InkWell(
  //                                               onTap: () async {
  //                                                 controller.cancelBooking();
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                   color: ColorUtil.kPrimary,
  //                                                   borderRadius:
  //                                                   BorderRadius.only(
  //                                                       bottomRight:
  //                                                       Radius.circular(
  //                                                           10)),
  //                                                 ),
  //                                                 height: 56.kh,
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     "Yes, cancel ride",
  //                                                     style: GoogleFonts.urbanist(
  //                                                         color: Colors.white,
  //                                                         fontSize: 16.kh),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   );
  //                                 });
  //                           },
  //                         ),
  //                       ),
  //                     )
  //                     // SizedBox(
  //                     //   height: 10.kh,
  //                     // ),
  //                   ]),
  //             ),
  //           ),
  //           /*  Positioned(bottom: 0,
  //             //alignment: FractionalOffset.topCenter,
  //             child: Container(
  //               child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
  //             ),
  //           ),*/
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget rideStart(double initialVal) {
  //   controller.rideTimer();
  //   return DraggableScrollableSheet(
  //     initialChildSize: initialVal,
  //     minChildSize: 0.7,
  //     maxChildSize: 0.75,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Stack(
  //         children: [
  //           Container(
  //             height: 750.kh,
  //             decoration: BoxDecoration(
  //               color: ColorUtil.kPrimary,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20.0),
  //                   topLeft: Radius.circular(20.0)),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                     child: Container(
  //                   height: 2,
  //                   width: 100.kw,
  //                   color: Colors.white,
  //                 )),
  //                 Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "",
  //                           style: GoogleFonts.urbanist(
  //                               // fontSize: 24.kh,
  //                               color: ColorUtil.ZammaBlack,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         InkWell(
  //                           onTap: () {
  //                             controller.rideStart.value = false;
  //                             Scaffold.of(context).showBodyScrim(false, 0.0);
  //                           },
  //                           child: SvgPicture.asset("assets/icons/cross.svg",
  //                               color: Colors.white),
  //                         ),
  //                       ]),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
  //                   child: Column(
  //                     children: [
  //                       Text("Onging Trip",
  //                           style: GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Obx(
  //                         () => Text(
  //                           "${controller.ridehour.value < 10 ? "0" + "${controller.ridehour.value}" : controller.ridehour.value}:${controller.rideminute.value < 10 ? "0" + "${controller.rideminute.value}" : controller.rideminute.value}:${controller.ridestart.value < 10 ? "0" + "${controller.ridestart.value}" : controller.ridestart.value}",
  //                           style: GoogleFonts.urbanist(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 28.kh,
  //                               color: Colors.white),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               height: 500.kh,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(20.0),
  //                     topLeft: Radius.circular(20.0)),
  //               ),
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     /*Container(
  //                       height: 30.kh,
  //                       margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               "",
  //                               style: GoogleFonts.urbanist(
  //                                   fontSize: 24.kh,
  //                                   color: ColorUtil.ZammaBlack,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                             InkWell(
  //                               onTap: () {
  //                                 controller.carDetails.value = false;
  //                                 Scaffold.of(context)
  //                                     .showBodyScrim(false, 0.0);
  //                               },
  //                               child:
  //                               SvgPicture.asset("assets/icons/cross.svg"),
  //                             ),
  //                           ]),
  //                     ),*/
  //                     SizedBox(
  //                       height: 30.kh,
  //                     ),
  //                     Container(
  //                       height: 100.kh,
  //                       width: 260.kw,
  //                       child: Center(
  //                         child: Image.asset("assets/images/bigCars.png"),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 30.kh,
  //                     ),
  //                     Container(
  //                         height: 35.kh,
  //                         width: 165.kw,
  //                         decoration: BoxDecoration(
  //                           color: ColorUtil.kPrimary,
  //                           borderRadius: BorderRadius.all(Radius.circular(20)),
  //                         ),
  //                         child: Center(
  //                             child: Text(
  //                           "${controller.model.value}",
  //                           style: GoogleFonts.urbanist(
  //                             color: Colors.white,
  //                           ),
  //                         ))),
  //                     SizedBox(
  //                       height: 20.kh,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Column(
  //                           children: [
  //                             SvgPicture.asset("assets/icons/battery.svg"),
  //                             Text(
  //                               "320 KM%",
  //                               style: GoogleFonts.urbanist(fontSize: 14),
  //                             ),
  //                           ],
  //                         ),
  //                         Column(
  //                           children: [
  //                             SvgPicture.asset("assets/icons/pepole.svg"),
  //                             Text(
  //                               "${controller.seatCapcity.value}",
  //                               style: GoogleFonts.urbanist(fontSize: 14),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 20.kh,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Container(
  //                             height: 35.kh,
  //                             width: 165.kw,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(20)),
  //                                 border: Border.all(
  //                                     width: 0.5, color: Color(0xFF5F5F5F))),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 SvgPicture.asset(
  //                                   "assets/icons/report.svg",
  //                                   color: Color(0xFF5F5F5F),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 5.kh,
  //                                 ),
  //                                 Text(
  //                                   "Report a problem",
  //                                   style: GoogleFonts.urbanist(
  //                                     color: Color(0xFF5F5F5F),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                       ],
  //                     ),
  //
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //                     ListTile(
  //                         leading: Text(
  //                           "Order Summary",
  //                           style: GoogleFonts.urbanist(fontSize: 16.kh),
  //                         ),
  //                         trailing: Icon(Icons.arrow_forward_ios)),
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //
  //                     ButtonDesign(
  //                         name: "Pause and close the door",
  //                         onPressed: () {
  //                           //controller.carBooking.value = false;
  //                           // Get.toNamed(Routes.LOGIN);
  //                         }),
  //                     SizedBox(
  //                       height: 10.kh,
  //                     ),
  //
  //                     SizedBox(
  //                       width: 344.kw,
  //                       height: 56.kh,
  //                       child: OutlinedButton.icon(
  //                         style: OutlinedButton.styleFrom(
  //                           side: BorderSide(
  //                               width: 1.5, color: ColorUtil.kPrimary),
  //                         ),
  //                         label: Text('Complete the trip',
  //                             style: GoogleFonts.urbanist(color: ColorUtil.kPrimary)),
  //                         icon: SvgPicture.asset("assets/icons/complete.svg"),
  //                         onPressed: () {
  //                           showDialog(
  //                               context: context,
  //                               builder: (BuildContext context) {
  //                                 return AlertDialog(
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                   contentPadding:
  //                                       EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
  //                                   content: Container(
  //                                     height: 100.kh,
  //                                     child: Column(children: [
  //                                       SizedBox(
  //                                         height: 20.kh,
  //                                       ),
  //                                       Text(
  //                                         "Are you sure want to end this ride?",
  //                                         textAlign: TextAlign.center,
  //                                         style: GoogleFonts.urbanist(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 20.kh),
  //                                       ),
  //                                     ]),
  //                                   ),
  //                                   actionsPadding: EdgeInsets.all(0),
  //                                   actions: [
  //                                     Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceEvenly,
  //                                       children: [
  //                                         Expanded(
  //                                           child: InkWell(
  //                                             onTap: () {
  //                                               Navigator.pop(context);
  //                                             },
  //                                             child: Container(
  //                                               height: 56.kh,
  //                                               child: Center(
  //                                                 child: Text(
  //                                                   "No",
  //                                                   style: GoogleFonts.urbanist(
  //                                                       color:
  //                                                           ColorUtil.kPrimary,
  //                                                       fontSize: 16.kh),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Expanded(
  //                                           child: InkWell(
  //                                             onTap: () async {
  //                                               /* controller.onBoardingStatus.value=false;
  //                                     Get.find<GetStorageService>().deleteLocation();
  //                                     Get.find<TokenCreateGenrate>().signOut();*/
  //                                               controller.enrideInspection.value = true;
  //                                               controller.rideStart.value = false;
  //                                               /*  await controller
  //                                                   .LogoutAnDeleteEveryThing();*/
  //                                               Navigator.pop(context);
  //                                             },
  //                                             child: Container(
  //                                               decoration: BoxDecoration(
  //                                                 color: ColorUtil.kPrimary,
  //                                                 borderRadius:
  //                                                     BorderRadius.only(
  //                                                         bottomRight:
  //                                                             Radius.circular(
  //                                                                 10)),
  //                                               ),
  //                                               height: 56.kh,
  //                                               child: Center(
  //                                                 child: Text(
  //                                                   "Yes, End ride",
  //                                                   style: GoogleFonts.urbanist(
  //                                                       color: Colors.white,
  //                                                       fontSize: 16.kh),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 );
  //                               });
  //                         },
  //                       ),
  //                     )
  //                     // SizedBox(
  //                     //   height: 10.kh,
  //                     // ),
  //                   ]),
  //             ),
  //           ),
  //           /*  Positioned(bottom: 0,
  //             //alignment: FractionalOffset.topCenter,
  //             child: Container(
  //               child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
  //             ),
  //           ),*/
  //         ],
  //       );
  //     },
  //   );
  // }
  //


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
                      Container(
                        height: 30.kh,
                        margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Description",
                                style: GoogleFonts.urbanist(
                                    fontSize: 20.kh,
                                    color: ColorUtil.ZammaBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.bookingPriceDetails.value = false;
                                  Scaffold.of(context)
                                      .showBodyScrim(false, 0.0);
                                },
                                child:
                                    SvgPicture.asset("assets/icons/cross.svg"),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 300.kh,
                              child: Text(
                                "We’ll transact an amount of \$${1} to verify your card details.",
                                style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.kh),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.kh,
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
                                      name: "Verify Payment",
                                      onPressed: () {
                                        //  Get.toNamed(Routes.CAMERA_DESIGN);
                                        controller.getAddressFromLatLng();
                                        controller.onBoardingStatus().then((value) {
                                          if (value == 1) {
                                            //   Get.find<GlobalData>().QNR.value=controller.carId.value;
                                            controller.getInProcessHistory().then((value) {
                                              if (value == 1) {
                                                showMySnackbar(
                                                    title: "Error",
                                                    msg: "Complete inprogress ride before booking new ride");
                                              } else {
                                                controller.getOnGoingHistory().then((value) {
                                                  if (value == 1) {
                                                    showMySnackbar(
                                                        title: "Error",
                                                        msg: "Complete your ongoing ride before booking new ride");
                                                  } else {
                                                    print(controller.model.value);

                                                    if (controller.logindetails.value.user?.isSuspended == false)
                                                      Get.toNamed(
                                                          Routes.SAVED_CARDS,
                                                          arguments: [
                                                            (controller.createBookinModel.value.booking?.Id),
                                                            (controller.model.value),
                                                            (controller.seatCapcity.value),
                                                            true,
                                                            "basic",
                                                            1.0,
                                                            0,
                                                            0
                                                          ]
                                                          //  );
                                                          // controller.createBooking(carId: controller.carId.value, qnr: controller.qnr.value).then((value) {
                                                          //   if (value == 1){
                                                          //     Get.toNamed(
                                                          //       Routes.SAVED_CARDS,
                                                          //
                                                          //         arguments: [
                                                          //       (controller.createBookinModel.value.booking?.Id),
                                                          //       (controller.model.value),
                                                          //       (controller.seatCapcity.value),
                                                          //       true,"basic",1.0,0,0
                                                          //     ]);
                                                          //     print("Booking Id ${(controller.createBookinModel.value.booking?.Id)}");
                                                          //     // controller.carBooking.value = true;
                                                          //     controller.bookingPriceDetails.value = false;
                                                          //   }
                                                          // }
                                                          //
                                                          );
                                                    else
                                                      showMySnackbar(
                                                          title: "Error",
                                                          msg:
                                                              "User blocked by the admin");
                                                  }
                                                });
                                              }
                                            });
                                          } else {
                                            if (controller.logindetails.value
                                                    .user?.isApproved ==
                                                false) {
                                              showMySnackbar(
                                                  title: "Error",
                                                  msg:
                                                      "User blocked or rejected by the admin");
                                            } else if (controller.logindetails
                                                    .value.user?.isSuspended ==
                                                true) {
                                              showMySnackbar(
                                                  title: "Error",
                                                  msg:
                                                      "User blocked by the admin");
                                            } else {
                                              showMySnackbar(
                                                  title: "Error",
                                                  msg:
                                                      "You Need To Login First");
                                            }
                                          }
                                        });
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

//
// Widget enrideInspection(double initialVal) {
//   return DraggableScrollableSheet(
//     initialChildSize: initialVal,
//     minChildSize: 0.8,
//     maxChildSize: 0.9,
//     builder: (BuildContext context, ScrollController scrollController) {
//       return Stack(
//         children: [
//           Container(
//             height: 650.kh,
//             decoration: BoxDecoration(
//               color: ColorUtil.kPrimary,
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20.0),
//                   topLeft: Radius.circular(20.0)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                     child: Container(
//                       height: 2,
//                       width: 100.kw,
//                       color: Colors.white,
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "",
//                           style: GoogleFonts.urbanist(
//                             // fontSize: 24.kh,
//                               color: ColorUtil.ZammaBlack,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             controller.carInspection.value = false;
//                             Scaffold.of(context).showBodyScrim(false, 0.0);
//                           },
//                           child: SvgPicture.asset("assets/icons/cross.svg",
//                               color: Colors.white),
//                         ),
//                       ]),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Column(
//                     children: [
//                       Text("Onging Trip",
//                           style: GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Obx(
//                             () => Text(
//                               "${controller.ridehour.value < 10 ? "0" + "${controller.ridehour.value}" : controller.ridehour.value}:${controller.rideminute.value < 10 ? "0" + "${controller.rideminute.value}" : controller.rideminute.value}:${controller.ridestart.value < 10 ? "0" + "${controller.ridestart.value}" : controller.ridestart.value}",
//                           style: GoogleFonts.urbanist(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 28.kh,
//                               color: Colors.white),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(16.kh),
//               height: 550.kh,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20.0),
//                     topLeft: Radius.circular(20.0)),
//               ),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 16.kh,
//                     ),
//                     Text(
//                       "Click respective side of images",
//                       style: GoogleFonts.urbanist(fontSize: 16.kh),
//                     ),
//                     SizedBox(
//                       height: 24.kh,
//                     ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Obx(
//                               () => Stack(
//                             children: [
//                               InkWell(
//                                   onTap: () {
//                                     controller.pickFromCamera("front");
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5),
//                                     height: 157.kh,
//                                     width: 157.kw,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFF2F2F2),
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10.0),
//                                         topLeft: Radius.circular(10.0),
//                                         bottomRight: Radius.circular(10.0),
//                                         bottomLeft: Radius.circular(10.0),
//                                       ),
//                                       image: DecorationImage(
//                                         image: FileImage(
//                                             controller.frontHood.value),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.all(10.kh),
//                                   height: 35.kh,
//                                   width: 100.kw,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20)),
//                                       border: Border.all(
//                                           width: 0.5,
//                                           color: Color(0xFF5F5F5F))),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Front hood",
//                                         style: GoogleFonts.urbanist(
//                                           color: Color(0xFF000000),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               Positioned.fill(
//                                 child: Align(
//                                     alignment: Alignment.center,
//                                     child: SvgPicture.asset(
//                                         "assets/icons/camera.svg")),
//                               )
//                             ],
//                           ),
//                         ),
//                         Obx(
//                               () => Stack(
//                             children: [
//                               InkWell(
//                                   onTap: () {
//                                     controller.pickFromCamera("leftside");
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5),
//                                     height: 157.kh,
//                                     width: 157.kw,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFF2F2F2),
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10.0),
//                                         topLeft: Radius.circular(10.0),
//                                         bottomRight: Radius.circular(10.0),
//                                         bottomLeft: Radius.circular(10.0),
//                                       ),
//                                       image: DecorationImage(
//                                         image: FileImage(
//                                             controller.leftSide.value),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.all(10.kh),
//                                   height: 35.kh,
//                                   width: 100.kw,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20)),
//                                       border: Border.all(
//                                           width: 0.5,
//                                           color: Color(0xFF5F5F5F))),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Left Side",
//                                         style: GoogleFonts.urbanist(
//                                           color: Color(0xFF000000),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               Positioned.fill(
//                                 child: Align(
//                                     alignment: Alignment.center,
//                                     child: SvgPicture.asset(
//                                         "assets/icons/camera.svg")),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10.kh,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Obx(
//                               () => Stack(
//                             children: [
//                               InkWell(
//                                   onTap: () {
//                                     controller.pickFromCamera("rightside");
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5),
//                                     height: 157.kh,
//                                     width: 157.kw,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFF2F2F2),
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10.0),
//                                         topLeft: Radius.circular(10.0),
//                                         bottomRight: Radius.circular(10.0),
//                                         bottomLeft: Radius.circular(10.0),
//                                       ),
//                                       image: DecorationImage(
//                                         image: FileImage(
//                                             controller.rightSide.value),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.all(10.kh),
//                                   height: 35.kh,
//                                   width: 100.kw,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20)),
//                                       border: Border.all(
//                                           width: 0.5,
//                                           color: Color(0xFF5F5F5F))),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Right Side",
//                                         style: GoogleFonts.urbanist(
//                                           color: Color(0xFF000000),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               Positioned.fill(
//                                 child: Align(
//                                     alignment: Alignment.center,
//                                     child: SvgPicture.asset(
//                                         "assets/icons/camera.svg")),
//                               )
//                             ],
//                           ),
//                         ),
//                         Obx(
//                               () => Stack(
//                             children: [
//                               InkWell(
//                                   onTap: () {
//                                     controller.pickFromCamera("backside");
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(5),
//                                     height: 157.kh,
//                                     width: 157.kw,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFF2F2F2),
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10.0),
//                                         topLeft: Radius.circular(10.0),
//                                         bottomRight: Radius.circular(10.0),
//                                         bottomLeft: Radius.circular(10.0),
//                                       ),
//                                       image: DecorationImage(
//                                         image: FileImage(
//                                             controller.backSide.value),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.all(10.kh),
//                                   height: 35.kh,
//                                   width: 100.kw,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20)),
//                                       border: Border.all(
//                                           width: 0.5,
//                                           color: Color(0xFF5F5F5F))),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Back Side",
//                                         style: GoogleFonts.urbanist(
//                                           color: Color(0xFF000000),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                               Positioned.fill(
//                                 child: Align(
//                                     alignment: Alignment.center,
//                                     child: SvgPicture.asset(
//                                         "assets/icons/camera.svg")),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(
//                       height: 40.kh,
//                     ),
//
//                     Obx(
//                           () =>
//                       controller.instanceOfGlobalData.loader.value == true
//                           ? Center(
//                         child: SizedBox(
//                             width: 200.kh,
//                             height: 56.kh,
//                             child: Lottie.asset(
//                                 'assets/json/car_loader.json')),
//                       )
//                           : ButtonDesign(
//                           name: "Done",
//                           onPressed: () {
//
//                             controller.uploadInspectionImage().then((value) {
//                               if(value==1){
//                                 controller.rideStart.value=true;
//                                 controller.carInspection.value=false;
//                               }else{
//                                 showMySnackbar(title: "Error", msg: "Error while inspection");
//                               }
//
//                             });
//
//                             // Get.toNamed(Routes.LOGIN);
//                           }),
//                     ),
//                     // SizedBox(
//                     //   height: 10.kh,
//                     // ),
//                   ]),
//             ),
//           ),
//           /*  Positioned(bottom: 0,
//             //alignment: FractionalOffset.topCenter,
//             child: Container(
//               child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
//             ),
//           ),*/
//         ],
//       );
//     },
//   );
// }
  Widget customePrice(double initialVal) {
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
                child: Obx(
                  () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Container(
                          height: 2,
                          width: 100.kw,
                          color: ColorUtil.kPrimary,
                        )),
                        Container(
                          height: 30.kh,
                          margin: EdgeInsets.fromLTRB(16.kw, 24.kh, 16.kw, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Description",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 20.kh,
                                      color: ColorUtil.ZammaBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.customePrice.value = false;
                                    Scaffold.of(context)
                                        .showBodyScrim(false, 0.0);
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/cross.svg"),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 16.kh,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Obx(() => Text(
                                "Amount: \$ ${controller.finalAmount.value} ",
                                style: GoogleFonts.urbanist(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          height: 16.kh,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            "Time ",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                          height: 80.kh,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.timeLength.value,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.timeTapAttention.value = index;

                                      controller.calculateCharges();
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(16, 16, 0, 16),
                                      height: 50.kh,
                                      width: 50.kw,
                                      decoration: BoxDecoration(
                                          color: controller
                                                      .timeTapAttention.value ==
                                                  index
                                              ? Colors.indigo
                                              : Colors.white,
                                          border: Border.all(
                                            color: ColorUtil.kPrimary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                          child: Text(
                                        "${(controller.carPriceById.value.carPricing?.pricingRules?[index]?.hours)} \nhour",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.bold,
                                            color: controller.timeTapAttention
                                                        .value ==
                                                    index
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Obx(() => Text(
                                "Extra charges \$${controller.extraMinuteCharges.value}/minute ",
                              )),
                        ),
                        SizedBox(
                          height: 16.kh,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            "Distance ",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                          height: 80.kh,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.milesLength.value,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.distanceTapAttention.value =
                                          index;
                                      controller.calculateCharges();
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(16, 16, 0, 16),
                                      height: 50.kh,
                                      width: 50.kw,
                                      decoration: BoxDecoration(
                                          color: controller.distanceTapAttention
                                                      .value ==
                                                  index
                                              ? Colors.indigo
                                              : Colors.white,
                                          border: Border.all(
                                            color: ColorUtil.kPrimary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                          child: Text(
                                        "${(controller.carPriceById.value.carPricing?.mileageRates?[index]?.miles)!} \n miles",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.bold,
                                            color: controller
                                                        .distanceTapAttention
                                                        .value ==
                                                    index
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Obx(() => Text(
                                "Extra charges \$${controller.extraMilesCharges.value}/mile",
                              )),
                        ),
                        SizedBox(
                          height: 24.kh,
                        ),
                        Center(
                          child: Obx(
                            () =>
                                controller.instanceOfGlobalData.loader.value ==
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
                                            name: "Book",
                                            onPressed: () {
                                              controller.getAddressFromLatLng();
                                              controller
                                                  .onBoardingStatus()
                                                  .then((value) {
                                                if (value == 1) {
                                                  //   Get.find<GlobalData>().QNR.value=controller.carId.value;
                                                  controller
                                                      .getInProcessHistory()
                                                      .then((value) {
                                                    if (value == 1) {
                                                      showMySnackbar(
                                                          title: "Error",
                                                          msg:
                                                              "Complete inprogress ride before booking new ride");
                                                    } else {
                                                      controller
                                                          .getOnGoingHistory()
                                                          .then((value) {
                                                        if (value == 1) {
                                                          showMySnackbar(
                                                              title: "Error",
                                                              msg:
                                                                  "Complete your ongoing ride before booking new ride");
                                                        } else {
                                                          if (controller
                                                                  .logindetails
                                                                  .value
                                                                  .user
                                                                  ?.isSuspended ==
                                                              false)
                                                            controller
                                                                .createBooking(
                                                                    carId: controller
                                                                        .carId
                                                                        .value,
                                                                    qnr: controller
                                                                        .qnr
                                                                        .value)
                                                                .then((value) {
                                                              if (value == 1) {
                                                                Get.toNamed(
                                                                    Routes
                                                                        .SAVED_CARDS,
                                                                    arguments: [
                                                                      (controller
                                                                          .createBookinModel
                                                                          .value
                                                                          .booking
                                                                          ?.Id),
                                                                      (controller
                                                                          .model
                                                                          .value),
                                                                      (controller
                                                                          .seatCapcity
                                                                          .value),
                                                                      true,
                                                                      "custom",
                                                                      (controller
                                                                          .finalAmount
                                                                          .value),
                                                                      (controller
                                                                          .carPriceById
                                                                          .value
                                                                          .carPricing
                                                                          ?.mileageRates?[controller
                                                                              .distanceTapAttention
                                                                              .value]
                                                                          ?.miles),
                                                                      (controller
                                                                          .carPriceById
                                                                          .value
                                                                          .carPricing
                                                                          ?.pricingRules?[controller
                                                                              .timeTapAttention
                                                                              .value]
                                                                          ?.hours)
                                                                    ]);
                                                                // Get.toNamed(Routes.BOOKING,
                                                                //     arguments: [
                                                                //       (controller
                                                                //           .createBookinModel
                                                                //           .value
                                                                //           .booking
                                                                //           ?.Id),
                                                                //       (controller
                                                                //           .model.value),
                                                                //       (controller
                                                                //           .seatCapcity.value),
                                                                //       true
                                                                //     ]);
                                                                print(
                                                                    "Booking Id ${(controller.createBookinModel.value.booking?.Id)}");
                                                                // controller.carBooking.value = true;
                                                                controller
                                                                    .customePrice
                                                                    .value = false;
                                                              }
                                                            });
                                                          else
                                                            showMySnackbar(
                                                                title: "Error",
                                                                msg:
                                                                    "User blocked or rejected by the admin");
                                                        }
                                                      });
                                                    }
                                                  });
                                                } else {
                                                  showMySnackbar(
                                                      title: "Error",
                                                      msg:
                                                          "User blocked or rejected by the admin");
                                                }
                                              });
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
            ),
          ],
        );
      },
    );
  }
}
