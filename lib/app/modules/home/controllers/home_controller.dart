import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/booking_ongoing_model.dart';
import 'package:zammacarsharing/app/modules/models/car_pricing_model.dart';
import 'package:zammacarsharing/app/modules/models/categories_model.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/get_cars_model.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/imspection_model.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/FirebaseMessagingUtils.dart';
import 'package:zammacarsharing/app/services/checkLocationPermission.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:zammacarsharing/app/services/tokenCreatorAndValidator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';
class HomeController extends GetxController {
  //TODO: Implement HomeController

  var currentSliderValue = 20.0.obs;
  Rx<bool> light = false.obs;
  Rx<bool> cars = false.obs;
  Rx<bool> carDetails = false.obs;
  Rx<bool> carBooking = false.obs;
  Rx<bool> carInspection = false.obs;
  Rx<bool> rideStart = false.obs;
  Rx<bool> bookingPriceDetails = false.obs;
  Rx<bool> customePrice = false.obs;
  Rx<bool> enrideInspection = false.obs;
  Rx<bool> zone = false.obs;
  RxInt tapAttention = 0.obs;
  RxInt timeTapAttention = 0.obs;
  RxInt distanceTapAttention = 0.obs;
  RxInt planTapAttention = 100.obs;
   RxDouble finalAmount = 0.0.obs;
  Rx<CategoriesModels> categoriesModels = CategoriesModels().obs;
  Rx<GetCars> carsModel = GetCars().obs;
  final imageUpload = ImageUpload().obs;
  Rx<logedInDetails> logindetails = logedInDetails().obs;
  Rx<BookingOngoing> bookingOngoing = BookingOngoing().obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
  Rx<CarPriceById> carPriceById = CarPriceById().obs;

  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  Rx<InspectionModel> inspectionModel = InspectionModel().obs;
  RxDouble lat = 45.521563.obs;
  RxString model = "".obs;
  RxString carImage = "".obs;
  RxString seatCapcity = "".obs;
  RxString milage = "0".obs;
  RxString fuelType = "".obs;
  RxString fuelLavel = "".obs;
  RxString carId = "".obs;
  RxString qnr = "".obs;
  RxDouble selectedCarLatitude = 0.0.obs;
  RxDouble selectedCarLongitude= 0.0.obs;
  RxString pickupAddress= "".obs;
  Rx<bool> freeTimer = false.obs;
  var frontHood = File("").obs;
  var leftSide = File("").obs;
  var backSide = File("").obs;
  var rightSide = File("").obs;
  final frontImageStatus = 0.obs;
  final backImageStatus = 0.obs;
  final leftImageStatus = 0.obs;
  final rightImageStatus = 0.obs;
  final extraMinuteCharges =0.0.obs;
  final extraMilesCharges =0.0.obs;
  final Completer<GoogleMapController> mapCompleter = Completer();

  // RxDouble lng=(-122.677433.obs) ;
  final instanceOfGlobalData = Get.find<GlobalData>();
  LatLng center = LatLng(45.521563, -122.677433);
  var carsType = ["All", "Sedan", "Hatchback", "SUVs"].obs;
  BitmapDescriptor sourceMark = BitmapDescriptor.defaultMarker;
  RxSet<Marker> listOfMarker = <Marker>{}.obs;
  RxList carsImage = [].obs;
   RxList<Marker> list=[Marker(markerId: MarkerId('1'),)].obs;
  RxSet<Marker> marker = <Marker>{}.obs;

  final Completer<GoogleMapController> controllerr = Completer();
RxBool mapLoader = true.obs;
RxBool isMapLoaded = false.obs;
  RxInt timeLength = 0.obs;
  RxInt milesLength = 0.obs;
  // List<Marker> marker = [];

  // on below line we are specifying our camera position


  @override
  Future<void> onInit() async {
    super.onInit();

    final User? user = await firebaseAuth.currentUser;
    if (user != null) {

      await Get.find<TokenCreateGenrate>().validateCreatetoken(user);
      fcmSubscribe();
    }

    instanceOfGlobalData.isloginStatusGlobal.value =
        Get.find<GetStorageService>().getisLoggedIn;
  await  getCarsAndCategories();
    await  getInProcessOrOngoingRide();
  }

