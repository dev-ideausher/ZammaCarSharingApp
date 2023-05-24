import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/modules/profile/controllers/profile_controller.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:http/http.dart' as http;

class InsuranceVerificationController extends GetxController {
  //TODO: Implement InsuranceVerificationController
  Rx<TextEditingController> insuranceController=TextEditingController().obs;
  Rx<TextEditingController> dateController=TextEditingController().obs;
  Rx<TextEditingController> monthController=TextEditingController().obs;
  Rx<TextEditingController> yearController=TextEditingController().obs;

  final instanceOfLoginData =
      Get.find<ProfileController>().logindetails.value.user?.insurance;
  final instanceOfGlobalData=Get.find<GlobalData>();
  Rx<logedInDetails> logindetails = logedInDetails().obs;
  var pickedImage = File("").obs;
  final profilestatus = 0.obs;
  final imageUpload = ImageUpload().obs;
  @override
  void onInit() {
    super.onInit();
    valueSetup();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  valueSetup() {
    insuranceController.value.text =
        (instanceOfLoginData?.insuranceNumber).toString();
    BreakDateFormat();
  }

  Future<void> BreakDateFormat() async {
    try {
      var str = (instanceOfLoginData?.validTill).toString();

      // print(str.substring(0,4));
      // print(str.substring(5,7));
      // print(str.substring(8,10));

      yearController.value.text = str.substring(6, 10);
      monthController.value.text = str.substring(3, 5);
      dateController.value.text = str.substring(0, 2);
    } catch (e) {}
  }
  Future<void> pickImage() async {
    profilestatus.value = 1;
    print("file return ::: ${pickedImage.value.path}");
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      pickedImage.value = File(image!.path);
      print("pickedImage path ${pickedImage.value.path}");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> pickFromCamera() async {
    profilestatus.value = 1;
    print("file return ::: ${pickedImage.value.path}");
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      pickedImage.value = File(image!.path);
      print("pickedImage path ${pickedImage.value.path}");
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<int> upDateDl() async {
    if(insuranceController.value.text=="" || insuranceController.value.text==null ||dateController.value.text=="" || dateController.value.text==null || yearController.value.text=="" || yearController.value.text==null ||monthController.value.text=="" || monthController.value.text==null ){
      showMySnackbar(title: "Error",msg: "Field must not be empty");
      return 0;
    }
    else if(instanceOfLoginData?.image==null && pickedImage.value.path==""){
      showMySnackbar(title: "Error",msg: "Field must not be empty");
      return 0;

    }
    else {
      instanceOfGlobalData.loader.value=true;
      try {
        if(pickedImage.value.path!="") {
          var imageresponse = await uploadImage(pickedImage.value.path);
          imageUpload.value = ImageUpload.fromJson(imageresponse);
        }
        var body = {
          "insurance": {
            "insuranceNumber": insuranceController.value.text,
            "validTill": "${dateController.value.text}-${monthController.value
                .text}-${yearController.value.text}",
            "image":pickedImage.value.path!=""?(imageUpload.value.urls?[0]):(instanceOfLoginData?.image),
            //"https://www.shutterstock.com/image-vector/driver-license-male-photo-identification-260nw-1227173818.jpg"
          },
        };
        final response = await APIManager.updateDetails(body: body);

        logindetails.value =
            logedInDetails.fromJson(jsonDecode(response.toString()));
        print("response.data : ${response}");
        instanceOfGlobalData.loader.value=false;
        return 1;
      } catch (e) {
        instanceOfGlobalData.loader.value=false;
        showMySnackbar(
            title: "Error", msg: "Error while updating Licence Details");
        return 0;
      }
    }
  }

  Future<dynamic> uploadImage(String path) async {
    String token = Get.find<GetStorageService>().jwToken;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          Endpoints.imapgeUpload),);
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
}
