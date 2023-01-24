import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Center(
          child: Image(width: double.infinity,
            image: AssetImage(
              "assets/images/splash.png",
            ),
            fit: BoxFit.cover,
          )),
    );
  }
}
