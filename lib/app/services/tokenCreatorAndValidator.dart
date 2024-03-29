import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/storage.dart';


FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class TokenCreateGenrate extends GetxService{
  var mytoken = ''.obs;

  //generate firebase token if expired then again generate
  Future<void> validateCreatetoken(User user) async {
    bool hasExpired = true;

    while (hasExpired) {
      Get.find<GlobalData>().loader.value = false;
      mytoken.value = "${await firebaseAuth.currentUser!.getIdToken()}";
      // generate token
      try{
        await Future.delayed(Duration(milliseconds: 200));
        hasExpired = JwtDecoder.isExpired(mytoken.value);
        Get.find<GetStorageService>().jwToken = mytoken.value;
        Get.find<GetStorageService>().setUserId = user.uid;
        print("userid : ${user.uid}");
        print("coustomUserId : ${Get.find<GetStorageService>().getCustomUserId}");

        //Get.find<GetStorageService>().setisLoggedIn=true;

        log("${Get.find<GetStorageService>().jwToken}");

      }catch(e){
        Get.find<GlobalData>().loader.value = false;

        print(e);
      }

    }
  }


}