import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/otp_used_class.dart';
import 'package:zammacarsharing/app/services/storage.dart';

class GlobalData extends GetxService {
  Rx<bool> isloginStatusGlobal = false.obs;
  Rx<bool> loader = false.obs;
  final userId = "".obs;
  final QNR = "".obs;
  final instanceOfOtpNeededData = OtpNeededData().obs;

  @override
  void onInit() {
    super.onInit();
    isloginStatusGlobal.value = Get.find<GetStorageService>().getisLoggedIn;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late Timer timer;
  var start = 60.obs;
  RxBool checkTimer = false.obs;
  var minute = 14.obs;

  void startTimer() {
    checkTimer.value = true;
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
  RxBool checkRideTimer = false.obs;

  void rideTimer() {
    checkRideTimer.value = true;
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
        } else {
          ridestart++;
        }
      },
    );
  }

  timeCalculationInProgress({required String baseTime}) {
    try {
      TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal())
          .format(Get.context!);

      DateTime date = DateFormat.jm().parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");

      DateTime startDate = DateFormat("hh:mm a").parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");

      //current Date Time
      DateTime now = DateTime.now();

      DateTime endDate = DateFormat("hh:mm a").parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(DateTime.now().toString()).toLocal()).format(Get.context!)}");

      //Calculate Difference
      final actualDifference = endDate.difference(startDate);
      int hour = actualDifference.inHours;
      int minutee = actualDifference.inMinutes;
      int second = actualDifference.inSeconds;

      minute.value = 14 - (actualDifference.inMinutes);
      start.value = 59;
    } catch (e) {
      throw "Error while Time Calculation";
    }
  }

  timeCalculationOngoing({required String baseTime}) {
    try {
      print("timeCalculationOngoing input : ${baseTime}");

      TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal())
          .format(Get.context!);

      DateTime date = DateFormat.jm().parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");

      DateTime startDate = DateFormat("hh:mm a").parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");

      //current Date Time
      DateTime now = DateTime.now();

      DateTime endDate = DateFormat("hh:mm a").parse(
          "${TimeOfDay.fromDateTime(DateTime.parse(DateTime.now().toString()).toLocal()).format(Get.context!)}");

      //Calculate Difference
      final actualDifference = endDate.difference(startDate);
      int hour = actualDifference.inHours;
      int minutee = actualDifference.inMinutes;
      int second = actualDifference.inSeconds;

      //Calculation
      if (hour.abs() >= 1) {
        final finalhour = ((second / 60) / 60);
        final a = finalhour.toString().split('.'); // here a = 6026
        print("Hour value : ${a[0]}");
        final hourvalue = int.parse(a[0]).abs();
        final secondvalue = second.abs() - ((hourvalue * 60) * 60);
        final finalminutevalue = secondvalue / 60;
        final b = finalminutevalue.toString().split('.');
        print("minute value : ${b[0]}");
        final minutevalue = int.parse(b[0]).abs();
        final finalSecondValue = secondvalue - (minutevalue * 60);
        print("Second value : ${finalSecondValue}");
        ridehour.value = hourvalue;
        rideminute.value = minutevalue;
        ridestart.value = finalSecondValue;
      } else if (minutee >= 1) {
        final finalminutevalue = second / 60;
        final b = finalminutevalue.toString().split('.');
        print("minute value : ${b[0]}");
        final minutevalue = int.parse(b[0]).abs();
        final finalSecondValue = second - (minutevalue * 60);
        print("Second value : ${finalSecondValue}");
        rideminute.value = minutevalue;
        ridestart.value = finalSecondValue;
      } else {
        ridestart.value = second;
      }
    } catch (e) {
      throw "Error while Time Calculation";
    }
  }

  RxBool checkRideTicker = false.obs;
  RxBool checkWaitRideTicker = false.obs;
  late Timer rideTicker;
  var rideTime = "".obs;
  late Timer waitingRideTicker;
  var waitingRideTime = "".obs;
  var waitHour = 0.obs;
  var waitMinute = 0.obs;
  var waitSecond = 0.obs;
  RxBool extraWaiting = false.obs;
  RxInt totalWaiting = 0.obs;
  RxInt aditionalWaiting = 0.obs;

  String secondToFormatted(int tick) {
    Duration duration = Duration(seconds: tick);

    String twoDigits(int n) => n.toString().padLeft(2, "0");

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));

    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void lastStampToseconds({required DateTime startTime}) {
    if (checkWaitRideTicker.value == true) {
      checkWaitRideTicker.value = false;
      waitingRideTicker.cancel();
    }

    waitingRideTime.value = "";
    checkRideTicker.value = true;

    rideTicker = Timer.periodic(Duration(seconds: 1), (val) {
      rideTime.value = secondToFormatted(
          DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds);
      print("Ticker : ${rideTime.value}");
    });
  }

  String waitingSecondToFormatted(int tick) {
    Duration duration = Duration(seconds: tick);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    print("twoDigits(duration.inHours) :${twoDigits(duration.inHours)}");
    waitHour.value = int.parse(twoDigits(duration.inHours));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    waitMinute.value = int.parse(twoDigitMinutes);
    print("twoDigitMinutes :${twoDigitMinutes}");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    waitSecond.value = int.parse(twoDigitSeconds);
    print("twoDigitSeconds :${twoDigitSeconds}");

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void waitingLastStampToseconds({required DateTime startTime}) {
    //waitingRideTicker.cancel();
    /*   rideTime.value = secondToFormatted(
        DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds);*/
    checkWaitRideTicker.value = true;
    waitingRideTicker = Timer.periodic(const Duration(seconds: 1), (val) {
      if ((DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds) >=
          900) {
        waitingRideTime.value = waitingSecondToFormatted(
            (DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds) -
                900);
        extraWaiting.value = true;
        totalWaiting.value =
            (DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds);
        aditionalWaiting.value =
            (DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds) -
                900;
        print("Ticker : ${waitingRideTime.value}");
      } else {
        waitingRideTime.value = waitingSecondToFormatted(900 -
            (DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds));
        extraWaiting.value = false;
        totalWaiting.value =
            (DateTime.now().toUtc().difference(startTime.toUtc()).inSeconds);
        aditionalWaiting.value = 0;
        print("Ticker : ${waitingRideTime.value}");
      }
    });
  }
}
