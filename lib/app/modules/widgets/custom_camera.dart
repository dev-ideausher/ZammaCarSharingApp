import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/modules/widgets/overlay_camera.dart';

class GenralCamera {
 static openCamera({required Function(File file) onCapture}) {
    Get.bottomSheet(
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: GoogleFonts.urbanist(color: Colors.black),
                      ));
                }

                return CameraOverlay(
                      (file) {
                    if (Get.isBottomSheetOpen!) {
                      Get.until((route) => !Get.isBottomSheetOpen!);
                    }
                    onCapture(file);
                  },
                  controller: CameraController(
                    snapshot.data![0],
                    ResolutionPreset.low,
                    enableAudio: false,
                  ),
                );
              } else {
                return  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fetching cameras',
                      style: GoogleFonts.urbanist(color: Colors.black),
                    ));
              }
            },
          ),
        ),
        isScrollControlled: true);
  }
}