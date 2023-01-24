import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/colors.dart';

snackBarFunction(String msg) {
    return  Get.snackbar("Error", msg, backgroundColor: ColorUtil.kPrimary, colorText: Colors.white,);
}

