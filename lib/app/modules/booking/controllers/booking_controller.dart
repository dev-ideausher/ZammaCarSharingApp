import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:zammacarsharing/app/modules/models/booking_ongoing_model.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/enride_mode.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/imoblizer_status.dart';
import 'package:zammacarsharing/app/modules/models/imspection_model.dart';
import 'package:zammacarsharing/app/modules/models/lock_model.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/modules/models/transationdetails_model.dart';
import 'package:zammacarsharing/app/modules/widgets/custom_camera.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/dialog_helper.dart';
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
  Rx<BookingOngoing> bookingOngoing = BookingOngoing().obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
  Rx<EndRide> endride = EndRide().obs;
  Rx<TransactionDetails> transactionDetails = TransactionDetails().obs;

  //pocGetLockStatus
  Rx<LockModel> lockModel=LockModel().obs;
  Rx<ImoblizerStatus> imoblizerStatus=ImoblizerStatus().obs;
  RxBool lockLoader=false.obs;
  RxBool UnlockLoader=false.obs;
  RxBool imoblizerLockLoader=false.obs;
  RxBool imoblizerUnlockLoader=false.obs;

  RxDouble totalFare=0.0.obs;
  RxDouble extraWaitingCharge=0.0.obs;
  RxDouble travelAmount=0.0.obs;
  RxInt promisedTravelTime=0.obs;
  RxDouble extraTravelTimeCharge=0.0.obs;
  RxString bookingType="".obs;
  RxString finalTralvelTime="".obs;
  RxString finalDistanceTravel="".obs;
  RxDouble finalTotalAmount=0.0.obs;
  RxDouble paidAmount=1.0.obs;

  RxString lodingMsg = "Analyzing your car".obs;

  final instanceOfGlobalData = Get.find<GlobalData>();
List<int> time=[];
  // Data Coming From Home Controller and ride history
  final bookingId=Get.arguments[0];
  final model=Get.arguments[1];
  final seatCapcity=Get.arguments[2];

  //loader variable
  RxBool loader=false.obs;

