import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zammacarsharing/app/modules/models/categories_model.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/get_cars_model.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/imspection_model.dart';
import 'package:zammacarsharing/app/services/checkLocationPermission.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:zammacarsharing/app/services/tokenCreatorAndValidator.dart';
import 'package:http/http.dart' as http;

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
  Rx<bool> enrideInspection= false.obs;
  Rx<bool> zone = false.obs;
  RxInt tapAttention = 0.obs;
  Rx<CategoriesModels> categoriesModels = CategoriesModels().obs;
  Rx<GetCars> carsModel = GetCars().obs;
  final imageUpload = ImageUpload().obs;

  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  Rx<InspectionModel> inspectionModel = InspectionModel().obs;
  RxDouble lat = 45.521563.obs;
  RxString model = "".obs;
  RxString seatCapcity = "".obs;
  RxString carId = "".obs;
  Rx<bool>freeTimer = false.obs;
  var frontHood = File("").obs;
  var leftSide = File("").obs;
  var backSide = File("").obs;
  var rightSide = File("").obs;
  final frontImageStatus = 0.obs;
  final backImageStatus = 0.obs;
  final leftImageStatus = 0.obs;
  final rightImageStatus = 0.obs;
  final Completer<GoogleMapController> mapCompleter = Completer();

  // RxDouble lng=(-122.677433.obs) ;
  final instanceOfGlobalData = Get.find<GlobalData>();
  LatLng center = LatLng(45.521563, -122.677433);
  var carsType = ["All", "Sedan", "Hatchback", "SUVs"].obs;
  BitmapDescriptor sourceMark = BitmapDescriptor.defaultMarker;
  RxSet<Marker> listOfMarker = <Marker>{}.obs;
  RxList carsImage = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    listOfMarker.value.add(Marker(
      markerId: const MarkerId("source"),
      position: center,
      icon: sourceMark,
    ),);
    getCurrentPosition();

    final User? user = await firebaseAuth.currentUser;
    if (user != null)
      await Get.find<TokenCreateGenrate>().validateCreatetoken(user);

    instanceOfGlobalData.isloginStatusGlobal.value =
        Get
            .find<GetStorageService>()
            .getisLoggedIn;
    getCarsAndCategories();
  }

  getCarsAndCategories() {
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

  resetValue(){
    frontHood.value = File("");
    leftSide.value = File("");
    backSide.value = File("");
    rightSide.value = File("");
    frontImageStatus.value = 0;
    backImageStatus.value = 0;
    leftImageStatus.value = 0;
    rightImageStatus.value = 0;
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
      listOfMarker.value.add(Marker(
        markerId: const MarkerId("source"),
        position: center,
        icon: sourceMark,
      ),);
      listOfMarker.refresh();
      GoogleMapController googleMapController = await mapCompleter.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: -25.0,
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

  late Timer timer;
  var start = 60.obs;

  var minute = 14.obs;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          minute.value--;
          // timer.cancel();
          start.value = 60;
          freeTimer.value = false;
        } else {
          freeTimer.value = true;
          start--;
        }
      },
    );
  }

  late Timer ridetimer;
  var ridestart = 0.obs;

  var rideminute = 0.obs;
  var ridehour = 0.obs;

  void rideTimer() {
    const oneSec = const Duration(seconds: 1);
    ridetimer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (ridestart == 60) {
          rideminute.value++;
          // timer.cancel();
          ridestart.value = 0;
          freeTimer.value = false;
        } else if (rideminute == 60) {
          ridehour.value++;
          // timer.cancel();
          rideminute.value = 0;
          freeTimer.value = false;
        }
        else {
          freeTimer.value = true;
          ridestart++;
        }
      },
    );
  }

  Future<dynamic> uploadImage(String path) async {
    String token = Get
        .find<GetStorageService>()
        .jwToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          Endpoints.imapgeUpload),);
    request.fields.addAll({'type': 'userProfile'});
    var headers = {'accept': 'application/json', 'token': token};
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var value = await response.stream.bytesToString();
      print("statusssssss ::  ${value}");
      // var value=jsonDecode(response.);
      return jsonDecode(value);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> pickFromCamera(String selectedSideFoto) async {
    final ImagePicker picker = ImagePicker();
    print("pickedImage path before ${frontHood.value.path}");
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (selectedSideFoto == "front") {
        frontImageStatus.value = 1;
        frontHood.value = File(image!.path);
      }
      else if (selectedSideFoto == "leftside") {
        leftImageStatus.value = 1;
        leftSide.value = File(image!.path);
      }
      else if (selectedSideFoto == "rightside") {
        rightImageStatus.value = 1;
        rightSide.value = File(image!.path);
      }
      else {
        backImageStatus.value = 1;
        backSide.value = File(image!.path);
      }


      print("pickedImage path after ${frontHood.value.path}");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> uploadInspectionImage() async {
    if (frontImageStatus.value == 0 || leftImageStatus.value == 0 ||
        rightImageStatus.value == 0 || backImageStatus == 0) {
      showMySnackbar(title: "Error", msg: "All image mandatory");
      return 0;
    }
    else {
      try {
        instanceOfGlobalData.loader.value = true;
        for (int i = 0; i < 4; i++) {
          if (i == 0) {
            var response = await uploadImage(frontHood.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          }
          else if (i == 1) {
            var response = await uploadImage(leftSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          }
          else if (i == 2) {
            var response = await uploadImage(rightSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          }

          else if (i == 3) {
            var response = await uploadImage(backSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          }
        }
        var body = {
          "type": "beforeRide",
          "carImagesBeforeRide": [
            {
              "respectiveSide": "Front Hood",
              "image": carsImage.value[0]
            },
            {
              "respectiveSide": "Left Side",
              "image": carsImage.value[1]
            },
            {
              "respectiveSide": "Right Side",
              "image": carsImage.value[2]
            },

            {
              "respectiveSide": "Back Side",
              "image": carsImage.value[3]
            }

          ]
        };
        final response = await APIManager.postInspectionImageUrl(body: body,
            bookingId: (createBookinModel.value.booking?.Id).toString());
        inspectionModel.value = InspectionModel.fromJson(jsonDecode(response.toString()));
        if(inspectionModel.value.status==true){
          showMySnackbar(title: "Msg", msg: "Inspection Completed have a safe ride");

          resetValue();

        }
        instanceOfGlobalData.loader.value = false;
        return 1;
      } catch (e) {
        instanceOfGlobalData.loader.value = false;
        print("while uploding car sides image");
        return 0;
      }


    }
  }

  Future<int> createBooking(String CarId,) async {
    instanceOfGlobalData.loader.value = true;
    var body = {
      "carId": CarId,
      "pickupLocation": {
        "type": "Point",
        "coordinates": [83.37816239552401, 26.76938605366884],
        "address": "Gorakhpur"
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

  Future<int> cancelBooking() async {
    instanceOfGlobalData.loader.value = true;
    var body = {
      "cancelReason": "Not available"
    };
    try {
      final response = await APIManager.cancelBooking(body: body,
          bookingId: (createBookinModel.value.booking?.Id).toString());
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));
      print("response.data : ${response.toString()}");

      instanceOfGlobalData.loader.value = false;
      carBooking.value = false;
      carInspection.value = false;
      showMySnackbar(title: "Msg", msg: "Ride canceled");
      return 1;
    } catch (e) {
      showMySnackbar(title: "Error", msg: "Error while cancel booking");
      instanceOfGlobalData.loader.value = false;
      return 0;
    }
  }


}
