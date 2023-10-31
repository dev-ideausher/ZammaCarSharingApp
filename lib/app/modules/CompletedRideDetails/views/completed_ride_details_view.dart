import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/completed_ride_details_controller.dart';

class CompletedRideDetailsView extends GetView<CompletedRideDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title:  Text(
            'Completed ride',
            style: GoogleFonts.urbanist( color: Colors.black),

          ),
          centerTitle: true,
        ),
        body: Obx(()=>
           LoaderOverlay(
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
                      padding: const EdgeInsets.fromLTRB(8.0,8,0,8),
                      child:
                      SizedBox(child: Lottie.asset('assets/json/car_loader.json')),
                    ),
                    SizedBox(
                      width: 10.kw,
                    ),

                        Text(
                          "Loading ride data...",
                          style:  GoogleFonts.urbanist(fontSize: 16),
                        ),

                  ]),
                )),
            child: controller.loader.value==true?Center(child: Center(
              child: SizedBox(
                width: 200.kh,
                height: 100.kh,
                child: Lottie.asset('assets/json/car_loader.json'),
              ),
            ),):SingleChildScrollView(
              child: Obx(()=>
               Container(
                  height: 1100.kh,
                  child: Column(children: [
                    Container(
                      height: 300.kh,
                      child: GoogleMap(
                        onMapCreated: (mapController) {
                            controller.mapCompleter.complete(mapController);
                        },
                        polylines: controller.polyline.value,
                        //  markers: controller.listOfMarker,
                        initialCameraPosition: CameraPosition(
                          target: controller.center,
                          zoom: 11.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0.kh),
                          child: Text(
                            "Booking ID #${controller.bookingId}",
                            style:GoogleFonts.urbanist( color: ColorUtil.ZammaGrey),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0.kh),
                          child: Text(
                            "${(controller.rideHistory.value.data?[controller.index]?.createdAt?.substring(0,10))}",
                            style: GoogleFonts.urbanist( color: ColorUtil.ZammaGrey),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.kh,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.kh, 0, 0, 0),
                          child: Text(
                            "${(controller.rideHistory.value.data?[controller.index]?.car?.model)}",
                            style: GoogleFonts.urbanist( fontWeight: FontWeight.bold, fontSize: 20.kh),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 16.kh, 0),
                          child: Text(
                            "\$${(controller.totalAmount.value).toStringAsFixed(3)}",
                            style:GoogleFonts.urbanist(  fontWeight: FontWeight.bold,
                                fontSize: 20.kh,
                                color: ColorUtil.kPrimary),

                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                            height: 200.kh,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20.kh,
                                  width: 20.kh,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 5, color: ColorUtil.kPrimary),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                ),
                                Container(
                                  height: 100.kh,
                                  width: 5,
                                  color: ColorUtil.kPrimary,
                                ),
                                Container(
                                    height: 20.kh,
                                    width: 20.kh,
                                    decoration: BoxDecoration(
                                        color: ColorUtil.kPrimary,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      width: 2,
                                      height: 2,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),

                          Container(
                            width: 240.kw,
                            height: 200.kh,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.kh, 0, 0, 0),
                                  child: Text(
                                    "Pickup Location",
                                    style: GoogleFonts.urbanist( fontWeight: FontWeight.bold, fontSize: 20.kh),

                                  ),
                                ),
                                SizedBox(
                                  height: 5.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.kh, 0, 0, 0),
                                  child: Text(
                                    "${controller.pickupAddress.value}\n",
                                    style:
                                    GoogleFonts.urbanist(color: ColorUtil.ZammaGrey),
                                  ),
                                ),
                                SizedBox(
                                  height: 70.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.kh, 0, 0, 0),
                                  child: Text(
                                    "Drop Location",
                                    style: GoogleFonts.urbanist(  fontWeight: FontWeight.bold, fontSize: 20.kh),

                                  ),
                                ),
                                SizedBox(
                                  height: 5.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.kh, 0, 0, 0),
                                  child: Text(
                                    "${controller.dropAddress.value}",
                                    style:GoogleFonts.urbanist( color: ColorUtil.ZammaGrey),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80.kw,
                            height: 200.kh,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 16.kh, 0),
                                  child: Text(
                                    "${controller.pickupTimeConverted.value}",
                                    style: GoogleFonts.urbanist( fontWeight: FontWeight.bold,
                                        fontSize: 14.kh,
                                        color: ColorUtil.kPrimary),

                                  ),
                                ),
                                SizedBox(
                                  height: 120.kh,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 16.kh, 0),
                                  child: Text(
                                    "${controller.dropTimeConverted.value}",
                                    style: GoogleFonts.urbanist(fontWeight: FontWeight.bold,
                                        fontSize: 14.kh,
                                        color: ColorUtil.kPrimary),

                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Mileage",
                              style:  GoogleFonts.urbanist(color: ColorUtil.ZammaGrey, fontSize: 16.kh),

                            ),
                            SizedBox(
                              height: 5.kh,
                            ),
                            Text("${(controller.rideHistory.value.data?[controller.index]?.car?.mileage)}",
                                style: GoogleFonts.urbanist(fontWeight: FontWeight.bold,
                                    fontSize: 18.kh,
                                    color: ColorUtil.kPrimary),
                          )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Duration",
                              style:GoogleFonts.urbanist( color: ColorUtil.ZammaGrey, fontSize: 16.kh),

                            ),
                            SizedBox(
                              height: 5.kh,
                            ),
                            Text("${controller.durationOfRide.value} min",
                                style: GoogleFonts.urbanist( fontWeight: FontWeight.bold,
                                    fontSize: 18.kh,
                                    color: ColorUtil.kPrimary),
                            )
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    Container(

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: 16.kh,
                            ),
                            Padding(
                              padding:  EdgeInsets.fromLTRB(16.kh,0,0,0),
                              child: Text("Payment Description" ,style: GoogleFonts.urbanist( fontWeight: FontWeight.w700, fontSize: 20.kh),
                              ),
                            ),
                            SizedBox(
                              height: 16.kh,
                            ),
                            /*Padding(
                              padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total fare",
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w600, fontSize: 16.kh),
                                  ),
                                  Obx(()=>
                                     Text(
                                      "\$${controller.totalAmount.value}",
                                      style: GoogleFonts.urbanist(
                                          color: Color(0xffFF0000),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.kh),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.kh,
                            ),*/
                            Padding(
                              padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pre booking amount",
                                    style: GoogleFonts.urbanist( fontWeight: FontWeight.w600, fontSize: 16.kh),
                                  ),
                                  Obx(()=>
                                   Text(
                                      "\$${controller.firstPayment.value}",
                                      style: GoogleFonts.urbanist( color: Color(0xff008000),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.kh),

                                    ),
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
                                    "Trip amount",
                                    style: GoogleFonts.urbanist( fontWeight: FontWeight.w600, fontSize: 16.kh)

                                  ),
                                  Obx(()=>
                                    Text(
                                      "\$${controller.secondPayment.value}",
                                      style: GoogleFonts.urbanist( color: Color(0xff008000),
                                        fontWeight: FontWeight.w600,),
                                    ),
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
                                    "Total amount",
                                    style:  GoogleFonts.urbanist(fontWeight: FontWeight.w700,
                                      fontSize: 16.kh,),

                                  ),
                                  Obx(()=>
                                     Text(
                                      "\$${(controller.totalAmount.value).toStringAsFixed(3)}",
                                      style: GoogleFonts.urbanist(color: Color(0xff008000),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.kh),

                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(
                            //   height: 10.kh,
                            // ),
                          ]),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),

                    Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(16.kh,0,0,0),
                        child: Text("Payment card used" ,style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 20.kh),),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Obx(()=>
                         ListTile(leading: Icon(Icons.credit_card_outlined),title: Text("XXXX XXXX XXXX-${(controller.carNumber).substring(15, 19)}",style:GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 16.kh)
                         ),trailing: Switch(value: true, onChanged: (bool value) {  },),),
                      )
                    ]),)
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
