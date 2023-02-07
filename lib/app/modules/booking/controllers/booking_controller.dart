import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/imspection_model.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/image_handler.dart';
import 'package:zammacarsharing/app/services/repeated_api_calling.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  //TODO: Implement BookingController

  //variable
  var currentSliderValue = 20.0.obs;
  LatLng center = LatLng(45.521563, -122.677433);
  Rx<bool> light = false.obs;
  var frontHood = File("").obs;
  var leftSide = File("").obs;
  var backSide = File("").obs;
  var rightSide = File("").obs;
  final frontImageStatus = 0.obs;
  final backImageStatus = 0.obs;
  final leftImageStatus = 0.obs;
  final rightImageStatus = 0.obs;
  RxList carsImage = [].obs;
  Rx<bool> carInspection = false.obs;
  Rx<bool> rideStart = false.obs;
  Rx<bool> endrideInspection= false.obs;
  Rx<bool> bookingPriceDetails= false.obs;
  Rx<bool> carBooking = true.obs;

  //response model
  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  Rx<InspectionModel> inspectionModel = InspectionModel().obs;
  Rx<ImageUpload> imageUpload = ImageUpload().obs;


  final instanceOfGlobalData = Get.find<GlobalData>();

  // Data Coming From Home Controller
  final bookingId=Get.arguments[0];
  final model=Get.arguments[1];
  final seatCapcity=Get.arguments[2];



  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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

  late Timer timer;
  var start = 60.obs;
 RxBool checkTimer=false.obs;
  var minute = 14.obs;

  void startTimer() {
    checkTimer.value=true;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          minute.value--;
          // timer.cancel();
          start.value = 60;

        } else {

          start--;
        }
      },
    );
  }

  late Timer ridetimer;
  var ridestart = 0.obs;

  var rideminute = 0.obs;
  var ridehour = 0.obs;
  RxBool checkRideTimer=false.obs;
  void rideTimer() {
    checkRideTimer.value=true;
    const oneSec = const Duration(seconds: 1);
    ridetimer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (ridestart == 60) {
          rideminute.value++;
          // timer.cancel();
          ridestart.value = 0;

        } else if (rideminute == 60) {
          ridehour.value++;
          // timer.cancel();
          rideminute.value = 0;

        }
        else {

          ridestart++;
        }
      },
    );
  }

  Future<int> cancelBooking() async {
    final instanceOfGlobalData = Get.find<GlobalData>();

    instanceOfGlobalData.loader.value = true;
    var body = {
      "cancelReason": "Not available"
    };
    try {

      final response = await APIManager.cancelBooking(body: body,
          bookingId: bookingId);
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));

      print("response.data : ${response.toString()}");

      instanceOfGlobalData.loader.value = false;

      showMySnackbar(title: "Msg", msg: "Ride canceled");
      timer.cancel();
      return 1;
    } catch (e) {

      showMySnackbar(title: "Error", msg: "Error while cancel booking");

      instanceOfGlobalData.loader.value = false;

      return 0;
    }
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
      await ImageHandler.getImage(fromGallery: false, pickedImage: (file){
        if(file!=null){
          if (selectedSideFoto == "front") {
            frontImageStatus.value = 1;
            frontHood.value = file;
          }
          else if (selectedSideFoto == "leftside") {
            leftImageStatus.value = 1;
            leftSide.value =file;
          }
          else if (selectedSideFoto == "rightside") {
            rightImageStatus.value = 1;
            rightSide.value = file;
          }
          else {
            backImageStatus.value = 1;
            backSide.value = file;
          }


          print("pickedImage path after ${frontHood.value.path}");
        }else{
          print("image not picked");
        }
      });
     // final XFile? image = await picker.pickImage(source: ImageSource.camera);

    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> uploadInspectionImage(String process) async {
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
        if(process == "S") {
          final response = await APIManager.postInspectionImageUrl(body: body,
              bookingId: (bookingId).toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));
          if (inspectionModel.value.status == true) {
            showMySnackbar(
                title: "Msg", msg: "Inspection Completed have a safe ride");

            resetValue();


          }
        }
        else{
          final response = await APIManager.endInspectionImageUrl(body: body,
              bookingId: (bookingId).toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));
          if (inspectionModel.value.status == true) {
            showMySnackbar(
                title: "Msg", msg: "Ride Completed successfully");

            resetValue();

          }
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

}
