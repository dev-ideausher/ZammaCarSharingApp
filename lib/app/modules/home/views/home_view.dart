import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Obx(
        () => Stack(
          children: [
            Container(
              height: 720.kh,
              color: Colors.blue,
              child: GoogleMap(
                onMapCreated: (mapController) {
                  controller.mapCompleter.complete(mapController);
                },
                markers: controller.listOfMarker,
                initialCameraPosition: CameraPosition(
                  target: controller.center,
                  zoom: 11.0,
                ),
              ),
            ),
            Get.find<GlobalData>().isloginStatusGlobal.value == false
                ? Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      height: 180.kh,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Get.find<GlobalData>()
                                            .isloginStatusGlobal
                                            .value ==
                                        false
                                    ? InkWell(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
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
                                                              style: TextStyle(
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
                                                        style: TextStyle(
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
                                                              style: TextStyle(
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
                                          );
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
                                              style: TextStyle(
                                                  fontSize: 15.kh,
                                                  color: ColorUtil.ZammaGrey),
                                            )
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
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
                                                              style: TextStyle(
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
                                                        style: TextStyle(
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
                                                              style: TextStyle(
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
                                          );
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
                                              style: TextStyle(
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
                                      SvgPicture.asset("assets/icons/cars.svg"),
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      Text(
                                        "Cars",
                                        style: TextStyle(
                                            fontSize: 15.kh,
                                            color: ColorUtil.ZammaGrey),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.zone.value = true;
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      SvgPicture.asset("assets/icons/zone.svg"),
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      Text(
                                        "Zone",
                                        style: TextStyle(
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
                                        style: TextStyle(
                                            fontSize: 15.kh,
                                            color: ColorUtil.ZammaGrey),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          child: ButtonDesign(name: "Login", onPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          }),
                        ),
                      ]),
                    ),
                  )
                : Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      height: 110.kh,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Get.find<GlobalData>()
                                            .isloginStatusGlobal
                                            .value ==
                                        false
                                    ? InkWell(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
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
                                                              style: TextStyle(
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
                                                        style: TextStyle(
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
                                                              style: TextStyle(
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
                                          );
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
                                              style: TextStyle(
                                                  fontSize: 15.kh,
                                                  color: ColorUtil.ZammaGrey),
                                            )
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
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
                                                              style: TextStyle(
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
                                                        style: TextStyle(
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
                                                              style: TextStyle(
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
                                          );
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
                                              style: TextStyle(
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
                                      SvgPicture.asset("assets/icons/cars.svg"),
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      Text(
                                        "Cars",
                                        style: TextStyle(
                                            fontSize: 15.kh,
                                            color: ColorUtil.ZammaGrey),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.zone.value = true;
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      SvgPicture.asset("assets/icons/zone.svg"),
                                      SizedBox(
                                        height: 10.kh,
                                      ),
                                      Text(
                                        "Zone",
                                        style: TextStyle(
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
                                        style: TextStyle(
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
            controller.carDetails.value == true ? carDetails(0.4) : SizedBox(),
            controller.zone.value == true ? zone(0.4) : SizedBox(),
            controller.carBooking.value == true ? carBooking(0.4) : SizedBox(),
          ],
        ),
      )),
    );
  }

  Widget cars(double initialVal) {
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
                        "Cars",
                        style: TextStyle(
                            fontSize: 24.kh,
                            color: ColorUtil.ZammaBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          controller.cars.value = false;
                          Scaffold.of(context).showBodyScrim(false, 0.0);
                        },
                        child: SvgPicture.asset("assets/icons/cross.svg"),
                      ),
                    ]),
              ),
              SizedBox(
                height: 30.kh,
              ),
              Container(
                height: 60.kh,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.categoriesModels.value.category?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.tapAttention.value = index;
                          controller.getSelectCategoyCars(
                              "${(controller.categoriesModels.value.category?[index]?.name)?.toLowerCase()}");
                        },
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            padding: const EdgeInsets.fromLTRB(20, 3, 20, 0),
                            decoration: BoxDecoration(
                              color: controller.tapAttention.value == index
                                  ? ColorUtil.kPrimary
                                  : Colors.white,
                              border: Border.all(color: ColorUtil.ZammaGrey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              "${controller.categoriesModels.value.category?[index]?.name}",
                              style: TextStyle(
                                  color: controller.tapAttention.value == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Obx(
                () => Expanded(
                  child: controller.instanceOfGlobalData.loader.value == true
                      ? Center(
                          child: SizedBox(
                              width: 200.kh,
                              height: 100.kh,
                              child:
                                  Lottie.asset('assets/json/car_loader.json')),
                        )
                      : controller.carsModel.value.cars?.isEmpty == true
                          ? Center(
                              child: SizedBox(
                              child: Text("No Cars Available"),
                            ))
                          : ListView.builder(
                              itemCount:
                                  controller.carsModel.value.cars?.length,
                              itemBuilder: (contex, index) {
                                return InkWell(
                                  onTap: () {
                                    controller.model.value =
                                        "${controller.carsModel.value.cars?[index]?.brand} ${controller.carsModel.value.cars?[index]?.model}";
                                    controller.seatCapcity.value = (controller
                                            .carsModel
                                            .value
                                            .cars?[index]
                                            ?.seatCapacity)
                                        .toString();
                                    controller.cars.value = false;
                                    controller.carDetails.value = true;
                                  },
                                  child: Container(
                                      height: 90.kh,
                                      margin: EdgeInsets.fromLTRB(16, 5, 16, 0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtil.ZammaGrey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 10, 10),
                                            width: 100.kh,
                                            child: Image.asset(
                                                "assets/images/carImage.png"),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.carsModel.value.cars?[index]?.brand} ${controller.carsModel.value.cars?[index]?.model}",
                                                style: TextStyle(
                                                    color: ColorUtil.kPrimary,
                                                    fontSize: 16.kh,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${controller.carsModel.value.cars?[index]?.carType}",
                                                style: TextStyle(
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
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
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
                                style: TextStyle(
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
                                child:
                                    SvgPicture.asset("assets/icons/cross.svg"),
                              ),
                            ]),
                      ),
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                              child: Text(
                            "${controller.model.value}",
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
                                "${controller.seatCapcity.value}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      ListTile(
                          leading:
                              SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text("Feature 1",
                                  style: TextStyle(fontSize: 18.kh))),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 24.kh,
                      ),
                      ListTile(
                          leading:
                              SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Feature 2",
                                style: TextStyle(fontSize: 18.kh),
                              )),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 24.kh,
                      ),
                      ListTile(
                          leading:
                              SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text("Feature 3",
                                  style: TextStyle(fontSize: 18.kh))),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 20.kh,
                      ),
                      Obx(() => Get.find<GlobalData>().isloginStatusGlobal ==
                              false
                          ? Container(
                              child: ButtonDesign(
                                  name: "Login", onPressed: () {
                                Get.toNamed(Routes.LOGIN);
                              }),
                            )
                          : Container(
                              child:
                                  ButtonDesign(name: "Book", onPressed: () {
                                    controller.carBooking.value = true;
                           // Get.toNamed(Routes.RIDE_BOOKED);
                                  }),
                            )),
                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
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
                        "Cars",
                        style: TextStyle(
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

  Widget carBooking(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
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
                                style: TextStyle(
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
                                child:
                                SvgPicture.asset("assets/icons/cross.svg"),
                              ),
                            ]),
                      ),
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                              child: Text(
                                "${controller.model.value}",
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
                                "${controller.seatCapcity.value}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      ListTile(
                          leading:
                          SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text("Feature 1",
                                  style: TextStyle(fontSize: 18.kh))),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 24.kh,
                      ),
                      ListTile(
                          leading:
                          SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Feature 2",
                                style: TextStyle(fontSize: 18.kh),
                              )),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 24.kh,
                      ),
                      ListTile(
                          leading:
                          SvgPicture.asset("assets/icons/featureicon.svg"),
                          title: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text("Feature 3",
                                  style: TextStyle(fontSize: 18.kh))),
                          subtitle: Transform.translate(
                              offset: Offset(-16, 10),
                              child: Text(
                                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                style: TextStyle(color: Colors.black),
                              ))),
                      SizedBox(
                        height: 20.kh,
                      ),
                      Obx(() => Get.find<GlobalData>().isloginStatusGlobal ==
                          false
                          ? Container(
                        child: ButtonDesignDeactive(
                            name: "Login", onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        }),
                      )
                          : Container(
                        child:
                        ButtonDesign(name: "Book", onPressed: () {
                          Get.toNamed(Routes.RIDE_BOOKED);
                        }),
                      )),
                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
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
}
