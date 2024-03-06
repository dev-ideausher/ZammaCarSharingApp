import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/ride_history_model.dart';
import 'package:zammacarsharing/app/modules/models/routes_models.dart';
import 'package:zammacarsharing/app/modules/models/saved_cards_model.dart';
import 'package:zammacarsharing/app/modules/models/transationdetails_model.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/crypto.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';

class CompletedRideDetailsController extends GetxController {
  //TODO: Implement CompletedRideDetailsController

  LatLng center = LatLng(45.521563, -122.677433);
  Rx<TransactionDetails> transactionDetails = TransactionDetails().obs;
  Rx<savedCardsModel> savedCardsresponse = savedCardsModel().obs;
  Rx<BookingRoutesModel> bookingRoutesModel = BookingRoutesModel().obs;

  RxDouble totalAmount = 0.0.obs;
  RxDouble firstPayment = 0.0.obs;
  RxDouble secondPayment = 0.0.obs;
  RxList cardList = [].obs;
  RxString carNumber = "XXXX XXXX XXXX XXXX".obs;
  Rx<RideHistory> rideHistory = RideHistory().obs;
  RxString pickupTimeConverted = "".obs;
  RxString dropTimeConverted = "".obs;
  RxString pickupAddress = "".obs;
  RxString dropAddress = "".obs;
  RxString durationOfRide = "".obs;
  RxString carModel = "".obs;
  final Completer<GoogleMapController> mapCompleter = Completer();
  // final RxSet<Polyline> polyline = {}.obs;
  RxSet<Polyline> polyline = Set<Polyline>().obs;
  RxBool loader = false.obs;
  // Data Coming From RideHistory Controller
  final bookingId = Get.arguments[0];
  final model = Get.arguments[1];
  final date = Get.arguments[2];
  final index = Get.arguments[3];

  @override
  void onInit() {
    super.onInit();
    getrideHistory();
    getTransationDetails();
    getBooking();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getBooking() async {
    try {
      final response = await APIManager.getBooking(bookingid: bookingId);
      bookingRoutesModel.value =
          BookingRoutesModel.fromJson(jsonDecode(response.toString()));
      List<LatLng> latlngSegment1 = [];
      for (int i = 0;
          i < ((bookingRoutesModel.value.data?.path)!.length);
          i++) {
        latlngSegment1.add(LatLng(
            double.parse(
                (bookingRoutesModel.value.data?.path?[i]?[0]).toString()),
            double.parse(
                (bookingRoutesModel.value.data?.path?[i]?[1]).toString())));
        print("path $i ${bookingRoutesModel.value.data?.path?[i]?[0]}");
        print("path $i ${bookingRoutesModel.value.data?.path?[i]?[1]}");
      }
      center = LatLng(latlngSegment1[0].latitude, latlngSegment1[0].longitude);
      polyline.value.add(Polyline(
          polylineId: PolylineId('line1'),
          visible: true,
          //latlng is List<LatLng>
          points: latlngSegment1,
          width: 4,
          color: ColorUtil.kPrimary));
      polyline.refresh();
      mapanimate();
    } catch (e) {}
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

  getTransationDetails() async {
    try {
      final response = await APIManager.getPaymentHistory(bookingid: bookingId);
      transactionDetails.value =
          TransactionDetails.fromJson(jsonDecode(response.toString()));

      for (int i = 0;
          i < transactionDetails.value.bookingTransactions!.length;
          i++) {
        if (i == 0) {
          firstPayment.value = (transactionDetails
                  .value.bookingTransactions?[i]?.totalPaidForBooking)!
              .toDouble();
          totalAmount.value = totalAmount.value + firstPayment.value;
          getCardDetails((transactionDetails.value.bookingTransactions?[0]
                  ?.stripePaymentDetail?.paymentMethod)
              .toString());
        }
        if (i == 1) {
          secondPayment.value = (transactionDetails
                  .value.bookingTransactions?[i]?.totalPaidForBooking)!
              .toDouble();
          totalAmount.value = totalAmount.value + secondPayment.value;
        }
      }
      print("");
    } catch (e) {}
  }

  getCardDetails(String cardId) async {
    try {
      final response = await APIManager.getSavedCards();
      savedCardsresponse.value = savedCardsModel.fromJson(
        jsonDecode(
          response.toString(),
        ),
      );

      savedCardsresponse.value.cards?.forEach((element) {
        if (element?.stripeCardId == cardId) {
          var mData = json
              .decode(decryptAESCryptoJS(element!.encryptedCode.toString()));
          carNumber.value = mData['card_number'];
        }
      });
    } catch (e) {}
  }

  getrideHistory() async {
    try {
      loader.value = true;
      final response = await APIManager.getfinalRideHistory();
      rideHistory.value = RideHistory.fromJson(jsonDecode(response.toString()));
      carModel.value = (rideHistory.value.data?[0]?.car?.model).toString();
      // pickupAddress.value =
      //     (rideHistory.value.data?[index]?.pickupLocation?.address).toString();
      double plat = double.parse(
          "${rideHistory.value.data?[index]?.pickupLocation?.coordinates?[1]}");
      double plng = double.parse(
          "${rideHistory.value.data?[index]?.pickupLocation?.coordinates?[0]}");
      getAddressFromLatLng(plat, plng, "pick");
      //dropAddress.value=(rideHistory.value.data?[index]?.dropLocation?.address).toString();
      double lat = double.parse(
          "${rideHistory.value.data?[index]?.dropLocation?.coordinates?[1]}");
      double lng = double.parse(
          "${rideHistory.value.data?[index]?.dropLocation?.coordinates?[0]}");
      getAddressFromLatLng(lat, lng, "drop");
      convertPickupDateTime(
          pickupTime: (rideHistory.value.data?[index]?.pickupTime).toString(),
          droptime: (rideHistory.value.data?[index]?.dropTime).toString());

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  getAddressFromLatLng(lat, lng, key) async {
    placemarkFromCoordinates(lat, lng).then((List<Placemark> placemarks) async {
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
      if (key == "pick") {
        pickupAddress.value =
            "${place.street}, ${place.subLocality},${place.administrativeArea}, ${place.postalCode} ";
        final body = {"pickupAddress": pickupAddress.value, "dropAddress": ""};
        final response2 =
            await APIManager.updateAddress(bookingId: bookingId, body: body);
      }
      if (key == "drop") {
        dropAddress.value =
            "${place.street}, ${place.subLocality},${place.administrativeArea}, ${place.postalCode} ";
        final body = {"pickupAddress": "", "dropAddress": dropAddress.value};
        final response2 =
            await APIManager.updateAddress(bookingId: bookingId, body: body);
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  convertPickupDateTime(
      {required String pickupTime, required String droptime}) {
    print(
        "Date Time Format : ${TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}");
    DateTime startDate = DateFormat("hh:mm a").parse(
        TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal())
            .format(Get.context!));
    DateTime endDate = DateFormat("hh:mm a").parse(
        TimeOfDay.fromDateTime(DateTime.parse(droptime).toLocal())
            .format(Get.context!));
    final actualDifference = endDate.difference(startDate);
    durationOfRide.value = (actualDifference.inMinutes).toString();
    // return outputDate;
    // DateTime timeFormat = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
    pickupTimeConverted.value =
        "${TimeOfDay.fromDateTime(DateTime.parse(pickupTime).toLocal()).format(Get.context!)}";
    dropTimeConverted.value =
        "${TimeOfDay.fromDateTime(DateTime.parse(droptime).toLocal()).format(Get.context!)}";
  }
}