//QR Scanner Use
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog().obs;
   RxString code="".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if(Get.arguments[3]==false){
      carBooking.value=Get.arguments[3];
      rideStart.value=true;
    }
    getTransationDetails();
    getInProcessHistory();

   getLockStatus();
    getImoblizerStatus();
    getOnGoingHistory();

    print("bookinId : ${bookingId}");
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
      instanceOfGlobalData.timer.cancel();
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
   // final ImagePicker picker = ImagePicker();
   // print("pickedImage path before ${frontHood.value.path}");

   /* final picker = ImagePicker();
    PickedFile? pickedImage;
    pickedImage = await picker.getImage(source: ImageSource.camera);*/
    GenralCamera.openCamera(onCapture: (pickedImage){
      if (pickedImage != null) {

        if (selectedSideFoto == "front") {
          frontImageStatus.value = 1;
          frontHood.value = pickedImage;
        }
        else if (selectedSideFoto == "leftside") {
          leftImageStatus.value = 1;
          leftSide.value =pickedImage;
        }
        else if (selectedSideFoto == "rightside") {
          rightImageStatus.value = 1;
          rightSide.value =pickedImage;
        }
        else {
          backImageStatus.value = 1;
          backSide.value = pickedImage;
        }
      }
    });
 //  File pickedImage= await takePhoto();




 /*   try {
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
    }*/
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

        if(process == "S") {
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
              bookingId: (bookingId).toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));

          if (inspectionModel.value.status == true) {
            try {
              await markBookingOngoing();
              showMySnackbar(
                  title: "Msg", msg: "Booking Completed have a safe ride");

              resetValue();
            }catch(e){
              showMySnackbar(
                  title: "Error", msg: "Error While ongoing ride");

            }


          }
        }
        else{
          var body = {
            "type": "afterRide",
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
              bookingId: (bookingId).toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));



          if (inspectionModel.value.status == true) {
            try{
              var body2 ={
                "dropLocation": {
                  "type":"Point",
                  "coordinates":[80.9229409563887,26.842241990735474],
                  "address":"Lucknow"
                }
              };

              final responseend = await APIManager.endInspectionImageUrl(body: body2,
                  bookingId: (bookingId).toString());
              endride.value =
                  EndRide.fromJson(jsonDecode(responseend.toString()));
              calculateTotalBookingTimeAndTotalAmount(additionalWaitingTime:(endride.value.data?.additionalWaitingTime)!.toInt(),dropTime: (endride.value.data?.dropTime).toString(),pickupTime: (endride.value.data?.pickupTime).toString() );
              showMySnackbar(
                  title: "Msg", msg: "Ride Completed successfully");

              resetValue();
              if(Get.find<GlobalData>().timer.isActive){
                Get.find<GlobalData>().timer.cancel();
                Get.find<GlobalData>().start.value=60;
                Get.find<GlobalData>().checkTimer.value=false;
                Get.find<GlobalData>().minute.value=14;

              }
              if(Get.find<GlobalData>().ridetimer.isActive){
                Get.find<GlobalData>().ridetimer.cancel();
                Get.find<GlobalData>().ridestart.value=0;
                Get.find<GlobalData>().checkRideTimer.value=false;
                Get.find<GlobalData>().rideminute.value=0;
                Get.find<GlobalData>().ridehour.value=0;

              }


            }catch(e){
              showMySnackbar(
                  title: "Error", msg: "Error While ending ride");
              throw Exception('status code is ${response.statusCode}');

            }


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

  Future<int> markBookingOngoing() async {

    try {
      List<int> timeList= calculateWaitingTime();
var body=
  {
    "additionalWaitingTime":timeList[0],
    "waitingTime":timeList[1]

  };

      final response = await APIManager.markBookingOngoing(
          bookingId: bookingId,body: body);
      bookingOngoing.value =
          BookingOngoing.fromJson(jsonDecode(response.toString()));

      print("response.data : ${response.toString()}");

      return 1;
    } catch (e) {




      return 0;
    }
  }
  //getLockStatus
  getLockStatus() async {

    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    print(headers);
    final response = await http
        .get(Uri.parse(url),headers: headers);

    if (response.statusCode == 200) {


      lockModel.value =
          LockModel.fromJson(jsonDecode(response.body));




    } else {

      throw Exception('status code is ${response.statusCode}');
    }
  }
  getImoblizerStatus() async {

    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/immobilizer";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    print(headers);
    final response = await http
        .get(Uri.parse(url),headers: headers);

    if (response.statusCode == 200) {


      imoblizerStatus.value =
          ImoblizerStatus.fromJson(jsonDecode(response.body));




    } else {

      throw Exception('status code is ${response.statusCode}');
    }
  }

  putLock(String status) async {
    lockLoader.value=true;
    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    var body={
      "state": status
    };
    print(headers);
    final response = await http
        .put(Uri.parse(url),headers: headers,body:jsonEncode(body));

    if (response.statusCode == 200) {


      lockModel.value =
          LockModel.fromJson(jsonDecode(response.body));
      lockLoader.value=false;
    } else {
      lockLoader.value=false;
      throw Exception('status code is ${response.statusCode}');
    }
  }
  putUnlock(String status) async {
    UnlockLoader.value=true;
    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    var body={
      "state": status
    };
    print(headers);
    final response = await http
        .put(Uri.parse(url),headers: headers,body:jsonEncode(body));

    if (response.statusCode == 200) {


      lockModel.value =
          LockModel.fromJson(jsonDecode(response.body));
      UnlockLoader.value=false;
    } else {
      UnlockLoader.value=false;
      throw Exception('status code is ${response.statusCode}');
    }
  }
  Future<String> putAutoCentralLock(String status) async {

    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    var body={
      "state": status
    };
    print(headers);
    final response = await http
        .put(Uri.parse(url),headers: headers,body:jsonEncode(body));

    if (response.statusCode == 200) {


      lockModel.value =
          LockModel.fromJson(jsonDecode(response.body));

      return (lockModel.value.state).toString();
    } else {

      throw Exception('status code is ${response.statusCode}');
    }
  }
  Future<String> putImoblizerLock(String status) async {
    imoblizerLockLoader.value=true;
    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/immobilizer";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    var body={
      "state": status
    };
    print(headers);
    final response = await http
        .put(Uri.parse(url),headers: headers,body:jsonEncode(body));

    if (response.statusCode == 200) {


      imoblizerStatus.value =
          ImoblizerStatus.fromJson(jsonDecode(response.body));
      imoblizerLockLoader.value=false;
      return (imoblizerStatus.value.state).toString();
    } else {
      imoblizerLockLoader.value=false;
      throw Exception('status code is ${response.statusCode}');
    }
  }
  Future<String> putImoblizerUnlock(String status) async {
    imoblizerUnlockLoader.value=true;
    final url=Endpoints.getLockStatus+"${Get.find<GetStorageService>().getQNR}/immobilizer";
    var headers={

      "Content-Type":"application/json",
      "X-CloudBoxx-ApiKey":"W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"

    };
    var body={
      "state": status
    };
    print(headers);
    final response = await http
        .put(Uri.parse(url),headers: headers,body:jsonEncode(body));

    if (response.statusCode == 200) {

      imoblizerStatus.value =
          ImoblizerStatus.fromJson(jsonDecode(response.body));

      imoblizerUnlockLoader.value=false;
      return (imoblizerStatus.value.state).toString();
    } else {
      imoblizerUnlockLoader.value=false;
      throw Exception('status code is ${response.statusCode}');
    }
  }

  getInProcessHistory() async {

    try {
if(carInspection.value!=true) {
  loader.value = true;
  final response = await APIManager.getinProcessRideHistory();
  rideHistory.value =
      RideHistory.fromJson(jsonDecode(response.toString()));
  instanceOfGlobalData.timeCalculationInProgress(
      baseTime: (rideHistory.value.data?[0]?.createdAt).toString());
  loader.value = false;
}
    }catch(e){
      loader.value=false;
    }

  }

  getOnGoingHistory() async {

    try {
      if(rideStart.value==true) {
        print("ride Start");
        loader.value = true;
        final response = await APIManager.getOnGoingRideHistory();
        rideHistory.value =
            RideHistory.fromJson(jsonDecode(response.toString()));
        instanceOfGlobalData.timeCalculationOngoing(
            baseTime: (rideHistory.value.data?[0]?.updatedAt).toString());
        loader.value = false;
      }
    }catch(e){
      loader.value=false;
    }

  }
  Future<File> takePhoto() async {
    // Ensure that the device has a camera
    //Get.toNamed(Routes.CAMERA_DESIGN);
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw 'No camera found on device';
    }


    final controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller.initialize();


    final directory = await getTemporaryDirectory();
  //  final filePath = '${directory.path}/photo.jpg';
   var value= await controller.takePicture();


    final file = File(value.path);
    final bytes = await file.readAsBytes();
    return file;
  }

  getTransationDetails() async {

    try {

      final response = await APIManager.getPaymentHistory(bookingid: bookingId);
      transactionDetails.value = TransactionDetails.fromJson(jsonDecode(response.toString()));
      bookingType.value=(transactionDetails.value.bookingTransactions?[0]?.bookingPlan).toString();
      finalDistanceTravel.value=(transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.mile).toString();
      paidAmount.value=(transactionDetails.value.bookingTransactions?[0]?.totalPaidForBooking)!.toDouble();
      if(transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.time != null && transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.time!=0){
        promisedTravelTime.value=int.parse((transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.time).toString());
      }

       print("tranction data ${transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.mile}");


      print("");
    }catch(e){

    }

  }

 List<int> calculateWaitingTime(){
    int additinalWaitingTime=0;
    int totalwaitingTime=0;
    if(instanceOfGlobalData.minute.value<0){
     additinalWaitingTime=((instanceOfGlobalData.minute.value*60).abs())+(instanceOfGlobalData.start.value);
     totalwaitingTime=900+additinalWaitingTime;
     time.add(additinalWaitingTime);
     time.add(totalwaitingTime);
     return time;
    }else{
       totalwaitingTime=((900-(instanceOfGlobalData.minute.value*60)))+(instanceOfGlobalData.start.value);
       time.add(additinalWaitingTime);
       time.add(totalwaitingTime);
      return time;
    }


  }


  calculateTotalBookingTimeAndTotalAmount({required String pickupTime,required String dropTime,required int additionalWaitingTime}){
    DateTime startDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}");
    DateTime endDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(dropTime).toLocal()).format(Get.context!)}");
    final actualDifference=endDate.difference(startDate);
  //  "${TimeOfDay.fromDateTime(DateTime.parse(actualDifference).toLocal()).format(Get.context!)}";
    int second = actualDifference.inSeconds;
    finalTralvelTime.value="${actualDifference.inMinutes.toString()}";
    //0.39 dollar per minute
