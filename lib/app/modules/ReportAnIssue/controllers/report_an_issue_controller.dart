import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/widgets/custom_camera.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/image_handler.dart';
import 'package:path/path.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:http/http.dart' as http;

class ReportAnIssueController extends GetxController {
  //TODO: Implement ReportAnIssueController

  RxString filename = "Add Image".obs;
  RxString selectedFile = "".obs;
  final instanceOfGlobalData = Get.find<GlobalData>();
  Rx<ImageUpload> imageUpload = ImageUpload().obs;
  Rx<TextEditingController> textEditingController=TextEditingController().obs;
  final bookingId=Get.arguments[0];
  var issuepic = File("").obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  Future<void> pickFromCamera() async {
    // final ImagePicker picker = ImagePicker();
    // print("pickedImage path before ${frontHood.value.path}");

    /* final picker = ImagePicker();
    PickedFile? pickedImage;
    pickedImage = await picker.getImage(source: ImageSource.camera);*/
    GenralCamera.openCamera(onCapture: (pickedImage) {
      if (pickedImage != null) {

          issuepic.value = pickedImage;
          selectedFile.value=issuepic.value.path;
          String basenamed = basename(issuepic.value.path);
          filename.value = basenamed;


      }
    });
    //  File pickedImage= await takePhoto();

    /*   try {
      await ImageHandler.getImage(fromGallery: false, pickedImage: (file){
        if(file!=null){
          if (selectedSideFoto == "front") {
            frontImageStatus.value = 1;
            frontHood.value = file;
          }
          else if (selectedSideFoto == "leftside") {
            leftImageStatus.value = 1;
            leftSide.value =file;
          }
          else if (selectedSideFoto == "rightside") {
            rightImageStatus.value = 1;
            rightSide.value = file;
          }
          else {
            backImageStatus.value = 1;
            backSide.value = file;
          }


          print("pickedImage path after ${frontHood.value.path}");
        }else{
          print("image not picked");
        }
      });
     // final XFile? image = await picker.pickImage(source: ImageSource.camera);

    } catch (e) {
      throw Exception(e);
    }*/
  }
  /*Future<void> pickFromCamera() async {
    final ImagePicker picker = ImagePicker();
    //print("pickedImage path before ${frontHood.value.path}");
    try {
      await ImageHandler.getImage(
          fromGallery: true,

          pickedImage: (file) {
            String basenamed = basename(file!.path);
            selectedFile.value = file.path;
            filename.value = basenamed;
            print("base name : $basenamed");
          });
      // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      throw Exception(e);
    }
  }*/

  Future<dynamic> uploadImage(String path) async {
    String token = Get.find<GetStorageService>().jwToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.imapgeUpload),
    );
    request.fields.addAll({'type': 'userProfile'});
    var headers = {'accept': 'application/json', 'token': token};
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var value = await response.stream.bytesToString();
      print("statusssssss ::  ${value}");
      // var value=jsonDecode(response.);
      return jsonDecode(value);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> uploadIssue() async {


      try  {
        //instanceOfGlobalData.loader.value = true;
               if(selectedFile.value!="Add Image") {
                 instanceOfGlobalData.loader.value = false;
                 var response = await uploadImage(selectedFile.value);
                 imageUpload.value = ImageUpload.fromJson(response);
                 //carsImage.add(imageUpload.value.urls?[0]);
               }
               var body={
                 "issue":"Raised issue",
                 "bookingId":bookingId,
                 "image":(selectedFile.value!="Add Image")?(imageUpload.value.urls?[0]).toString():"",
                 "desc":textEditingController.value.text
               };
        final response = await APIManager.ReportAnIssue(body: body);
     if(response.statusCode==200){
       Get.back();
     }
      } catch (e) {

      //  instanceOfGlobalData.loader.value = false;
        print("problem while reporing issue");

      }


    }

}
