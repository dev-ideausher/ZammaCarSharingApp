import 'package:get/get.dart';
import 'package:zammacarsharing/app/modules/booking/controllers/booking_controller.dart';
import 'package:zammacarsharing/app/modules/home/controllers/home_controller.dart';
import 'package:zammacarsharing/app/modules/profile/controllers/profile_controller.dart';
import 'package:zammacarsharing/app/modules/settings/controllers/settings_controller.dart';
import 'package:zammacarsharing/app/services/globalData.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<GlobalData>(
          () => GlobalData(),
    );
    Get.lazyPut<SettingsController>(
          () => SettingsController(),fenix: true
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),fenix: true
    );
    Get.lazyPut<BookingController>(
            () => BookingController(),fenix: true
    );

  }
}
