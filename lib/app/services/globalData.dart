import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:zammacarsharing/app/modules/models/otp_used_class.dart';
import 'package:zammacarsharing/app/services/storage.dart';

class GlobalData extends GetxService{
Rx<bool> isloginStatusGlobal=false.obs;
Rx<bool> loader=false.obs;
final userId="".obs;
final QNR="".obs;
final instanceOfOtpNeededData=OtpNeededData().obs;
  @override
  void onInit() {
    super.onInit();
    isloginStatusGlobal.value=Get.find<GetStorageService>().getisLoggedIn;
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

timeCalculationInProgress({required String baseTime}){
  try{
    // var inputFormat =  DateFormat('yyyy-MM-DDTHH:mm:ss.sssZ');
    // var inputDate = inputFormat.parse("2023-02-13T08:27:17.805Z");
  //  inputDate = inputDate.toLocal();
    TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!);
    /// outputFormat - convert into format you want to show.
    //var outputFormat =  DateFormat('hh:mm a');
  //  var outputDate = outputFormat.format(inputDate);
    print("Date Time Format : ${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
     DateTime date= DateFormat.jm().parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
    print(DateFormat("HH").format(date));
    print(DateFormat("mm").format(date));
    print(DateFormat("ss").format(date));

    DateTime startDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");


    //current Date Time
    DateTime now = DateTime.now();
    print("hour ${now.hour} minute ${now.minute} second ${now.second}");

    DateTime endDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(DateTime.now().toString()).toLocal()).format(Get.context!)}");
    print("differenceActual ${endDate.difference(startDate)}");
     final actualDifference=endDate.difference(startDate);
    //Calculate Difference
    int hour = actualDifference.inHours;
    int minutee = actualDifference.inMinutes;
    int second = actualDifference.inSeconds;

    //Calculation

   //magnitude of a value
   //  print("hour magnitude value :  ${actualDifference.abs().inMinutes/24}");
   //  print("magnitude value :  ${minutee.abs()}");
   //  print("magnitude value :  ${actualDifference.inSeconds.abs()%60}");


      minute.value= 14-(actualDifference.inMinutes);
      start.value=59;



    //set time value
    // start.value=second.abs();
    // minute.value=minutee.abs();


  }catch(e){
    throw "Error while Time Calculation";
  }
}

timeCalculationOngoing({required String baseTime}){
  try{
    print("timeCalculationOngoing input : ${baseTime}");
    // var inputFormat =  DateFormat('yyyy-MM-DDTHH:mm:ss.sssZ');
    // var inputDate = inputFormat.parse("2023-02-13T08:27:17.805Z");
    //  inputDate = inputDate.toLocal();
    TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!);
    /// outputFormat - convert into format you want to show.
    //var outputFormat =  DateFormat('hh:mm a');
    //  var outputDate = outputFormat.format(inputDate);
    print("Date Time Format : ${TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
    DateTime date= DateFormat.jm().parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");
    print(DateFormat("HH").format(date));
    print(DateFormat("mm").format(date));
    print(DateFormat("ss").format(date));

    DateTime startDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(baseTime).toLocal()).format(Get.context!)}");


    //current Date Time
    DateTime now = DateTime.now();
    print("hour ${now.hour} minute ${now.minute} second ${now.second}");

    DateTime endDate = DateFormat("hh:mm a").parse("${ TimeOfDay.fromDateTime(DateTime.parse(DateTime.now().toString()).toLocal()).format(Get.context!)}");
    print("differenceActual ${endDate.difference(startDate)}");
    final actualDifference=endDate.difference(startDate);

    //Calculate Difference
    int hour = actualDifference.inHours;
    int minutee = actualDifference.inMinutes;
    int second = actualDifference.inSeconds;
    print("inHours : ${hour}");
    print("inMinutes : ${minutee}");
    print("inSeconds : ${second}");

    //Calculation
    if(hour.abs()>=1){
      final finalhour=((second/60)/60);
       final a = finalhour.toString().split('.'); // here a = 6026
      print("Hour value : ${a[0]}");
      final hourvalue=int.parse(a[0]).abs();
      final secondvalue=second.abs()-((hourvalue*60)*60);
     final  finalminutevalue=secondvalue/60;
      final b = finalminutevalue.toString().split('.');
      print("minute value : ${b[0]}");
      final minutevalue=int.parse(b[0]).abs();
      final finalSecondValue=secondvalue-(minutevalue*60);
      print("Second value : ${finalSecondValue}");
      ridehour.value=hourvalue;
      rideminute.value=minutevalue;
      ridestart.value=finalSecondValue;

    }
    else if(minutee>=1){
      final  finalminutevalue=second/60;
      final b = finalminutevalue.toString().split('.');
      print("minute value : ${b[0]}");
      final minutevalue=int.parse(b[0]).abs();
      final finalSecondValue=second-(minutevalue*60);
      print("Second value : ${finalSecondValue}");
      rideminute.value=minutevalue;
      ridestart.value=finalSecondValue;
    }
    else{
      ridestart.value=second;
    }


  }catch(e){
    throw "Error while Time Calculation";
  }
}
}