  fcmSubscribe(){
    if(Get.find<GetStorageService>().getCustomUserId.isNotEmpty)
      FirebaseMessagingUtils.firebaseMessagingUtils
          .subFcm(Get
          .find<GetStorageService>()
          .getCustomUserId);


   // print("fcm subscribe in nav bar ${Get.find<GetStorageService>().getUserId}");
  }

getInProcessOrOngoingRide() async {
  final User? user = await firebaseAuth.currentUser;
  if (user != null) {
    getOnGoingHistory();
    getInProcessHistory();
  }
}
  Future<void> getCarsAndCategories() async {
    await  getCurrentPosition();
   await getCars();
   await getCategories();
  await getReadyMarker();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  resetValue() {
    frontHood.value = File("");
    leftSide.value = File("");
    backSide.value = File("");
    rightSide.value = File("");
    frontImageStatus.value = 0;
    backImageStatus.value = 0;
    leftImageStatus.value = 0;
    rightImageStatus.value = 0;
  }

  Future<void> getCategories() async {
    final response = await APIManager.getCateories();
    categoriesModels.value =
        CategoriesModels.fromJson(jsonDecode(response.toString()));

  }

  Future<void> getCars() async {
    final response = await APIManager.getCars();
    carsModel.value = GetCars.fromJson(jsonDecode(response.toString()));

print("");


    /* list.value=  [
      // List of Markers Added on Google Map
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(20.42796133580664, 80.885749655962),
          infoWindow: InfoWindow(
            title: 'My Position',
          )
      ),

      Marker(
          markerId: MarkerId('2'),
          position: LatLng(25.42796133580664, 80.885749655962),
          infoWindow: InfoWindow(
            title: 'Location 1',
          )
      ),

      Marker(
          markerId: MarkerId('3'),
          position: LatLng(20.42796133580664, 73.885749655962),
          infoWindow: InfoWindow(
            title: 'Location 2',
          )
      ),
    ];*/
  //  instanceOfGlobalData..timeCalculationOngoing(baseTime: (carsModel.value.cars?[0]?.createdAt).toString());

  }

  Future<void> getReadyMarker() async {
    list.clear();
    listOfMarker.clear();
    final Uint8List customMarker= await getBytesFromAsset(
        path:"assets/images/markerCar.png", //paste the custom image path
        width: 150 // size of custom image as marker
    );
    for(int i=0;i<carsModel.value.cars!.length;i++){
      list.value.add(Marker(
        icon: BitmapDescriptor.fromBytes(customMarker),
        markerId: MarkerId("${i}"),
        position: LatLng((carsModel.value.cars?[i]?.position?.coordinates?[1])!.toDouble(),(carsModel.value.cars?[i]?.position?.coordinates?[0])!.toDouble()),
          onTap: () {
            model.value =
            "${carsModel.value.cars?[i]?.brand} ${carsModel.value.cars?[i]?.model}";
            carImage.value = (carsModel
                .value
                .cars?[i]
                ?.images?[0])
                .toString();
            seatCapcity.value = (carsModel
                .value
                .cars?[i]
                ?.seatCapacity)
                .toString();
            milage.value=(carsModel
                .value
                 .cars?[i]?.mileage)
                .toString();
            carId.value = (carsModel.value.cars?[i]?.Id)
                .toString();
           qnr.value = (carsModel.value.cars?[i]?.qnr)
                .toString();
            cars.value = false;
            carDetails.value = true;
            Get.find<GetStorageService>().setQNR = (carsModel.value.cars?[i]?.qnr).toString();
            instanceOfGlobalData.QNR.value =
            "${(carsModel.value.cars?[i]?.qnr).toString()}";
            qnr.value = (carsModel.value.cars?[i]?.qnr).toString();

          }
      ),);
    }
    listOfMarker.value.addAll(list.value);
    listOfMarker.refresh();
  }

  getSelectCategoyCars(String cat) async {
    try {
      instanceOfGlobalData.loader.value = true;
      if (cat == "all") {
        final response = await APIManager.getCars();
        carsModel.value = GetCars.fromJson(jsonDecode(response.toString()));
      } else {
        final response = await APIManager.getCarsByCategory(cat: cat);
        carsModel.value = GetCars.fromJson(jsonDecode(response.toString()));
      }

      instanceOfGlobalData.loader.value = false;
    } catch (e) {
      instanceOfGlobalData.loader.value = false;
      print("Eroor while fetching car by category");
    }
  }

  Future<void> getCurrentPosition() async {

    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      mapLoader.value=false;
      return;
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    center = LatLng(position.latitude, position.longitude);
    mapLoader.value=false;
    isMapLoaded.value=true;
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

  Future<String> getAddressFromLatLng() async {
    String address="";
    placemarkFromCoordinates(selectedCarLatitude.value,selectedCarLongitude.value)
        .then((List<Placemark> placemarks) {

      Placemark place = placemarks[0];
      print(
          'Human : ${place.street}, ${place.subLocality},${place.administrativeArea}, ${place.postalCode} }');
      /*getGlobalServicesInstance.lat.value = position.latitude.toString();
      getGlobalServicesInstance.lng.value = position.longitude.toString();
      getGlobalServicesInstance.city.value =
          place.administrativeArea.toString();
      getGlobalServicesInstance.zipCode.value = place.postalCode.toString();
      getGlobalServicesInstance.country.value = place.country.toString();
      getFreshRecommendation();
      getFeaturedAds();*/
      pickupAddress.value="${place.street}, ${place.subLocality},${place.administrativeArea}, ${place.postalCode} ";

    }).catchError((e) {
      debugPrint(e);
    });
    return address;
  }


  Future<int> createBooking({required String carId, required String qnr}
  ) async {

    instanceOfGlobalData.loader.value = true;
    var body = {
      "carId": carId,
    "qnr":qnr,
      "pickupLocation": {
        "type": "Point",
        "coordinates": [selectedCarLatitude.value, selectedCarLongitude.value],
        "address": pickupAddress.value
      }
    };
    try {
      final response = await APIManager.createBooking(body: body);
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));
      print("response.data : ${response.toString()}");

      instanceOfGlobalData.loader.value = false;
      return 1;
    } catch (e) {
      showMySnackbar(title: "Error", msg: "Error while create booking");
      instanceOfGlobalData.loader.value = false;
      return 0;
    }
  }


