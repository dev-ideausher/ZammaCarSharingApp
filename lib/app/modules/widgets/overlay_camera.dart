// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

class CameraOverlay extends StatefulWidget {
  const CameraOverlay(
    // this.model,
    this.onCapture, {
    Key? key,
    this.flash = false,
    this.enableCaptureButton = true,
    this.customWidget,
    required this.controller,
    this.loadingWidget,
    this.infoMargin,
  }) : super(key: key);

  // final OverlayModel model;
  final bool flash;
  final CameraController controller;
  final bool enableCaptureButton;
  final Function(File file) onCapture;
  final Widget? loadingWidget;
  final Widget? customWidget;
  final EdgeInsets? infoMargin;

  @override
  _FlutterCameraOverlayState createState() => _FlutterCameraOverlayState();
}

class _FlutterCameraOverlayState extends State<CameraOverlay> {
  _FlutterCameraOverlayState();

  late CameraController controller;

  @override
  void initState() {
    super.initState();
    cameraSetup();
  }

  void cameraSetup() {
    controller = widget.controller;

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = widget.loadingWidget ??
        Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: const Align(
            alignment: Alignment.center,
            child: Text('loading camera'),
          ),
        );

    if (!controller.value.isInitialized) {
      return loadingWidget;
    }

    controller
        .setFlashMode(widget.flash == true ? FlashMode.auto : FlashMode.off);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3.kw,
            ),
          ),
          margin: const EdgeInsets.all(40),
          child: InkWell(
            onTap: () async {
              // for (int i = 10; i > 0; i--) {
              //   await HapticFeedback.vibrate();
              // }
              try {
                XFile file = await controller.takePicture();
                widget.onCapture(File(file.path));
              } catch (e) {
                print("${e}");
              }

              //  file.saveTo(file.path);
            },
            child: CircleAvatar(
              radius: 25.kh,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          CameraPreview(controller),
        ],
      ),
    );
  }
}
