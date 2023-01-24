import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showMySnackbar(title: "Message",msg: "Location services are disabled. Please enable the services");


    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showMySnackbar(title: "Message",msg: "Location permissions are denied");


      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    showMySnackbar(title: "Message",msg: "Location permissions are permanently denied, we cannot request permissions.");

   return false;
  }
  return true;
}