  Future<int> onBoardingStatus() async {
    instanceOfGlobalData.loader.value = true;
    try {
      final response = await APIManager.checkIsUserOnBoard();
      logindetails.value =
          logedInDetails.fromJson(jsonDecode(response.toString()));
      print("response.data : ${response}");
      if (logindetails.value.user?.isApproved == true) {
        if (logindetails.value.user?.isSuspended == false) {
          instanceOfGlobalData.loader.value=false;


          return 1;
        } else {
          instanceOfGlobalData.loader.value=false;
          return 0;
        }
      } else {
        instanceOfGlobalData.loader.value=false;
        return 0;
      }
    } catch (e) {
      instanceOfGlobalData.loader.value = false;
      return 0;
    }
  }

  Future<void> getCarPricing() async {

    try {
      final response = await APIManager.getCarPricingById(carId: carId.value);
    carPriceById.value =
      CarPriceById.fromJson(jsonDecode(response.toString()));
    timeLength.value=(carPriceById.value.carPricing?.pricingRules?.length)!;
    milesLength.value=(carPriceById.value.carPricing?.mileageRates?.length)!;
      extraMinuteCharges.value=double.parse("${carPriceById.value.carPricing?.extraMinuteRate}");
      extraMilesCharges.value=double.parse("${carPriceById.value.carPricing?.extraMileRate}");
      final tPrice=carPriceById.value.carPricing?.pricingRules?[0]?.price;
      final dPrice=carPriceById.value.carPricing?.mileageRates?[0]?.price;
      finalAmount.value=(tPrice!+dPrice!);
    } catch (e) {

      debugPrint("error while fetching car pricing");

    }
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
RxBool statusCheck=false.obs;
  RxBool statusCheckTwo=false.obs;

  Future<int> getInProcessHistory() async {
    try {

      statusCheck.value=true;
        final response = await APIManager.getinProcessRideHistory();
        rideHistory.value =
            RideHistory.fromJson(jsonDecode(response.toString()));
        /*instanceOfGlobalData.waitingLastStampToseconds(
            startTime: DateTime.parse(
                (rideHistory.value.data?[0]?.createdAt).toString()));*/
        Get.toNamed(Routes.BOOKING, arguments: [
          (rideHistory.value.data?[0]?.Id),
          ("${rideHistory.value.data?[0]?.car?.brand} ${rideHistory.value.data?[0]?.car?.model}"),
          (rideHistory.value.data?[0]?.car
              ?.seatCapacity),true
        ]);
      Get.find<GetStorageService>().setQNR=(rideHistory.value.data?[0]?.qnr).toString();
      statusCheck.value=false;
      return 1;
    } catch (e) {
      statusCheck.value=false;
    print("eroor while fetching inProcessRide : $e");
      return 0;
    }
  }

  Future<int> getOnGoingHistory() async {
    try {
      statusCheckTwo.value=true;

        final response = await APIManager.getOnGoingRideHistory();
        rideHistory.value =
            RideHistory.fromJson(jsonDecode(response.toString()));
       /* instanceOfGlobalData.lastStampToseconds(
            startTime: DateTime.parse(
                (rideHistory.value.data?[0]?.pickupTime).toString()));*/
        Get.toNamed(Routes.BOOKING, arguments: [
          (rideHistory.value.data?[0]?.Id),
          ("${rideHistory.value.data?[0]?.car?.brand} ${rideHistory.value.data?[0]?.car?.model}"),
          (rideHistory.value.data?[0]?.car
              ?.seatCapacity),false
        ]);
      Get.find<GetStorageService>().setQNR=(rideHistory.value.data?[0]?.qnr).toString();
      statusCheckTwo.value=false;
      return 1;
    } catch (e) {
      statusCheckTwo.value=false;
      print("eroor while fetching ongoingRide : $e");
      return 0;
    }
  }



  calculateCharges(){

    final tPrice=carPriceById.value.carPricing?.pricingRules?[timeTapAttention.value]?.price;
    final dPrice=carPriceById.value.carPricing?.mileageRates?[distanceTapAttention.value]?.price;

    double timeCharges=0;
    double distanceCharge=0;

  //  final timeCharges=(timeTapAttention.value+1)*10;
    //final distanceCharge=(distanceTapAttention.value*10)*10;
     finalAmount.value=(tPrice!+dPrice!);
  }


}
