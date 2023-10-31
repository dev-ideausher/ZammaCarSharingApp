import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/ride_booked_controller.dart';

class RideBookedView extends GetView<RideBookedController> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(backgroundColor: Colors.white,elevation: 0,
        title: Text('Booking Status',style: GoogleFonts.urbanist(color: Colors.black),),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Ride Booked',
          style: GoogleFonts.urbanist(fontSize: 20),
        ),
      ),

    );
  }
}
