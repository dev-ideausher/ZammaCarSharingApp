import 'dart:io';

import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

class ImageHandler {
  static Future<void> getImage(
      {required bool fromGallery,
      required Function(File? file) pickedImage}) async {
    XFile? picker = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 20);
    if (picker != null) {
      pickedImage(File(picker.path));
      // imagePick = await cropSelectedImage(picker.path) ?? "";
    }
  }

  // static Future<String?> cropSelectedImage(String filePath) async {
  //   CroppedFile? file = await ImageCropper().cropImage(
  //     sourcePath: filePath,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: '',
  //         toolbarColor: Colors.transparent,
  //         toolbarWidgetColor: Colors.black,
  //         statusBarColor: Colors.transparent,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         activeControlsWidgetColor: HealicColors.primary,
  //         lockAspectRatio: false,
  //       ),
  //       IOSUiSettings(
  //         title: '',
  //       ),
  //     ],
  //   );
  //   return file?.path;
  // }
}
