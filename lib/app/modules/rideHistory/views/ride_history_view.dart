import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/storage.dart';

import '../controllers/ride_history_controller.dart';

class RideHistoryView extends GetView<RideHistoryController> {
  const RideHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: ()async{
controller.collectRideHistory();
    },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Ride History',
            style: GoogleFonts.urbanist(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body:
        Obx(()=>controller.loader.value==true?Center(
          child: SizedBox(
            width: 200.kh,
            height: 100.kh,
            child: Lottie.asset('assets/json/car_loader.json'),
          ),
        ):controller.rideHistory.value.results!>0?
           Container(
              child: ListView.builder(
                  itemCount: controller.rideHistory.value.results,
                  itemBuilder: (context, index) {
                    return InkWell(onTap: (){
                      if(controller.rideHistory.value.data?[index]?.status=="inprogress") {
                        Get.toNamed(Routes.BOOKING, arguments: [
                          (controller.rideHistory.value.data?[index]?.Id),
                          ("${controller.rideHistory.value.data?[index]?.car?.brand} ${controller.rideHistory.value.data?[index]?.car?.model}"),
                          (controller.rideHistory.value.data?[index]?.car
                              ?.seatCapacity),true
                        ]);
                        Get.find<GetStorageService>().setQNR=(controller.rideHistory.value.data?[0]?.qnr).toString();
                      }
                      else if(controller.rideHistory.value.data?[index]?.status=="ongoing") {
                        Get.toNamed(Routes.BOOKING, arguments: [
                          (controller.rideHistory.value.data?[index]?.Id),
                          ("${controller.rideHistory.value.data?[index]?.car?.brand} ${controller.rideHistory.value.data?[index]?.car?.model}"),
                          (controller.rideHistory.value.data?[index]?.car
                              ?.seatCapacity),false
                        ]);
                      }
                      else {
                        Get.toNamed(Routes.COMPLETED_RIDE_DETAILS,arguments: [
                          (controller.rideHistory.value.data?[index]?.Id),
                          (controller.rideHistory.value.data?[index]?.car?.model),(controller.rideHistory.value.data?[index]?.createdAt?.substring(0,10)),index] );
                      }
                    },
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
                        padding: EdgeInsets.fromLTRB(16.kh,16.kh,16.kh,0

                        ),
                        height: 140.kh,
                        width: double.infinity,
                        child: Column(
                            children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking ID #${controller.rideHistory.value.data?[index]?.Id}",
                                style: GoogleFonts.urbanist(color: ColorUtil.ZammaGrey),

                              ),
                              Text(
                                "${controller.rideHistory.value.data?[index]?.createdAt?.substring(0,10)}",
                                style:GoogleFonts.urbanist(color: ColorUtil.ZammaGrey),

                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.kh,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.rideHistory.value.data?[index]?.car?.brand} ${controller.rideHistory.value.data?[index]?.car?.model}",
                                style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 20.kh),

                              ),
                              Transform.translate(
                                offset: Offset(20, 0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 16.kh, 0),
                                  width: 90.kw,
                                  height: 30.kh,
                                  decoration: BoxDecoration(
                                    color: controller.rideHistory.value.data?[index]?.status =="completed" ? Color(0xff031569):controller.rideHistory.value.data?[index]?.status=="inprogress"?Color(0xff008000):controller.rideHistory.value.data?[index]?.status=="cancelled"?Color(0xffFF0000):Color(0xff008000),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "${controller.rideHistory.value.data?[index]?.status}",
                                        style: GoogleFonts.urbanist(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          /*ListTile(
                              leading: Transform.translate(offset: Offset(-16,0),
                                child: Text(
                                  "\$--/Hr",
                                  style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 20.kh,color: ColorUtil.kPrimary),

                                ),
                              ),
                             *//* title: Transform.translate(
                                  offset: Offset(-35, -3),
                                  child: Text(
                                    "${controller.rideHistory.value.data?[index]?.user?.totalTravelKm}",
                                    style: GoogleFonts.urbanist(
                                      color: ColorUtil.ZammaGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.kh,
                                    ),
                                  )),*//*
                              *//*trailing: Transform.translate(
                                offset: Offset(20, 0),
                                child: Container(
                                  width: 90.kw,
                                  height: 30.kh,
                                  decoration: BoxDecoration(
                                    color: controller.rideHistory.value.data?[index]?.status=="completed"?Color(0xff031569):controller.rideHistory.value.data?[index]?.status=="in-progress"?Color(0xff008000):controller.rideHistory.value.data?[index]?.status=="cancelled"?Color(0xffFF0000):Color(0xffFFA500),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${controller.rideHistory.value.data?[index]?.status}",
                                    style: GoogleFonts.urbanist(color: Colors.white),
                                  )),
                                ),
                              ),*//*
                              tileColor: Colors.white),*/
                          /*Transform.translate(offset: Offset(0,-20),
                            child: ListTile(
                                leading: Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: SvgPicture.asset(
                                      "assets/icons/clock.svg",

                                    )),
                                title: Transform.translate(
                                    offset: Offset(-35, -3),
                                    child: Text(
                                      "1hr 23min",
                                      style: GoogleFonts.urbanist(
                                        color: ColorUtil.ZammaGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.kh,
                                      ),
                                    )),

                               ),
                          ),
                          Transform.translate(offset: Offset(0,-40),
                            child: ListTile(
                              leading: Transform.translate(
                                  offset: Offset(-10, 0),
                                  child: SvgPicture.asset(
                                    "assets/icons/spend.svg",

                                  )),
                              title: Transform.translate(
                                  offset: Offset(-35, -3),
                                  child: Text(
                                    "\$256.6 Spent",
                                    style: GoogleFonts.urbanist(
                                      color: Color(0xff008000),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.kh,
                                    ),
                                  )),

                            ),
                          ),*/
                        ]),
                      ),
                    );
                  })):Center(child: Text("no_ride_history",style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 20.kh,color: ColorUtil.kPrimary),)),
        ),
      ),
    );
  }
}
