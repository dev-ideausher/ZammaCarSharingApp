import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zammacarsharing/app/modules/models/categories_model.dart';
import 'package:zammacarsharing/app/modules/models/get_cars_model.dart';
import 'package:zammacarsharing/app/services/checkLocationPermission.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:zammacarsharing/app/services/tokenCreatorAndValidator.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var currentSliderValue = 20.0.obs;
  Rx<bool> light = false.obs;
  Rx<bool> cars = false.obs;
  Rx<bool> carDetails = false.obs;
  Rx<bool> carBooking = false.obs;
  Rx<bool> zone = false.obs;
  RxInt tapAttention = 101.obs;
  Rx<CategoriesModels> categoriesModels = CategoriesModels().obs;
  Rx<GetCars> carsModel = GetCars().obs;
  RxDouble lat = 45.521563.obs;
  RxString model="".obs;
  RxString seatCapcity="".obs;

  final Completer<GoogleMapController> mapCompleter = Completer();
  // RxDouble lng=(-122.677433.obs) ;
  final instanceOfGlobalData = Get.find<GlobalData>();
  LatLng center = LatLng(45.521563, -122.677433);
  var carsType = ["All", "Sedan", "Hatchback", "SUVs"].obs;
  BitmapDescriptor sourceMark = BitmapDescriptor.defaultMarker;
RxSet<Marker> listOfMarker=<Marker>{}.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    listOfMarker.value.add( Marker(
      markerId: const MarkerId("source"),
      position: center,
      icon: sourceMark,
    ),);
    getCurrentPosition();

    final User? user = await firebaseAuth.currentUser;
    if (user != null)
      await Get.find<TokenCreateGenrate>().validateCreatetoken(user);

    instanceOfGlobalData.isloginStatusGlobal.value =
        Get.find<GetStorageService>().getisLoggedIn;
    getCategories();
    getCars();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCategories() async {
    final response = await APIManager.getCateories();
    categoriesModels.value =
        CategoriesModels.fromJson(jsonDecode(response.toString()));
  }

  getCars() async {
    final response = await APIManager.getCars();
    carsModel.value = GetCars.fromJson(jsonDecode(response.toString()));
  }

  getSelectCategoyCars(String cat) async {
    try {
      instanceOfGlobalData.loader.value = true;
      final response = await APIManager.getCarsByCategory(cat: cat);
      carsModel.value = GetCars.fromJson(jsonDecode(response.toString()));
      instanceOfGlobalData.loader.value = false;
    } catch (e) {
      instanceOfGlobalData.loader.value = false;
      print("Eroor while fetching car by category");
    }
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      //  getAddressFromLatLng(position);
      listOfMarker.clear();

      center = LatLng(position.latitude, position.longitude);
      listOfMarker.value.add( Marker(
        markerId: const MarkerId("source"),
        position: center,
        icon: sourceMark,
      ),);
      listOfMarker.refresh();
      GoogleMapController googleMapController = await mapCompleter.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: center,
          ),
        ),
      );

      print(
          "position lat  : ${position.latitude}, long : ${position.longitude}");
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
