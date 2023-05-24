import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraDesignController extends GetxController {
  //TODO: Implement CameraDesignController

   List<CameraDescription>? _cameras;
   CameraController? controllerr;
  @override
  Future<void> onInit() async {
    print("check when camera call");
    _cameras = await availableCameras();

    controllerr = CameraController(_cameras![0], ResolutionPreset.max);
    controllerr?.initialize().then((_) {

    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
