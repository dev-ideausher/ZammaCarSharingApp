import 'package:get/get.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController


  @override
  void onInit() {
    super.onInit();
    onPageLoad();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onPageLoad()async{



    await Future.delayed(Duration(seconds: 3), () async{

      Get.offAllNamed(Routes.HOME);

    });
  }
}
