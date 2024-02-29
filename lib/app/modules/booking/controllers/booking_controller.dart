import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zammacarsharing/app/modules/home/controllers/home_controller.dart';
import 'package:zammacarsharing/app/modules/models/booking_ongoing_model.dart';
import 'package:zammacarsharing/app/modules/models/car_pricing_model.dart';
import 'package:zammacarsharing/app/modules/models/create_bookin_model.dart';
import 'package:zammacarsharing/app/modules/models/enride_mode.dart';
import 'package:zammacarsharing/app/modules/models/get_bookings_details.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/imoblizer_status.dart';
import 'package:zammacarsharing/app/modules/models/imspection_model.dart';
import 'package:zammacarsharing/app/modules/models/lock_model.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/modules/models/transationdetails_model.dart';
import 'package:zammacarsharing/app/modules/widgets/custom_camera.dart';
import 'package:zammacarsharing/app/services/checkLocationPermission.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:zammacarsharing/app/services/tokenCreatorAndValidator.dart';

class BookingController extends GetxController {
  //TODO: Implement BookingController

  //variable
  var currentSliderValue = 20.0.obs;
  LatLng center = LatLng(45.521563, -122.677433);
  Rx<bool> light = false.obs;
  Rxn<File> frontHood = Rxn(null);
  Rxn<File> backSide = Rxn(null);
  Rxn<File> rightSide = Rxn(null);
  Rxn<File> leftSide = Rxn(null);
  Rx<bool> carInspection = false.obs;
  Rx<bool> rideStart = false.obs;
  Rx<bool> endrideInspection = false.obs;
  Rx<bool> bookingPriceDetails = false.obs;
  Rx<bool> carBooking = true.obs;
  Rx<bool> hasInternet = true.obs;

  //response model
  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  Rx<BookingDetailsModels> getBookingDetailsModel = BookingDetailsModels().obs;

  Rx<ImageUpload> imageUpload = ImageUpload().obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
  Rx<TransactionDetails> transactionDetails = TransactionDetails().obs;

  //pocGetLockStatus

  Rx<LockModel> lockModel = LockModel().obs;
  RxBool lockLoader = false.obs;
  RxBool UnlockLoader = false.obs;

  RxDouble totalFare = 0.0.obs;
  RxDouble extraWaitingCharge = 0.0.obs;
  RxDouble travelAmount = 0.0.obs;
  RxInt promisedTravelTime = 0.obs;
  RxDouble extraTravelTimeCharge = 0.0.obs;
  RxString bookingType = "".obs;
  RxString finalTralvelTime = "".obs;
  RxString finalDistanceTravel = "".obs;
  RxDouble finalTotalAmount = 0.0.obs;
  RxDouble paidAmount = 1.0.obs;
  RxString lodingMsg = "Analyzing your car".obs;

  final instanceOfGlobalData = Get.find<GlobalData>();
  List<int> time = [];

  // Data Coming From Home Controller and ride history
  final bookingId = Get.arguments[0] ?? "";
  final model = Get.arguments[1] ?? "";
  final seatCapcity = Get.arguments[2] ?? "";

  //loader variable
  RxBool loader = false.obs;

//QR Scanner Use
  final qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog().obs;
  RxString code = "".obs;
  var connectivityStream;