double drivingAmount=(second)*(0.0065);
double extraWaitingAmount=additionalWaitingTime*(0.0065);

if(bookingType.value=="custom"){
  if(((promisedTravelTime.value*60)*60)<second){
    double calculateCharge =  ((second-(promisedTravelTime.value*60))*(0.19/60));
    extraWaitingCharge.value=double.parse(extraWaitingAmount.toStringAsFixed(3));
    extraTravelTimeCharge.value=double.parse((calculateCharge).toStringAsFixed(3));
    totalFare.value=double.parse((extraWaitingAmount+calculateCharge).toStringAsFixed(3));
    finalTotalAmount.value=totalFare.value;
    totalFare.value=totalFare.value-(paidAmount.value);
  }
  else{
    extraTravelTimeCharge.value=0.0;
    totalFare.value=0.0;
    finalTotalAmount.value=paidAmount.value;
    extraWaitingCharge.value=double.parse(extraWaitingAmount.toStringAsFixed(3));
  }

}
else{
  totalFare.value=double.parse((drivingAmount+extraWaitingAmount).toStringAsFixed(3));
  finalTotalAmount.value=totalFare.value;
  totalFare.value=totalFare.value-(paidAmount.value);
  extraWaitingCharge.value=double.parse(extraWaitingAmount.toStringAsFixed(3));
  travelAmount.value=double.parse(drivingAmount.toStringAsFixed(3));
}




  }
}
