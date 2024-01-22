import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zammacarsharing/app/modules/models/image_response_model.dart';
import 'package:zammacarsharing/app/modules/models/login_details_model.dart';
import 'package:zammacarsharing/app/services/dio/api_service.dart';
import 'package:zammacarsharing/app/services/dio/endpoints.dart';
import 'package:zammacarsharing/app/services/globalData.dart';
import 'package:zammacarsharing/app/services/snackbar.dart';
import 'package:zammacarsharing/app/services/storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> monthController = TextEditingController().obs;
  Rx<TextEditingController> yearController = TextEditingController().obs;
  final instanceOfGlobalData = Get.find<GlobalData>();
  Rx<bool> loaderProfile = false.obs;
  Rx<logedInDetails> logindetails = logedInDetails().obs;
  var gender = "".obs;
  var pickedImage = File("").obs;
  final profilestatus = 0.obs;
  final imageUpload = ImageUpload().obs;
  Rx<bool> updateProfile = false.obs;
  @override
   onInit() async {
    super.onInit();
    await onBoardingStatus();
  //  loadValue();
    print("onInit Called");
  }

  @override
   onReady() async {
    super.onReady();
    //await onBoardingStatus();
  }

  @override
  void onClose() {
    super.onClose();
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

  Future<void> onBoardingStatus() async {
    await Get.put(GetStorageService()).initState();
    instanceOfGlobalData.loader.value = true;
    Get.find<GetStorageService>().setisLoggedIn = true;
    try {
      final response = await APIManager.checkIsUserOnBoard();

        logindetails.value =
            logedInDetails.fromJson(jsonDecode(response.toString()));
        print("response.data : ${response}");
        Get.find<GlobalData>().userId.value=(logindetails.value.user?.Id).toString();
        nameController.value.text = (logindetails.value.user?.name).toString();
        emailController.value.text =
            (logindetails.value.user?.email).toString();

        var str = (logindetails.value.user?.dob).toString();

        // print(str.substring(0,4));
        // print(str.substring(5,7));
        // print(str.substring(8,10));

        yearController.value.text = str.substring(0, 4);
        monthController.value.text = str.substring(5, 7);
        dateController.value.text = str.substring(8, 10);

        gender.value = (logindetails.value.user?.gender).toString();

        Get.find<GetStorageService>().setisLoggedIn = true;
      Get.find<GetStorageService>().setCustomUserId = (logindetails.value.user?.Id).toString();
        Get.find<GlobalData>().isloginStatusGlobal.value = true;
      instanceOfGlobalData.loader.value = false;

    } catch (e) {
      print("error : ${e}");
      instanceOfGlobalData.loader.value = false;
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
      print(response);
    }
  }

  Future<int> userOnBoard() async {

    if( nameController.value.text=="" || nameController.value.text==null || emailController.value.text=="" || emailController.value.text==null ||dateController.value.text=="" || dateController.value.text==null || yearController.value.text=="" || yearController.value.text==null ||monthController.value.text=="" || monthController.value.text==null || gender.value==""){
      showMySnackbar(title: "Error",msg: "Field must not be empty");
      return 0;
    }
    else if(logindetails.value.user?.image==null && pickedImage.value.path==""){
      showMySnackbar(title: "Error",msg: "Field must not be empty");
      return 0;
    }
    else{
      updateProfile.value=true;
      if(pickedImage.value.path!=""){
        var response = await uploadImage(pickedImage.value.path);
        imageUpload.value = ImageUpload.fromJson(response);
      }



    //  print("response ${"${(imageUpload.value.urls)?.substring(1,length)}"}");
      instanceOfGlobalData.loader.value=true;
      var body = {
        "name": nameController.value.text,
        "email": emailController.value.text,
        "dob":
        "${yearController.value.text}-${monthController.value.text}-${dateController.value.text}",
        "image":"${(pickedImage.value.path)!=""?(imageUpload.value.urls?[0]):(logindetails.value.user?.image)}",//"https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg", //"${pickedImage.value.path}",
        "gender": gender.value,
       // "address":"Hauz Khas Delhi"
      };
      try {

        final response = await APIManager.onBoardUser(body: body);
         logindetails.value = logedInDetails.fromJson(jsonDecode(response.toString()));
        Get.find<GetStorageService>().setisLoggedIn = true;
        Get.find<GlobalData>().userId.value=(logindetails.value.user?.Id).toString();
         print("response.data : ${response.toString()}");

        instanceOfGlobalData.loader.value=false;
        updateProfile.value=false;
        return 1;
      } catch (e) {
        updateProfile.value=false;
        instanceOfGlobalData.loader.value=false;
        return 0;
      }
    }


  }
}
