import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/colors.dart';

void showMySnackbar({required String title, required String msg}) {
  Get.isSnackbarOpen == true
      ? null
      : Get.snackbar(
          title,
          msg,
          duration: const Duration(milliseconds: 2000),
          backgroundColor: ColorUtil.kPrimary, colorText: Colors.white,
        );
}
