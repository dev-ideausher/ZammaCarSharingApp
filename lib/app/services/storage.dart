import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class GetStorageService extends GetxService {


  static final jwtToken = GetStorage('JWT');
  static final LoginStorage = GetStorage('LOGIN');
  static final UserId = GetStorage('USERID');
  static final CustomUserId = GetStorage('CUSTOM_USERID');
  static final carQNR = GetStorage('QNR');

  static final booking = GetStorage('BOOKING');



  String get jwToken => jwtToken.read('TOKEN') ?? "";
  set jwToken(String value) => jwtToken.write('TOKEN', value);


  bool get getisLoggedIn => LoginStorage.read('LOGGEDIN') ?? false;
  set setisLoggedIn(bool value) => LoginStorage.write('LOGGEDIN', value);

  String get getUserId => LoginStorage.read('USERID') ?? "";
  set setUserId(String value) => LoginStorage.write('USERID', value);

  String get getCustomUserId => LoginStorage.read('CUSTOM_USERID') ?? "";
  set setCustomUserId(String value) => LoginStorage.write('CUSTOM_USERID', value);

  String get getQNR => carQNR.read('QNR') ?? "";
  set setQNR(String value) => carQNR.write('QNR', value);

  bool get setup => LoginStorage.read('SETUP') ?? false;
  set setup(bool value) => LoginStorage.write('SETUP', value);


  String get bookedCarID => booking.read('BOOKEDCARDID') ?? "";
  set bookedCarID(String value) => booking.write('BOOKEDCARDID', value);

  void deleteLocation() {
    jwtToken.remove('TOKEN');
    LoginStorage.remove('LOGGEDIN');
    UserId.remove('USERID');
    UserId.remove('CUSTOM_USERID');
    carQNR.remove('QNR');
    print("DELETED");
  }


  void deleteBooking() {
    jwtToken.remove('BOOKING');

    print("DELETED");
  }


  Future<GetStorageService> initState() async {
    log("Storage class : ${jwToken}");
    await GetStorage.init('JWT');
    await GetStorage.init('LOGIN');
    await GetStorage.init('USERID');
    await GetStorage.init('CUSTOM_USERID');
    await GetStorage.init('QNR');
    return this;
  }



}