import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zammacarsharing/app/modules/home/controllers/home_controller.dart';
import 'package:zammacarsharing/app/modules/models/parkin_cordinates.dart';
import 'package:zammacarsharing/app/services/checkLocationPermission.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'dart:ui' as ui;

import 'package:zammacarsharing/app/services/storage.dart';
class ParkingController extends GetxController {
  //TODO: Implement ZoneController

  List<List<LatLng>> polygonPoint=[];
  Rx<ParkingCordinates> getParkingCoordinatesModel = ParkingCordinates().obs;
  LatLng center = LatLng(28.640775788001594, 77.02791571025358);
  RxList<Marker> list=[Marker(markerId: MarkerId('1'),)].obs;
  RxSet<Marker> listOfMarker = <Marker>{}.obs;
  RxSet<Polygon> polygon = Set<Polygon>().obs;
  final Completer<GoogleMapController> mapCompleter = Completer();
  HomeController homeController=Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    getAllParkingZone();


    getCurrentPosition();
    getReadyMarker();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getCurrentPosition() async {

    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      //mapLoader.value=false;
      return;
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    center = LatLng(position.latitude, position.longitude);
    // mapLoader.value=false;
    // isMapLoaded.value=true;
    GoogleMapController googleMapController = await mapCompleter.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 18.0,
          target: center,
        ),
      ),
    );


    print(
        "position lat  : ${position.latitude}, long : ${position.longitude}");
  }

  Future<void> getReadyMarker() async {
    list.clear();
    listOfMarker.clear();
    final Uint8List customMarker= await getBytesFromAsset(
        path:"assets/images/markerCar.png", //paste the custom image path
        width: 150 // size of custom image as marker
    );
    for(int i=0;i<homeController.carsModel.value.cars!.length;i++){
      list.value.add(Marker(
          icon: BitmapDescriptor.fromBytes(customMarker),
          markerId: MarkerId("${i}"),
          position: LatLng((homeController.carsModel.value.cars?[i]?.position?.coordinates?[1])!.toDouble(),(homeController.carsModel.value.cars?[i]?.position?.coordinates?[0])!.toDouble()),
          onTap: () {
            homeController.model.value =
            "${homeController.carsModel.value.cars?[i]?.brand} ${homeController.carsModel.value.cars?[i]?.model}";
            homeController.carImage.value = (homeController.carsModel
                .value
                .cars?[i]
                ?.images?[0])
                .toString();
            homeController.seatCapcity.value = (homeController.carsModel
                .value
                .cars?[i]
                ?.seatCapacity)
                .toString();
            homeController.milage.value=(homeController.carsModel
                .value
                .cars?[i]?.mileage)
                .toString();
            homeController.carId.value = (homeController.carsModel.value.cars?[i]?.Id)
                .toString();
            homeController.qnr.value = (homeController.carsModel.value.cars?[i]?.qnr)
                .toString();
            homeController.cars.value = false;
            homeController.carDetails.value = true;
            Get.find<GetStorageService>().setQNR = (homeController.carsModel.value.cars?[i]?.qnr).toString();
            homeController.instanceOfGlobalData.QNR.value =
            "${(homeController.carsModel.value.cars?[i]?.qnr).toString()}";
            homeController.qnr.value = (homeController.carsModel.value.cars?[i]?.qnr).toString();
            Get.back();

          }
      ),);
    }
    listOfMarker.value.addAll(list.value);
    listOfMarker.refresh();
  }

  Future<Uint8List> getBytesFromAsset({required String path,required int width})async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))!
        .buffer.asUint8List();
  }

  mapanimate() async {
    GoogleMapController googleMapController = await mapCompleter.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 18.0,
          target: center,
        ),
      ),
    );
  }

  getAllParkingZone() async {
    try {

      final response =
      await APIManager.getParkingCoordinates();
      getParkingCoordinatesModel.value = ParkingCordinates.fromJson(jsonDecode(response.toString()));
      List<ParkingCordinatesData?> temp =  (getParkingCoordinatesModel.value.data)!;
      print("temp : ${temp}");
      for(ParkingCordinatesData? polygon in temp){
        List<LatLng> child=[];
        for(var element in polygon!.polygons!.coordinates![0]![0]!){
          child.add(LatLng(element!, element));

        }
        polygonPoint.add(child);
      }
      /*for(int i=0;i<polygonPoint.length;i++){
      polygon.value.add(Polygon(
        // given polygonId
        polygonId: PolygonId("${i+1}"),
        // initialize the list of points to display polygon
        points: polygonPoint[i],
        // given color to polygon
        fillColor: Colors.green.withOpacity(0.3),
        // given border color to polygon
        strokeColor: Colors.green,
        geodesic: true,
        // given width of border
        strokeWidth: 4,
      ));
    }*/
      int polyId=1;
      polygon.value.addAll(polygonPoint.map((e) => Polygon(
        // given polygonId
        polygonId: PolygonId('${polyId++}'),
        // initialize the list of points to display polygon
        points: e,
        // given color to polygon
        fillColor: Colors.green.withOpacity(0.3),
        // given border color to polygon
        strokeColor: Colors.blue,
        geodesic: true,
        // given width of border
        strokeWidth: 4,
      )).toList());
      polygon.refresh();
      print("coordinates : ${getParkingCoordinatesModel.value.data?[0]?.polygons?.coordinates?[0]?[0]?[0]}");

      mapanimate();

      /*   getParkingCoordinatesModel.value.data?[0]?.polygons?.coordinates?[0]?[0]?.forEach((element) {
        print("coordinates : ${element}");
        points5=element as List<LatLng>?;
      });*/

    } catch (e) {

      throw "Error while fetching parking coordinates";
    }
  }
}