  Timer? timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    final User? user = await firebaseAuth.currentUser;
    if (user != null) {
      await Get.find<TokenCreateGenrate>().validateCreatetoken(user);
    }
    if (Get.arguments[3] == false) {
      carBooking.value = Get.arguments[3];
      rideStart.value = true;
    }
    getTransationDetails();
    getInProcessHistory();
    getBookingDetailsUsingBookingId();
    getLockStatus();
    getImoblizerStatus();
    getOnGoingHistory();
    print("bookinId : ${bookingId}");
  }

  @override
  void onReady() {
    super.onReady();
    // connectivityStream = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) async {
    //   if (result == ConnectivityResult.none) {
    //     showMySnackbar(
    //         title: "No Internet Connection", msg: "Please connect to internet");
    //     hasInternet.value = false;
    //   } else {
    //     hasInternet.value = true;
    //   }
    // });
    hasInternet.value = true;
    timer = Timer.periodic(const Duration(seconds: 2),
        (Timer t) => getBookingDetailsUsingBookingIdTimmer());
  }

  @override
  void onClose() {
    timer?.cancel();
    connectivityStream.cancel();
    super.dispose();
  }

  resetValue() {
    frontHood.value = null;
    leftSide.value = null;
    backSide.value = null;
    rightSide.value = null;
  }

  RxBool bookingDetailsLoader = false.obs;

  getBookingDetailsUsingBookingId() async {
    await Future.delayed(Duration(seconds: 3));
    await getOnGoingHistory();
    await Get.find<HomeController>().getcar();
    try {
      bookingDetailsLoader.value = true;
      final response = await APIManager.getBookingByBookingId(
          bookingId: bookingId == ""
              ? "${rideHistory.value.data?[0]?.Id}"
              : bookingId);
      getBookingDetailsModel.value =
          BookingDetailsModels.fromJson(jsonDecode(response.toString()));

      Get.find<GetStorageService>().bookedCarID =
          "${getBookingDetailsModel.value.data?.car?.Id}";
      print(Get.find<GetStorageService>().bookedCarID);
      bookingDetailsLoader.value = false;
    } catch (e) {
      bookingDetailsLoader.value = false;
      throw "Error while fetching booking details by booking id";
    }
  }

  var c = 0.obs;
  getBookingDetailsUsingBookingIdTimmer() async {
    try {
      //TODO booking id error
      if (!hasInternet.value) {
        return;
      }
      print("bookingId : ${bookingId}");
      bookingDetailsLoader.value = true;
      final response = await APIManager.getBookingByBookingId(
        bookingId:
            bookingId == "" ? "${rideHistory.value.data?[0]?.Id}" : bookingId,
      );
      getBookingDetailsModel.value =
          BookingDetailsModels.fromJson(jsonDecode(response.toString()));

      Get.find<GetStorageService>().bookedCarID =
          "${getBookingDetailsModel.value.data?.car?.Id}";
      print(Get.find<GetStorageService>().bookedCarID);
      bookingDetailsLoader.value = false;
    } catch (e) {
      bookingDetailsLoader.value = false;
      // throw "Error while fetching booking details by booking id";
    }
  }

  Future<int> cancelBooking() async {
    final instanceOfGlobalData = Get.find<GlobalData>();

    instanceOfGlobalData.loader.value = true;
    var body = {"cancelReason": "Not available"};
    try {
      final response = await APIManager.cancelBooking(
          body: body,
          bookingId:
              bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId);
      createBookinModel.value =
          CreateBookinModel.fromJson(jsonDecode(response.toString()));
      print("response.data : ${response.toString()}");
      instanceOfGlobalData.loader.value = false;
      showMySnackbar(title: "Message", msg: "Ride canceled");
      instanceOfGlobalData.waitingRideTicker.cancel();
      return 1;
    } catch (e) {
      showMySnackbar(title: "Error", msg: "Error while cancel booking");
      instanceOfGlobalData.loader.value = false;
      return 0;
    }
  }

  Future<dynamic> uploadImages(List<File> images) async {
    String token = Get.find<GetStorageService>().jwToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.imapgeUpload),
    );
    request.fields.addAll({'type': 'userProfile'});
    var headers = {'accept': 'application/json', 'token': token};
    for (int i = 0; i < images.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath('file', images[i].path));
    }
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
    GenralCamera.openCamera(onCapture: (pickedImage) {
      if (pickedImage != null) {
        if (selectedSideFoto == "front") {
          frontHood.value = pickedImage;
        } else if (selectedSideFoto == "leftside") {
          leftSide.value = pickedImage;
        } else if (selectedSideFoto == "rightside") {
          rightSide.value = pickedImage;
        } else {
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

  Future<List<String>> uploadInspectionImages(BuildContext context) async {
    if (frontHood.value == null ||
        leftSide.value == null ||
        rightSide.value == null ||
        backSide.value == null) {
      throw MyException("All image mandatory");
    } else {
      List<String?> carsImage = [];
      try {
        lodingMsg.value = "Uploading Images";
        context.loaderOverlay.show();
        final response = await uploadImages([
          frontHood.value!,
          leftSide.value!,
          rightSide.value!,
          backSide.value!,
        ]);
        imageUpload.value = ImageUpload.fromJson(response);
        carsImage = imageUpload.value.urls!;
        context.loaderOverlay.hide();
        return carsImage as List<String>;
      } catch (e) {
        instanceOfGlobalData.loader.value = false;
        throw MyException("Error while uploading images");
      }
    }
  }

  Future<BookingOngoing> markBookingOngoing() async {
    try {
      final body = {
        "additionalWaitingTime": instanceOfGlobalData.aditionalWaiting.value,
        "waitingTime": instanceOfGlobalData.totalWaiting.value,
        // pickUpTime : "2022-12-21T13:52:44.615Z"
        "pickupTime": DateTime.now().toIso8601String(),
      };
      final response = await APIManager.markBookingOngoing(
          bookingId:
              bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId,
          body: body);
      final bookingOngoing =
          BookingOngoing.fromJson(jsonDecode(response.toString()));
      return bookingOngoing;
    } catch (e) {
      throw MyException("Error while marking booking ongoing");
    }
  }

  //getLockStatus
  getLockStatus() async {
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers = {
      "Content-Type": "application/json",
      "X-CloudBoxx-ApiKey":
          "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
    };
    print(headers);
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      lockModel.value = LockModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('status code is ${response.statusCode}');
    }
  }

  getImoblizerStatus() async {
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/immobilizer";
    var headers = {
      "Content-Type": "application/json",
      "X-CloudBoxx-ApiKey":
          "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
    };
    print(headers);
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final imoblizerStatus =
          ImoblizerStatus.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('status code is ${response.statusCode}');
    }
  }

  putLock(String status) async {
    lockLoader.value = true;
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers = {
      "Content-Type": "application/json",
      "X-CloudBoxx-ApiKey":
          "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
    };
    var body = {"state": status};
    print(headers);
    final response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      lockModel.value = LockModel.fromJson(jsonDecode(response.body));
      lockLoader.value = false;
    } else {
      lockLoader.value = false;
      throw Exception('status code is ${response.statusCode}');
    }
  }

  putUnlock(String status) async {
    UnlockLoader.value = true;
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers = {
      "Content-Type": "application/json",
      "X-CloudBoxx-ApiKey":
          "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
    };
    var body = {"state": status};
    print(headers);
    final response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      lockModel.value = LockModel.fromJson(jsonDecode(response.body));
      UnlockLoader.value = false;
    } else {
      UnlockLoader.value = false;
      throw Exception('status code is ${response.statusCode}');
    }
  }

  Future<String> putAutoCentralLock(String status) async {
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/central-lock";
    var headers = {
      "Content-Type": "application/json",
      "X-CloudBoxx-ApiKey":
          "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
    };
    var body = {"state": status};
    print(headers);
    final response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      lockModel.value = LockModel.fromJson(jsonDecode(response.body));

      return (lockModel.value.state).toString();
    } else {
      throw Exception('status code is ${response.statusCode}');
    }
  }

  Future<LockStatus> changeImmobilizerLock(LockStatus status) async {
    try {
      final url =
          "${Endpoints.getLockStatus}${Get.find<GetStorageService>().getQNR}/immobilizer";
      var headers = {
        "Content-Type": "application/json",
        "X-CloudBoxx-ApiKey":
            "W5nQBVHwxnZd6Iivnsu+31yg60EEdyrwbW5p1FVEgFuHEiKhDlbg0+gBlF4X+dm/"
      };
      var body = {"state": status.toString()};
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final imoblizerStatus =
            ImoblizerStatus.fromJson(jsonDecode(response.body));
        return imoblizerStatus.lockStatus;
      } else {
        throw Exception('status code is ${response.statusCode}');
      }
    } catch (e) {
      throw MyException('Error while changing immobilizer lock');
    }
  }

  getInProcessHistory() async {
    try {
      if (carInspection.value != true) {
        loader.value = true;
        final response = await APIManager.getinProcessRideHistory();
        rideHistory.value =
            RideHistory.fromJson(jsonDecode(response.toString()));
        instanceOfGlobalData.waitingLastStampToseconds(
            startTime: DateTime.parse(
                (rideHistory.value.data?[0]?.createdAt).toString()));
        loader.value = false;
      }
    } catch (e) {
      loader.value = false;
    }
  }

  getOnGoingHistory() async {
    try {
      if (rideStart.value == true) {
        print("ride Start");
        if (!hasInternet.value) {
          return;
        }
        loader.value = true;
        final response = await APIManager.getOnGoingRideHistory();
        rideHistory.value =
            RideHistory.fromJson(jsonDecode(response.toString()));
        instanceOfGlobalData.lastStampToseconds(
            startTime: DateTime.parse(
                (rideHistory.value.data?[0]?.pickupTime).toString()));

        loader.value = false;
      }
    } catch (e) {
      print(e);
      loader.value = false;
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
    var value = await controller.takePicture();

    final file = File(value.path);
    final bytes = await file.readAsBytes();
    return file;
  }

  getTransationDetails() async {
    try {
      final response = await APIManager.getPaymentHistory(
          bookingid:
              bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId);
      transactionDetails.value =
          TransactionDetails.fromJson(jsonDecode(response.toString()));
      bookingType.value =
          (transactionDetails.value.bookingTransactions?[0]?.bookingPlan)
              .toString();
      finalDistanceTravel.value = (transactionDetails
              .value.bookingTransactions?[0]?.bookingPaymentObject?.mile)
          .toString();
      paidAmount.value = (transactionDetails
              .value.bookingTransactions?[0]?.totalPaidForBooking)!
          .toDouble();
      if (transactionDetails
                  .value.bookingTransactions?[0]?.bookingPaymentObject?.time !=
              null &&
          transactionDetails
                  .value.bookingTransactions?[0]?.bookingPaymentObject?.time !=
              0) {
        promisedTravelTime.value = int.parse((transactionDetails
                .value.bookingTransactions?[0]?.bookingPaymentObject?.time)
            .toString());
      }

      print(
          "tranction data ${transactionDetails.value.bookingTransactions?[0]?.bookingPaymentObject?.mile}");

      print("");
    } catch (e) {}
  }

  calculateTotalBookingTimeAndTotalAmount(
      {required String pickupTime,
      required String dropTime,
      required int additionalWaitingTime,
      required double extraTimeCharges,
      required double extraMileCharges}) {
    DateTime startDate = DateTime.parse((pickupTime).toString());
    DateTime endDate = DateTime.parse((dropTime).toString());
    final actualDifference = endDate.toUtc().difference(startDate.toUtc());

    int second = actualDifference.inSeconds;
    finalTralvelTime.value = actualDifference.inMinutes.toString();

    //0.39 dollar per minute
    double drivingAmount = (second) * (0.0065);
    double extraWaitingAmount = additionalWaitingTime * (0.0065);

    if (bookingType.value == "custom") {
      if (((promisedTravelTime.value * 60) * 60) < second) {
        double calculateCharge =
            ((second - ((promisedTravelTime.value * 60) * 60)) *
                (extraTimeCharges / 60));
        extraWaitingCharge.value =
            double.parse(extraWaitingAmount.toStringAsFixed(3));
        extraTravelTimeCharge.value =
            double.parse((calculateCharge).toStringAsFixed(3));
        totalFare.value = double.parse(
            (extraWaitingAmount + calculateCharge).toStringAsFixed(3));
        finalTotalAmount.value = totalFare.value;
        totalFare.value = totalFare.value - (paidAmount.value);
      } else {
        extraTravelTimeCharge.value = 0.0;
        totalFare.value = 0.0;
        finalTotalAmount.value = paidAmount.value;
        extraWaitingCharge.value =
            double.parse(extraWaitingAmount.toStringAsFixed(3));
      }
    } else {
      totalFare.value =
          double.parse((drivingAmount + extraWaitingAmount).toStringAsFixed(3));
      finalTotalAmount.value = totalFare.value;
      totalFare.value = totalFare.value - (paidAmount.value);
      extraWaitingCharge.value =
          double.parse(extraWaitingAmount.toStringAsFixed(3));
      travelAmount.value = double.parse(drivingAmount.toStringAsFixed(3));
    }
  }

  Future<void> openMap() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      //mapLoader.value=false;
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print("position lat  : ${position.latitude}, long : ${position.longitude}");

    var sourceLatitude = position.latitude;
    var sourceLongitude = position.longitude;
    var destinationLongitude =
        getBookingDetailsModel.value.data?.car?.position?.coordinates?[0];
    var destinationLatitude =
        getBookingDetailsModel.value.data?.car?.position?.coordinates?[0];
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$sourceLatitude,$sourceLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';
    //  final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openMapRide() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      //mapLoader.value=false;
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print("position lat  : ${position.latitude}, long : ${position.longitude}");

    var sourceLatitude = position.latitude;
    var sourceLongitude = position.longitude;
    var destinationLongitude =
        getBookingDetailsModel.value.data?.car?.position?.coordinates?[0];
    var destinationLatitude =
        getBookingDetailsModel.value.data?.car?.position?.coordinates?[0];
    //  String mapOptions = ['saddr=$sourceLatitude,$sourceLongitude', 'daddr=$destinationLatitude,$destinationLongitude', 'dir_action=navigate'].join('&');
    final url =
        //" https://www.google.com/maps/dir/api=1&destination=${Get.find<HomeController>().latitude},${Get.find<HomeController>().longitude}&travelmode=driving';";
        'https://www.google.com/maps?q=${Get.find<HomeController>().latitude},${Get.find<HomeController>().longitude}&travelmode=driving&dir_action=navigate';
    https: //www.google.com/maps/dir/?api=1&origin=$sourceLatitude,$sourceLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate
    //  final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<InspectionModel> inspectRide(
      RideStatus rideStatus, List<String> carsImage) async {
    try {
      final response = await APIManager.postInspectionImageUrl(
          body: {
            "type": rideStatus == RideStatus.start ? "beforeRide" : "afterRide",
            RideStatus.start == rideStatus
                ? "carImagesBeforeRide"
                : "carImagesAfterRide": [
              {"respectiveSide": "Front Hood", "image": carsImage[0]},
              {"respectiveSide": "Left Side", "image": carsImage[1]},
              {"respectiveSide": "Right Side", "image": carsImage[2]},
              {"respectiveSide": "Back Side", "image": carsImage[3]}
            ]
          },
          bookingId:
              (bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId)
                  .toString());
      final inspectionModel =
          InspectionModel.fromJson(jsonDecode(response.toString()));
      return inspectionModel;
    } catch (e) {
      showMySnackbar(title: "Error", msg: "Error while inspection");
      throw Exception('status code is $e');
    }
  }

  startRide(BuildContext context) async {
    try {
      final images = await uploadInspectionImages(context);
      lodingMsg.value = "Inspecting Images";
      context.loaderOverlay.show();
      final inspectionModel = await inspectRide(RideStatus.start, images);
      resetValue();
      if (inspectionModel.status == true) {
        try {
          lodingMsg.value = "Updating lock";
          final lockStatus = await changeImmobilizerLock(LockStatus.unlocked);
          if (lockStatus == LockStatus.unlocked) {
            await markBookingOngoing();
            showMySnackbar(
                title: "Message", msg: "Booking Completed have a safe ride");
            rideStart.value = true;
            carInspection.value = false;
            showMySnackbar(title: "Message", msg: "Ride Started");
          } else {
            showMySnackbar(title: "Error", msg: "Error while unlocking");
          }
        } catch (e) {
          showMySnackbar(title: "Error", msg: "Error While ongoing ride");
        }
      }
    } on MyException catch (e) {
      showMySnackbar(title: "Error", msg: e.toString());
    } catch (e) {
      showMySnackbar(title: "Error", msg: "Error while starting ride");
    }
    context.loaderOverlay.hide();
  }

  endRide(BuildContext context) async {
    try {
      final images = await uploadInspectionImages(context);
      lodingMsg.value = "Inspecting Images";
      context.loaderOverlay.show();
      final inspectionModel = await inspectRide(RideStatus.end, images);
      if (inspectionModel.status == true) {
        lodingMsg.value = "Ending Ride";
        await endBooking();
        lodingMsg.value = "Updating lock";
        final lockStatus = await changeImmobilizerLock(LockStatus.locked);
        if (lockStatus == LockStatus.locked) {
          showMySnackbar(title: "Message", msg: "Car Locked");
        } else {
          showMySnackbar(title: "Error", msg: "Error while unlocking");
        }
        bookingPriceDetails.value = true;
        endrideInspection.value = false;
        carInspection.value = false;
        rideStart.value = false;
        carBooking.value = false;
        resetValue();
        showMySnackbar(title: "Message", msg: "Ride Completed successfully");
      } else {
        showMySnackbar(title: "Error", msg: "Error while ending ride");
      }
    } on MyException catch (e) {
      showMySnackbar(title: "Error", msg: e.toString());
    } catch (e) {}
    context.loaderOverlay.hide();
  }

  Future<void> endBooking() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      //mapLoader.value=false;
      throw MyException("Location permission not granted");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final response = await APIManager.endInspectionImageUrl(
        body: {
          "dropLocation": {
            "type": "Point",
            "coordinates": [position.longitude, position.latitude],
            "address": "Unknown",
          },
          "dropTime": DateTime.now().toIso8601String()
        },
        bookingId:
            (bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId)
                .toString());
    final endride = EndRide.fromJson(jsonDecode(response.toString()));
    final response2 = await APIManager.getCarPricingById(
        carId: (endride.data?.car).toString());
    final carPriceById =
        CarPriceById.fromJson(jsonDecode(response2.toString()));
    calculateTotalBookingTimeAndTotalAmount(
        extraMileCharges:
            double.parse("${carPriceById.carPricing?.extraMileRate}"),
        extraTimeCharges:
            double.parse("${carPriceById.carPricing?.extraMinuteRate}"),
        additionalWaitingTime: (endride.data?.additionalWaitingTime)!.toInt(),
        dropTime: (endride.data?.dropTime).toString(),
        pickupTime: (endride.data?.pickupTime).toString());

    // final mileage =
    // (endRideModel.data?.tripData?[0]?.event?.status?.mileage)!;
  }
  //   if (inspectionModel.value.status == true) {
  //     try {
  //       await markBookingOngoing();
  //       showMySnackbar(
  //           title: "Message", msg: "Booking Completed have a safe ride");
  //       resetValue();
  //     } catch (e) {
  //       showMySnackbar(title: "Error", msg: "Error While ongoing ride");
  //     }
  //   }
  //   if (inspectionModel.value.status == true) {
  //     try {
  //       var body2 = {
  //         "dropLocation": {
  //           "type": "Point",
  //           "coordinates": [80.9229409563887, 26.842241990735474],
  //           "address": "Lucknow"
  //         }
  //       };
  //
  //       final responseend = await APIManager.endInspectionImageUrl(
  //           body: body2,
  //           bookingId: (bookingId == ""
  //               ? rideHistory.value.data![0]!.Id
  //               : bookingId)
  //               .toString());
  //       endride.value =
  //           EndRide.fromJson(jsonDecode(responseend.toString()));
  //
  //       final response = await APIManager.getCarPricingById(
  //           carId: (endride.value.data?.car).toString());
  //       carPriceById.value =
  //           CarPriceById.fromJson(jsonDecode(response.toString()));
  //
  //       calculateTotalBookingTimeAndTotalAmount(
  //           extraMileCharges: double.parse(
  //               "${carPriceById.value.carPricing?.extraMileRate}"),
  //           extraTimeCharges: double.parse(
  //               "${carPriceById.value.carPricing?.extraMinuteRate}"),
  //           additionalWaitingTime:
  //           (endride.value.data?.additionalWaitingTime)!.toInt(),
  //           dropTime: (endride.value.data?.dropTime).toString(),
  //           pickupTime: (endride.value.data?.pickupTime).toString());
  //       milage.value =
  //       (endride.value.data?.tripData?[0]?.event?.status?.mileage)!;
  //       showMySnackbar(
  //           title: "Message", msg: "Ride Completed successfully");
  //
  //       resetValue();
  //
  //       if (instanceOfGlobalData.rideTicker.isActive) {
  //         instanceOfGlobalData.rideTicker.cancel();
  //         instanceOfGlobalData.checkRideTicker.value = false;
  //       }
  //     } catch (e) {
  //       showMySnackbar(title: "Error", msg: "Error While ending ride");
  //       throw Exception('status code is ${response.statusCode}');
  //     }
  //   }
  // }

  // verifyAndEnd() {
  //   if (controller.frontImageStatus.value == 0 ||
  //       controller.leftImageStatus.value == 0 ||
  //       controller.rightImageStatus.value == 0 ||
  //       controller.backImageStatus == 0) {
  //     showMySnackbar(title: "Error", msg: "All image mandatory");
  //   } else {
  //     controller.lodingMsg.value = "Updating central lock";
  //     context.loaderOverlay.show();
  //     controller.putAutoCentralLock("locked").then((value) {
  //       if (value == "locked") {
  //         Future.delayed(const Duration(seconds: 1), () {
  //           controller.lodingMsg.value = "Updating immobilizer lock";
  //           controller.putImoblizerLock("locked").then((value) {
  //             if (value == "locked") {
  //               Future.delayed(const Duration(seconds: 1), () {
  //                 controller.lodingMsg.value = "Uploading image";
  //
  //                 controller.uploadInspectionImages("E").then((value) {
  //                   if (value == 1) {
  //                     controller.bookingPriceDetails.value = true;
  //                     controller.endrideInspection.value = false;
  //                     controller.rideStart.value = false;
  //                     context.loaderOverlay.hide();
  //                     controller.carBooking.value = false;
  //                   } else {
  //                     context.loaderOverlay.hide();
  //                     showMySnackbar(
  //                         title: "Error", msg: "Error while inspection");
  //                   }
  //                 });
  //               });
  //             } else {
  //               Future.delayed(const Duration(seconds: 1), () {
  //                 context.loaderOverlay.hide();
  //                 showMySnackbar(
  //                     title: "Error",
  //                     msg: "Error while updating immobilizer lock");
  //                 controller.lodingMsg.value = "Analyzing your car";
  //               });
  //             }
  //           });
  //         });
  //       } else {
  //         Future.delayed(const Duration(seconds: 1), () {
  //           context.loaderOverlay.hide();
  //           showMySnackbar(
  //               title: "Error", msg: "Error while updating central lock");
  //           controller.lodingMsg.value = "Analyzing your car";
  //         });
  //       }
  //     });
  //   }
  // }

  // Future<void> verifyAndInspect(
  //     BuildContext context, RideStatus rideStatus) async {
  //   if (frontImageStatus.value == 0 ||
  //       leftImageStatus.value == 0 ||
  //       rightImageStatus.value == 0 ||
  //       backImageStatus == 0) {
  //     showMySnackbar(title: "Error", msg: "All image mandatory");
  //   } else {
  //     lodingMsg.value = "Uploading image";
  //     context.loaderOverlay.show();
  //
  //     uploadInspectionImages("S").then((value) {
  //       if (value == 1) {
  //         putImoblizerUnlock("unlocked").then((value) {
  //           if (value != "locked") {
  //             Future.delayed(const Duration(seconds: 1), () {
  //               context.loaderOverlay.hide();
  //               rideStart.value = true;
  //               carInspection.value = false;
  //             });
  //           } else {
  //             showMySnackbar(title: "Error", msg: "Error unlocking imoblizer");
  //           }
  //         });
  //       } else {
  //         showMySnackbar(title: "Error", msg: "Error while inspection");
  //       }
  //     });
  //   }
  //   rideStart.value = true;
  // }
}

enum RideStatus { start, end }

enum LockStatus {
  locked,
  unlocked,
  unknown;

  @override
  String toString() {
    return this == LockStatus.locked ? "locked" : "unlocked";
  }
}

class MyException implements Exception {
  final String message;
  MyException(this.message);

  @override
  String toString() {
    return message;
  }
}
