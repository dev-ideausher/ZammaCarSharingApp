import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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
  Rx<bool> endrideInspection = false.obs;
  Rx<bool> bookingPriceDetails = false.obs;
  Rx<bool> carBooking = true.obs;

  //response model
  Rx<CreateBookinModel> createBookinModel = CreateBookinModel().obs;
  Rx<BookingDetailsModels> getBookingDetailsModel = BookingDetailsModels().obs;
  Rx<InspectionModel> inspectionModel = InspectionModel().obs;

  Rx<ImageUpload> imageUpload = ImageUpload().obs;
  Rx<BookingOngoing> bookingOngoing = BookingOngoing().obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
  Rx<TransactionDetails> transactionDetails = TransactionDetails().obs;
  Rx<CarPriceById> carPriceById = CarPriceById().obs;

  //pocGetLockStatus

  Rx<LockModel> lockModel = LockModel().obs;
  Rx<ImoblizerStatus> imoblizerStatus = ImoblizerStatus().obs;
  RxBool lockLoader = false.obs;
  RxBool UnlockLoader = false.obs;
  RxBool imoblizerLockLoader = false.obs;
  RxBool imoblizerUnlockLoader = false.obs;

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
  RxInt milage = 0.obs;
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
    timer = Timer.periodic(Duration(seconds: 2),
        (Timer t) => getBookingDetailsUsingBookingIdTimmer());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.dispose();
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
    print("object");
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

  Future<dynamic> uploadImage(String path) async {
    String token = Get.find<GetStorageService>().jwToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.imapgeUpload),
    );
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
    GenralCamera.openCamera(onCapture: (pickedImage) {
      if (pickedImage != null) {
        if (selectedSideFoto == "front") {
          frontImageStatus.value = 1;
          frontHood.value = pickedImage;
        } else if (selectedSideFoto == "leftside") {
          leftImageStatus.value = 1;
          leftSide.value = pickedImage;
        } else if (selectedSideFoto == "rightside") {
          rightImageStatus.value = 1;
          rightSide.value = pickedImage;
        } else {
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
    if (frontImageStatus.value == 0 ||
        leftImageStatus.value == 0 ||
        rightImageStatus.value == 0 ||
        backImageStatus == 0) {
      showMySnackbar(title: "Error", msg: "All image mandatory");
      return 0;
    } else {
      try {
        instanceOfGlobalData.loader.value = true;
        carsImage.value.clear();
        for (int i = 0; i < 4; i++) {
          if (i == 0) {
            var response = await uploadImage(frontHood.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          } else if (i == 1) {
            var response = await uploadImage(leftSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          } else if (i == 2) {
            var response = await uploadImage(rightSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          } else if (i == 3) {
            var response = await uploadImage(backSide.value.path);
            imageUpload.value = ImageUpload.fromJson(response);
            carsImage.add(imageUpload.value.urls?[0]);
          }
        }

        if (process == "S") {
          var body = {
            "type": "beforeRide",
            "carImagesBeforeRide": [
              {"respectiveSide": "Front Hood", "image": carsImage.value[0]},
              {"respectiveSide": "Left Side", "image": carsImage.value[1]},
              {"respectiveSide": "Right Side", "image": carsImage.value[2]},
              {"respectiveSide": "Back Side", "image": carsImage.value[3]}
            ]
          };
          final response = await APIManager.postInspectionImageUrl(
              body: body,
              bookingId:
                  (bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId)
                      .toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));

          if (inspectionModel.value.status == true) {
            try {
              await markBookingOngoing();
              showMySnackbar(
                  title: "Message", msg: "Booking Completed have a safe ride");

              resetValue();
            } catch (e) {
              showMySnackbar(title: "Error", msg: "Error While ongoing ride");
            }
          }
        } else {
          var body = {
            "type": "afterRide",
            "carImagesAfterRide": [
              {"respectiveSide": "Front Hood", "image": carsImage.value[0]},
              {"respectiveSide": "Left Side", "image": carsImage.value[1]},
              {"respectiveSide": "Right Side", "image": carsImage.value[2]},
              {"respectiveSide": "Back Side", "image": carsImage.value[3]}
            ]
          };
          final response = await APIManager.postInspectionImageUrl(
              body: body,
              bookingId:
                  (bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId)
                      .toString());
          inspectionModel.value =
              InspectionModel.fromJson(jsonDecode(response.toString()));

          if (inspectionModel.value.status == true) {
            try {
              var body2 = {
                "dropLocation": {
                  "type": "Point",
                  "coordinates": [80.9229409563887, 26.842241990735474],
                  "address": "Lucknow"
                }
              };

              final responseend = await APIManager.endInspectionImageUrl(
                  body: body2,
                  bookingId: (bookingId == ""
                          ? rideHistory.value.data![0]!.Id
                          : bookingId)
                      .toString());
              endride.value =
                  EndRide.fromJson(jsonDecode(responseend.toString()));

              final response = await APIManager.getCarPricingById(
                  carId: (endride.value.data?.car).toString());
              carPriceById.value =
                  CarPriceById.fromJson(jsonDecode(response.toString()));

              calculateTotalBookingTimeAndTotalAmount(
                  extraMileCharges: double.parse(
                      "${carPriceById.value.carPricing?.extraMileRate}"),
                  extraTimeCharges: double.parse(
                      "${carPriceById.value.carPricing?.extraMinuteRate}"),
                  additionalWaitingTime:
                      (endride.value.data?.additionalWaitingTime)!.toInt(),
                  dropTime: (endride.value.data?.dropTime).toString(),
                  pickupTime: (endride.value.data?.pickupTime).toString());
              // milage.value =
              //     (endride.value.data?.tripData?[0]?.event?.status?.mileage)!;
              showMySnackbar(
                  title: "Message", msg: "Ride Completed successfully");

              resetValue();

              if (Get.find<GlobalData>().rideTicker.isActive) {
                Get.find<GlobalData>().rideTicker.cancel();
                Get.find<GlobalData>().checkRideTicker.value = false;
              }

              /*if(Get.find<GlobalData>().timer.isActive){
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

              }*/
            } catch (e) {
              showMySnackbar(title: "Error", msg: "Error While ending ride");
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
      var body = {
        "additionalWaitingTime": instanceOfGlobalData.aditionalWaiting.value,
        "waitingTime": instanceOfGlobalData.totalWaiting.value
      };

      final response = await APIManager.markBookingOngoing(
          bookingId:
              bookingId == "" ? rideHistory.value.data![0]!.Id : bookingId,
          body: body);
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
      imoblizerStatus.value =
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

  Future<String> putImoblizerLock(String status) async {
    imoblizerLockLoader.value = true;
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/immobilizer";
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
      imoblizerStatus.value =
          ImoblizerStatus.fromJson(jsonDecode(response.body));
      imoblizerLockLoader.value = false;
      return (imoblizerStatus.value.state).toString();
    } else {
      imoblizerLockLoader.value = false;
      throw Exception('status code is ${response.statusCode}');
    }
  }

  Future<String> putImoblizerUnlock(String status) async {
    imoblizerUnlockLoader.value = true;
    final url = Endpoints.getLockStatus +
        "${Get.find<GetStorageService>().getQNR}/immobilizer";
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
      imoblizerStatus.value =
          ImoblizerStatus.fromJson(jsonDecode(response.body));

      imoblizerUnlockLoader.value = false;
      return (imoblizerStatus.value.state).toString();
    } else {
      imoblizerUnlockLoader.value = false;
      throw Exception('status code is ${response.statusCode}');
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
      required double extraMileCharges}) async {
    DateTime startDate = DateTime.parse((pickupTime).toString());
    DateTime endDate = DateTime.parse((dropTime).toString());
    final actualDifference = endDate.toUtc().difference(startDate.toUtc());

    int second = actualDifference.inSeconds;
    finalTralvelTime.value = "${actualDifference.inMinutes.toString()}";

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
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 70.kh,
              width: 250.kw,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
                  child:
                  SizedBox(child: Lottie.asset('assets/json/car_loader.json')),
                ),
                SizedBox(
                  width: 10.kw,
                ),
                Obx(
                      () => Text(
                    "${controller.lodingMsg.value}",
                    style: GoogleFonts.urbanist(fontSize: 16),
                  ),
                ),
              ]),
            )),
        child: Container(
          child: Obx(
                () => Stack(
              children: [
                Container(
                  height: 800.kh,
                  color: Colors.blue,
                  child: GoogleMap(
                    onMapCreated: (mapController) {
                      //  controller.mapCompleter.complete(mapController);
                    },
                    //  markers: controller.listOfMarker,
                    initialCameraPosition: CameraPosition(
                      target: controller.center,
                      zoom: 11.0,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(32, 32, 32, 0.54),
                          Color.fromRGBO(27, 27, 27, 0),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 50, 0, 0),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                controller.carBooking.value == true
                    ? carBooking(0.6)
                    : SizedBox(),
                controller.carInspection.value == true
                    ? carInspection(0.9)
                    : SizedBox(),
                controller.rideStart.value == true
                    ? rideStart(0.75)
                    : SizedBox(),
                controller.endrideInspection.value == true
                    ? endrideInspection(0.85)
                    : SizedBox(),
                controller.bookingPriceDetails.value == true
                    ? bookingPriceDetails(0.7)
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carBooking(double initialVal) {
    /*  if (!controller.checkTimer.value) controller.startTimer();*/
    /*  if (!Get.find<GlobalData>().checkTimer.value)
      Get.find<GlobalData>().startTimer();*/
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 600.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                          height: 2,
                          width: 100.kw,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 0),
                      child: Column(
                        children: [
                          Text("Free Waiting",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                                () => controller.loader.value == true
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                              //  "${controller.minute.value}:${controller.start.value}",
                                "${controller.instanceOfGlobalData.waitingRideTime.value}",
                                // "${Get.find<GlobalData>().minute.value}:${Get.find<GlobalData>().start.value}",
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.kh,
                                  color: controller.instanceOfGlobalData
                                      .extraWaiting.value ==
                                      true
                                      ? Colors.red
                                      : Colors.white,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 500.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25.kh,
                        ),
                        Obx(
                              () => CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                            "${controller.getBookingDetailsModel.value.data?.car?.images?[0]}",
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              height: 140.kh,
                              width: 260.kw,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 100.kh,
                                    width: 260.kw,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 100.kh,
                                    width: 260.kw,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                            height: 35.kh,
                            width: 165.kw,
                            decoration: BoxDecoration(
                              color: ColorUtil.kPrimary,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text("${controller.model}",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white,
                                    )))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/battery.svg"),
                                Obx(
                                      () => Text(
                                    "${controller.getBookingDetailsModel.value.data?.car?.fuelLevel} ${controller.getBookingDetailsModel.value.data?.car?.fuelType == "fule" ? "Liter" : "%"}",
                                    style: GoogleFonts.urbanist(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 35.kh,
                                width: 120.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.speed),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    Obx(
                                          () => SizedBox(
                                        width: 90.kw,
                                        child: Center(
                                          child: Text(
                                            "Mileage : ${controller.getBookingDetailsModel.value.data?.car?.mileage}",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF5F5F5F),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            InkWell(
                              onTap: () {
                                controller.openMap();
                              },
                              child: Container(
                                  height: 35.kh,
                                  width: 120.kw,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFF5F5F5F))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      SizedBox(
                                        width: 5.kh,
                                      ),
                                      Text(
                                        "Map view",
                                        style: GoogleFonts.urbanist(
                                          color: Color(0xFF5F5F5F),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10.kh,
                        ),

                        Obx(
                              () => controller.instanceOfGlobalData.loader.value ==
                              true
                              ? Center(
                            child: SizedBox(),
                          )
                              : ButtonDesign(
                              name: "Verify and Inspect",
                              onPressed: () {
                                //     controller.openMap();

                                /* controller
                                        .qrBarCodeScannerDialogPlugin.value
                                        .getScannedQrBarCode(
                                            context: context,
                                            onCode: (code) {
                                              controller.code.value =
                                                  code.toString();
                                              print("qr code: ${controller.code.value}");
                                              if (controller.code.value ==
                                                  Get.find<GetStorageService>().getQNR) {
                                                showMySnackbar(title: "Symbol Drive", msg: "Verified successfully");
                                                print("if qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");
                                                controller.carInspection.value = true;
                                              }
                                              else{
                                                showMySnackbar(title: "Error", msg: "You have not booked this car");
                                                print("else qr code: ${controller.code.value} || ${controller.instanceOfGlobalData.QNR.value}");


                                              }

                                            });*/
                                controller.carInspection.value = true;
                              }),
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: Obx(
                                () => controller
                                .instanceOfGlobalData.loader.value ==
                                true
                                ? Center(
                              child: SizedBox(
                                  width: 344.kw,
                                  height: 100.kh,
                                  child: Lottie.asset(
                                      'assets/json/car_loader.json')),
                            )
                                : OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.5,
                                    color: ColorUtil.kPrimary),
                              ),
                              label: Text('Cancel a trip',
                                  style: GoogleFonts.urbanist(
                                      color: ColorUtil.kPrimary)),
                              icon: SvgPicture.asset(
                                  "assets/icons/canclebuttonicon.svg"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        contentPadding:
                                        EdgeInsets.fromLTRB(
                                            0, 8.kh, 0, 0),
                                        content: Container(
                                          height: 100.kh,
                                          child: Column(children: [
                                            SizedBox(
                                              height: 20.kh,
                                            ),
                                            Text(
                                              "Are you sure want to cancel this ride?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.urbanist(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 20.kh),
                                            ),
                                          ]),
                                        ),
                                        actionsPadding: EdgeInsets.all(0),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 56.kh,
                                                    child: Center(
                                                      child: Text(
                                                        "No",
                                                        style: GoogleFonts
                                                            .urbanist(
                                                            color: ColorUtil
                                                                .kPrimary,
                                                            fontSize:
                                                            16.kh),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    controller
                                                        .cancelBooking()
                                                        .then((value) {
                                                      Get.offNamed(
                                                          Routes.HOME);
                                                    });

                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      color: ColorUtil
                                                          .kPrimary,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                          Radius.circular(
                                                              10)),
                                                    ),
                                                    height: 56.kh,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes, cancel ride",
                                                        style: GoogleFonts
                                                            .urbanist(
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            16.kh),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
              /*  Positioned(bottom: 0,
                //alignment: FractionalOffset.topCenter,
                child: Container(
                  child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }

  Widget carInspection(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 750.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                          height: 2,
                          width: 100.kw,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: GoogleFonts.urbanist(
                                // fontSize: 24.kh,
                                  color: ColorUtil.ZammaBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                controller.carInspection.value = false;
                                Scaffold.of(context).showBodyScrim(false, 0.0);
                              },
                              child: SvgPicture.asset("assets/icons/cross.svg",
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: Column(
                        children: [
                          Text("Free Waiting",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                                () => controller.loader.value == true
                                ? CircularProgressIndicator()
                                : Text(
                              "${controller.instanceOfGlobalData.waitingRideTime.value}",
                              // "${controller.instanceOfGlobalData.minute.value}:${controller.instanceOfGlobalData.start.value}",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.kh,
                                  color: controller.instanceOfGlobalData
                                      .extraWaiting.value ==
                                      true
                                      ? Colors.red
                                      : Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.kh),
                  height: 600.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.kh,
                        ),
                        Text(
                          "Click respective side of images",
                          style: GoogleFonts.urbanist(fontSize: 16.kh),
                        ),
                        SizedBox(
                          height: 24.kh,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                                  () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("front");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.frontHood.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Front Side",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  //838087
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                            Obx(
                                  () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("leftside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.leftSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Left Side",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                                  () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("rightside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.rightSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Right Side",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                            Obx(
                                  () => Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.pickFromCamera("backside");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 157.kh,
                                        width: 157.kw,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                controller.backSide.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10.kh),
                                      height: 35.kh,
                                      width: 100.kw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Color(0xFF5F5F5F))),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Back Side",
                                            style: GoogleFonts.urbanist(
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera.svg")),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 40.kh,
                        ),

                        Obx(
                              () => controller.instanceOfGlobalData.loader.value ==
                              true
                              ? Center(
                            child: SizedBox(
                                width: 200.kh,
                                height: 56.kh,
                                child: Lottie.asset(
                                    'assets/json/car_loader.json')),
                          )
                              : ButtonDesign(
                              name: "Done",
                              onPressed: () {
                                if (controller.frontImageStatus.value == 0 ||
                                    controller.leftImageStatus.value == 0 ||
                                    controller.rightImageStatus.value ==
                                        0 ||
                                    controller.backImageStatus == 0) {
                                  showMySnackbar(
                                      title: "Error",
                                      msg: "All image mandatory");
                                } else {
                                  controller.lodingMsg.value =
                                  "Uploading image";
                                  context.loaderOverlay.show();
                                  controller
                                      .uploadInspectionImage("S")
                                      .then((value) {
                                    if (value == 1) {
                                      controller
                                          .putImoblizerUnlock("unlocked")
                                          .then((value) {
                                        if (value != "locked") {
                                          Future.delayed(
                                              const Duration(seconds: 1),
                                                  () {
                                                context.loaderOverlay.hide();
                                                controller.rideStart.value =
                                                true;
                                                controller.carInspection.value =
                                                false;
                                              });
                                        } else {
                                          showMySnackbar(
                                              title: "Error",
                                              msg:
                                              "Error unlocking imoblizer");
                                        }
                                      });
                                    } else {
                                      showMySnackbar(
                                          title: "Error",
                                          msg: "Error while inspection");
                                    }
                                  });
                                }
                                //controller.rideStart.value = true;
                              }),
                        ),
                        SizedBox(
                          height: 10.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: Obx(
                                () => controller
                                .instanceOfGlobalData.loader.value ==
                                true
                                ? Center(
                              child: SizedBox(),
                            )
                                : OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.5,
                                    color: ColorUtil.kPrimary),
                              ),
                              label: Text('Cancel a trip',
                                  style: GoogleFonts.urbanist(
                                      color: ColorUtil.kPrimary)),
                              icon: SvgPicture.asset(
                                  "assets/icons/canclebuttonicon.svg"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        contentPadding:
                                        EdgeInsets.fromLTRB(
                                            0, 8.kh, 0, 0),
                                        content: Container(
                                          height: 100.kh,
                                          child: Column(children: [
                                            SizedBox(
                                              height: 20.kh,
                                            ),
                                            Text(
                                              "Are you sure want to cancel this ride?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.urbanist(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 20.kh),
                                            ),
                                          ]),
                                        ),
                                        actionsPadding: EdgeInsets.all(0),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 56.kh,
                                                    child: Center(
                                                      child: Text(
                                                        "No",
                                                        style: GoogleFonts
                                                            .urbanist(
                                                            color: ColorUtil
                                                                .kPrimary,
                                                            fontSize:
                                                            16.kh),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    controller
                                                        .cancelBooking()
                                                        .then((value) {
                                                      Get.offNamed(
                                                          Routes.HOME);
                                                    });

                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      color: ColorUtil
                                                          .kPrimary,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                          Radius.circular(
                                                              10)),
                                                    ),
                                                    height: 56.kh,
                                                    child: Center(
                                                      child: Text(
                                                        "Yes, cancel ride",
                                                        style: GoogleFonts
                                                            .urbanist(
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            16.kh),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
              /*  Positioned(bottom: 0,
                //alignment: FractionalOffset.topCenter,
                child: Container(
                  child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }

  Widget rideStart(double initialVal) {
    if (!controller.instanceOfGlobalData.checkRideTicker.value)
      controller.getOnGoingHistory();
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 0.75,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                height: 750.kh,
                decoration: BoxDecoration(
                  color: ColorUtil.kPrimary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                          height: 2,
                          width: 100.kw,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 0, 0),
                      child: Column(
                        children: [
                          Text("Ongoing Trip",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xFFB4BCE1))),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                                () => controller.loader.value == true
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                              "${controller.instanceOfGlobalData.rideTime.value}",
                              /* "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",*/
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.kh,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 650.kh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.kh,
                        ),
                        Obx(
                              () => CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                            "${controller.getBookingDetailsModel.value.data?.car?.images?[0]}",
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              height: 140.kh,
                              width: 260.kw,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 100.kh,
                                    width: 260.kw,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 100.kh,
                                    width: 260.kw,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 30.kh,
                        ),
                        Container(
                            height: 35.kh,
                            width: 165.kw,
                            decoration: BoxDecoration(
                              color: ColorUtil.kPrimary,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                                  "${controller.model}",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.white,
                                  ),
                                ))),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/battery.svg"),
                                Obx(
                                      () => Text(
                                    "${controller.getBookingDetailsModel.value.data?.car?.fuelLevel == null ? "0" :controller.getBookingDetailsModel.value.data?.car?.fuelLevel} ${controller.getBookingDetailsModel.value.data?.car?.fuelType == "fule" ? "Liter" : "%"}",
                                    style: GoogleFonts.urbanist(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/icons/pepole.svg"),
                                Text(
                                  "${controller.seatCapcity}",
                                  style: GoogleFonts.urbanist(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Obx(()=>controller.imoblizerUnlockLoader.value==true?SizedBox(
                            //     width: 40.kh,
                            //     height: 40.kh,
                            //     child: Lottie.asset(
                            //         'assets/json/car_loader.json')):
                            //    Column(
                            //     children: [
                            //       InkWell(onTap: (){
                            //         if(controller.imoblizerStatus.value.state=="locked"){
                            //           controller.putImoblizerUnlock("unlocked");
                            //         }else{
                            //           showMySnackbar(title: "Msg", msg: "Already Unlocked Imoblizer Lock");
                            //         }
                            //
                            //       },child: Icon(Icons.lock_open_outlined,color: controller.imoblizerStatus.value.state=="locked"?ColorUtil.kPrimary:ColorUtil.ZammaGrey,size: 44.kh)),
                            //     Text("Unlock \n Immobilizer",textAlign: TextAlign.center)
                            //     ],
                            //   ),
                            // ),
                            //   Obx(()=>controller.imoblizerLockLoader.value==true?SizedBox(
                            //       width: 40.kh,
                            //       height: 40.kh,
                            //       child: Lottie.asset(
                            //           'assets/json/car_loader.json')):
                            //       Column(
                            //       children: [
                            //          InkWell(onTap: (){
                            //            if(controller.imoblizerStatus.value.state=="locked"){
                            //              showMySnackbar(title: "Msg", msg: "Already Immobilizer");
                            //            }else{
                            //              controller.putImoblizerLock("locked");
                            //            }
                            //         },child: Icon(Icons.lock_outline,color: controller.imoblizerStatus.value.state=="locked"?ColorUtil.ZammaGrey:ColorUtil.kPrimary,size: 44.kh)),
                            //         Text("Lock \n Immobilizer",textAlign: TextAlign.center)
                            //       ],
                            //     ),
                            //   ),
                            Obx(
                                  () => controller.UnlockLoader.value == true
                                  ? SizedBox(
                                  width: 40.kh,
                                  height: 40.kh,
                                  child: Lottie.asset(
                                      'assets/json/car_loader.json'))
                                  : Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (controller
                                            .lockModel.value.state ==
                                            "locked") {
                                          controller
                                              .putUnlock("unlocked");
                                        } else {
                                          showMySnackbar(
                                              title: "Message",
                                              msg:
                                              "Already Unlocked Central Lock");
                                        }
                                      },
                                      child: Icon(
                                          Icons.lock_open_outlined,
                                          color: controller.lockModel
                                              .value.state ==
                                              "locked"
                                              ? ColorUtil.kPrimary
                                              : ColorUtil.ZammaGrey,
                                          size: 44.kh)),
                                  Text("Unlock Central \n Lock",
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                            Obx(
                                  () => controller.lockLoader.value == true
                                  ? SizedBox(
                                  width: 40.kh,
                                  height: 40.kh,
                                  child: Lottie.asset(
                                      'assets/json/car_loader.json'))
                                  : Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (controller
                                            .lockModel.value.state ==
                                            "locked") {
                                          showMySnackbar(
                                              title: "Message",
                                              msg:
                                              "Already locked Central Lock");
                                        } else {
                                          controller.putLock("locked");
                                        }
                                      },
                                      child: Icon(Icons.lock_outline,
                                          color: controller.lockModel
                                              .value.state ==
                                              "locked"
                                              ? ColorUtil.ZammaGrey
                                              : ColorUtil.kPrimary,
                                          size: 44.kh)),
                                  Text("Lock Central \n Lock",
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 35.kh,
                                width: 165.kw,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF5F5F5F))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/report.svg",
                                      color: Color(0xFF5F5F5F),
                                    ),
                                    SizedBox(
                                      width: 5.kh,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.REPORT_AN_ISSUE,
                                            arguments: [controller.bookingId]);
                                      },
                                      child: Text(
                                        "Report a problem",
                                        style: GoogleFonts.urbanist(
                                          color: Color(0xFF5F5F5F),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),

                        /* SizedBox(
                          height: 10.kh,
                        ),
                        ListTile(
                            leading: Text(
                              "Order Summary",
                              style: GoogleFonts.urbanist(fontSize: 16.kh),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios)),*/
                        SizedBox(
                          height: 20.kh,
                        ),

                        Obx(() => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Ride status :",
                              style: GoogleFonts.urbanist(
                                color: ColorUtil.kPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            controller.getBookingDetailsModel.value.data?.car
                                ?.ignition ==
                                "off"
                                ? Center(
                                child: Text(
                                  "Paused",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                                : Text(
                              "Driving",
                              style: GoogleFonts.urbanist(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ), // <-- Text
                          ],
                        ),
                        ),

                        SizedBox(
                          height: 20.kh,
                        ),
                        InkWell(
                          onTap: () {
                            controller.openMapRide();
                          },
                          child: Container(
                              height: 35.kh,
                              width: 120.kw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Color(0xFF5F5F5F))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map_outlined),
                                  SizedBox(
                                    width: 5.kh,
                                  ),
                                  Text(
                                    "Map view",
                                    style: GoogleFonts.urbanist(
                                      color: Color(0xFF5F5F5F),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 20.kh,
                        ),

                        SizedBox(
                          width: 344.kw,
                          height: 56.kh,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1.5, color: ColorUtil.kPrimary),
                            ),
                            label: Text('Complete the trip',
                                style: GoogleFonts.urbanist(
                                    color: ColorUtil.kPrimary)),
                            icon: SvgPicture.asset("assets/icons/complete.svg"),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(0, 8.kh, 0, 0),
                                      content: Container(
                                        height: 100.kh,
                                        child: Column(children: [
                                          SizedBox(
                                            height: 20.kh,
                                          ),
                                          Text(
                                            "Are you sure want to end this ride?",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.urbanist(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.kh),
                                          ),
                                        ]),
                                      ),
                                      actionsPadding: EdgeInsets.all(0),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 56.kh,
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style:
                                                      GoogleFonts.urbanist(
                                                          color: ColorUtil
                                                              .kPrimary,
                                                          fontSize: 16.kh),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  controller.endrideInspection
                                                      .value = true;
                                                  /* controller.onBoardingStatus.value=false;
                                        Get.find<GetStorageService>().deleteLocation();
                                        Get.find<TokenCreateGenrate>().signOut();*/
                                                  // controller.enrideInspection.value = true;
                                                  //  controller.rideStart.value = false;
                                                  /*  await controller
                                                      .LogoutAnDeleteEveryThing();*/

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorUtil.kPrimary,
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        bottomRight:
                                                        Radius.circular(
                                                            10)),
                                                  ),
                                                  height: 56.kh,
                                                  child: Center(
                                                    child: Text(
                                                      "Yes, End ride",
                                                      style:
                                                      GoogleFonts.urbanist(
                                                          color:
                                                          Colors.white,
                                                          fontSize: 16.kh),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        )
                        // SizedBox(
                        //   height: 10.kh,
                        // ),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget endrideInspection(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.8,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            Container(
              height: 650.kh,
              decoration: BoxDecoration(
                color: ColorUtil.kPrimary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                        height: 2,
                        width: 100.kw,
                        color: Colors.white,
                      )),
                  /*Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(offset:Offset(0,-50),
                            child: Text(
                              "",
                              style: GoogleFonts.urbanist(
                                // fontSize: 24.kh,
                                  color: ColorUtil.ZammaBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.endrideInspection.value = false;
                              Scaffold.of(context).showBodyScrim(false, 0.0);
                            },
                            child: Transform.translate(offset: Offset(0,-16),
                              child: SvgPicture.asset("assets/icons/cross.svg",
                                  color: Colors.white),
                            ),
                          ),
                        ]),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 34, 16, 0),
                    child: Column(
                      children: [
                        Text("Ongoing Trip",
                            style:
                            GoogleFonts.urbanist(color: Color(0xFFB4BCE1))),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                              () => Text(
                            "${controller.instanceOfGlobalData.rideTime.value}",
                            /*  "${controller.instanceOfGlobalData.ridehour.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridehour.value}" : controller.instanceOfGlobalData.ridehour.value}:${controller.instanceOfGlobalData.rideminute.value < 10 ? "0" + "${controller.instanceOfGlobalData.rideminute.value}" : controller.instanceOfGlobalData.rideminute.value}:${controller.instanceOfGlobalData.ridestart.value < 10 ? "0" + "${controller.instanceOfGlobalData.ridestart.value}" : controller.instanceOfGlobalData.ridestart.value}",*/
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.kh,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.kh),
                height: 550.kh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.kh,
                      ),
                      Text(
                        "Click respective side of images",
                        style: GoogleFonts.urbanist(fontSize: 16.kh),
                      ),
                      SizedBox(
                        height: 24.kh,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                                () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("front");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.frontHood.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Front Side",
                                          style: GoogleFonts.urbanist(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                          Obx(
                                () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("leftside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.leftSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Left Side",
                                          style: GoogleFonts.urbanist(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.kh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                                () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("rightside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.rightSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Right Side",
                                          style: GoogleFonts.urbanist(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                          Obx(
                                () => Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      controller.pickFromCamera("backside");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height: 157.kh,
                                      width: 157.kw,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              controller.backSide.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(10.kh),
                                    height: 35.kh,
                                    width: 100.kw,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Color(0xFF5F5F5F))),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Back Side",
                                          style: GoogleFonts.urbanist(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera.svg")),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40.kh,
                      ),

                      Obx(
                            () => controller.instanceOfGlobalData.loader.value ==
                            true
                            ? Center(
                          child: SizedBox(
                              width: 200.kh,
                              height: 56.kh,
                              child: Lottie.asset(
                                  'assets/json/car_loader.json')),
                        )
                            : ButtonDesign(
                            name: "Done",
                            onPressed: () {
                              if (controller.frontImageStatus.value == 0 ||
                                  controller.leftImageStatus.value == 0 ||
                                  controller.rightImageStatus.value == 0 ||
                                  controller.backImageStatus == 0) {
                                showMySnackbar(
                                    title: "Error",
                                    msg: "All image mandatory");
                              } else {
                                controller.lodingMsg.value =
                                "Updating central lock";
                                context.loaderOverlay.show();
                                controller
                                    .putAutoCentralLock("locked")
                                    .then((value) {
                                  if (value == "locked") {
                                    Future.delayed(
                                        const Duration(seconds: 1), () {
                                      controller.lodingMsg.value =
                                      "Updating immobilizer lock";
                                      controller
                                          .putImoblizerLock("locked")
                                          .then((value) {
                                        if (value == "locked") {
                                          Future.delayed(
                                              const Duration(seconds: 1),
                                                  () {
                                                controller.lodingMsg.value =
                                                "Uploading image";

                                                controller
                                                    .uploadInspectionImage("E")
                                                    .then((value) {
                                                  if (value == 1) {
                                                    controller
                                                        .bookingPriceDetails
                                                        .value = true;
                                                    controller.endrideInspection
                                                        .value = false;
                                                    controller.rideStart.value =
                                                    false;
                                                    context.loaderOverlay
                                                        .hide();
                                                    controller.carBooking
                                                        .value = false;
                                                  } else {
                                                    context.loaderOverlay
                                                        .hide();
                                                    showMySnackbar(
                                                        title: "Error",
                                                        msg:
                                                        "Error while inspection");
                                                  }
                                                });
                                              });
                                        } else {
                                          Future.delayed(
                                              const Duration(seconds: 1),
                                                  () {
                                                context.loaderOverlay.hide();
                                                showMySnackbar(
                                                    title: "Error",
                                                    msg:
                                                    "Error while updating immobilizer lock");
                                                controller.lodingMsg.value =
                                                "Analyzing your car";
                                              });
                                        }
                                      });
                                    });
                                  } else {
                                    Future.delayed(
                                        const Duration(seconds: 1), () {
                                      context.loaderOverlay.hide();
                                      showMySnackbar(
                                          title: "Error",
                                          msg:
                                          "Error while updating central lock");
                                      controller.lodingMsg.value =
                                      "Analyzing your car";
                                    });
                                  }
                                });
                              }
                              /*controller
                                          .putImoblizerLock("locked")
                                          .then((value) {
                                        if (value == "locked") {
                                          Future.delayed(
                                              const Duration(seconds: 1), () {
                                            context.loaderOverlay.hide();
                                            controller.bookingPriceDetails
                                                .value = true;
                                            controller.endrideInspection.value =
                                                false;
                                            controller.rideStart.value = false;
                                            controller.carBooking.value = false;
                                          });
                                        }
                                      });*/

                              // Get.toNamed(Routes.LOGIN);
                            }),
                      ),
                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
              ),
            ),
            /*  Positioned(bottom: 0,
              //alignment: FractionalOffset.topCenter,
              child: Container(
                child: ButtonDesignDeactive(name: "Register to see price", onPressed: () {}),
              ),
            ),*/
          ],
        );
      },
    );
  }

  Widget bookingPriceDetails(double initialVal) {
    return DraggableScrollableSheet(
      initialChildSize: initialVal,
      minChildSize: 0.7,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            Container(
              height: 800.kh,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                            height: 2,
                            width: 100.kw,
                            color: ColorUtil.kPrimary,
                          )),

                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Travel Time",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "${controller.finalTralvelTime.value} min",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      /* SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Milage",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "${controller.milage.value} ",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000) ,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),*/
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Distance",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "0 miles",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Paid Amount",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.paidAmount.value}",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.finalTotalAmount.value}",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Waiting Charges",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraWaitingCharge.value}",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Extra Travel Charges",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16.kh),
                            ),
                            Text(
                              "\$${controller.extraTravelTimeCharge.value}",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xff008000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.kh,
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(32.0.kh, 0, 32.0.kh, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total payble then ",
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.kh,
                              ),
                            ),
                            Text(
                              "\$${double.parse((controller.totalFare.value).toStringAsFixed(3))}",
                              style: GoogleFonts.urbanist(
                                  color: Color(0xffFF0000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.kh),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.kh,
                      ),
                      Center(
                        child: Obx(
                              () => controller.instanceOfGlobalData.loader.value ==
                              true
                              ? Center(
                            child: SizedBox(
                                width: 200.kh,
                                height: 100.kh,
                                child: Lottie.asset(
                                    'assets/json/car_loader.json')),
                          )
                              : Container(
                            child: ButtonDesign(
                                name: "Pay",
                                onPressed: () async {
                                  if ((controller.totalFare.value) > 0) {
                                    await controller
                                        .getTransationDetails();
                                    Get.toNamed(Routes.SAVED_CARDS,
                                        arguments: [
                                          controller.bookingId == ""
                                              ? controller.rideHistory
                                              .value.data![0]!.Id
                                              : controller.bookingId,
                                          "End",
                                          "",
                                          false,
                                          "${controller.bookingType.value}",
                                          double.parse(
                                              (controller.totalFare.value)
                                                  .toStringAsFixed(3)),
                                          (controller
                                              .finalDistanceTravel.value),
                                          (controller
                                              .finalTralvelTime.value)
                                        ]);
                                  } else {
                                    Get.offAllNamed(Routes.HOME);
                                    showMySnackbar(
                                        title: "Message",
                                        msg: "Payment Successful");
                                  }
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.kh,
                      ),

                      // SizedBox(
                      //   height: 10.kh,
                      // ),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
