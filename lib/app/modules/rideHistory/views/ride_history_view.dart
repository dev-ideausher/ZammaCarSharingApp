import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/ride_history_controller.dart';

class RideHistoryView extends GetView<RideHistoryController> {
  const RideHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Ride History',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("No Ride History"),)
      /*Container(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
                  padding: EdgeInsets.all(
                    16,
                  ),
                  height: 280.kh,
                  width: double.infinity,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking ID #23456",
                          style: TextStyle(color: ColorUtil.ZammaGrey),
                        ),
                        Text(
                          "12 May 2022",
                          style: TextStyle(color: ColorUtil.ZammaGrey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.kh,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tesla Model Y (White)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.kh),
                        ),
                        Text(
                          "\$30/Hr",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.kh),
                        ),
                      ],
                    ),
                    ListTile(
                        leading: Transform.translate(
                            offset: Offset(-10, 0),
                            child: SvgPicture.asset(
                              "assets/icons/locationm.svg",
                              color: ColorUtil.ZammaGrey,
                            )),
                        title: Transform.translate(
                            offset: Offset(-35, -3),
                            child: Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: ColorUtil.ZammaGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.kh,
                              ),
                            )),
                        trailing: Transform.translate(
                          offset: Offset(20, 0),
                          child: Container(
                            width: 90.kw,
                            height: 30.kh,
                            decoration: BoxDecoration(
                              color: Color(0xffFFA500),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Booked",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        tileColor: Colors.white),
                    Transform.translate(offset: Offset(0,-20),
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
                                style: TextStyle(
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
                              style: TextStyle(
                                color: Color(0xff008000),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.kh,
                              ),
                            )),

                      ),
                    ),
                  ]),
                );
              })),*/
    );
  }
}
