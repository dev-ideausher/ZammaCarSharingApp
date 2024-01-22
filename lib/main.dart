import 'package:firebase_core/firebase_core.dart';
import 'package:zammacarsharing/app/modules/splash/bindings/splash_binding.dart';
import 'package:zammacarsharing/app/services/FirebaseMessagingUtils.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/super_controller.dart';
import 'package:zammacarsharing/app/services/tokenCreatorAndValidator.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth.dart';
import 'app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: ColorUtil.kPrimary, // status bar color
        statusBarBrightness: Brightness.light),
  );


  await initGetServices();
  Get.lazyPut(() => Auth());
  Get.put(UserStatusController());

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await FirebaseMessagingUtils.firebaseMessagingUtils.initFirebaseMessaging();
  return runApp(GetMaterialApp(
    defaultTransition: Transition.fade,
    smartManagement: SmartManagement.full,
    debugShowCheckedModeBanner: false,
    title: "Ticket Checker",
    initialRoute: AppPages.INITIAL,
    initialBinding: SplashBinding(),
    getPages: AppPages.routes,
  ));
}

Future<void> initGetServices() async {

  await  Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  Get.lazyPut<TokenCreateGenrate>(() => TokenCreateGenrate());
  await  Get.put<TokenCreateGenrate>(TokenCreateGenrate());

}
