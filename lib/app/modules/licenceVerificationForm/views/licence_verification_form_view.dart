import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/modules/widgets/date_of_birth_design.dart';
import 'package:zammacarsharing/app/modules/widgets/dotted_image_upload_design.dart';
import 'package:zammacarsharing/app/modules/widgets/text_filed.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/licence_verification_form_controller.dart';

class LicenceVerificationFormView
    extends GetView<LicenceVerificationFormController> {
  const LicenceVerificationFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Licence details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(height:700.kh,padding: EdgeInsets.all(16),
          child: Obx(()=>
             Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text("Licence Number",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
              SizedBox(height: 8.kh,),
              TextFieldDesign(hintText: "Enter licence number",controller: controller.licenceNumberController.value),
                  SizedBox(height: 24.kh,),
                  Text("Valid till",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8.kh,),
                  DataOfBirthDesign(dateController: controller.dateController.value,monthController: controller.monthController.value,yearController: controller.yearController.value),
                  SizedBox(height: 24.kh,),
                  Text("Upload Licence",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
                  SizedBox(height: 12.kh,),
                  controller.profilestatus.value != 0?Container(
                    height: 188.kh,
                    width: 344.kw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      image: DecorationImage(
                        image: FileImage(controller.pickedImage.value),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // margin: EdgeInsets.fromLTRB(16, 24.kh, 16, 0),

                  ):(controller.instanceOfLoginData?.image==null ||controller.instanceOfLoginData?.image=="")?DottedContainer(onPressed: (){
                    showModalBottomSheet<void>(
                      backgroundColor: Color(0x00FFFFFF),
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200.kh,
                          child: Center(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(onTap:(){
                                  controller.pickImage();
                                  Get.back();
                                },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(16,0,16,0),
                                    height: 60.kh,
                                    width: double.infinity,
                                    child: Center(child: Text("Photo Gallery",style: TextStyle(color: Color(0xff007AFF),fontSize: 18,),)),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft:
                                            Radius.circular(15))),
                                  ),
                                ),
                                SizedBox(height: 1,),
                                InkWell(onTap: (){
                                  controller.pickFromCamera();
                                  Get.back();
                                },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(16,0,16,0),
                                    height: 60.kh,
                                    width: double.infinity,
                                    child: Center(child: Text("Camera",style: TextStyle(color: Color(0xff007AFF),fontSize: 18,))),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft:
                                            Radius.circular(15))),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                InkWell(onTap: (){
                                  Get.back();
                                },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(16,0,16,0),
                                    height: 60.kh,
                                    width: double.infinity,
                                    child: Center(child: Text("Cancle",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),)),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(15),)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }):CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                    "${controller.instanceOfLoginData?.image}",
                    imageBuilder: (context, imageProvider) =>Container(
                      height: 188.kh,
                      width: 344.kw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // margin: EdgeInsets.fromLTRB(16, 24.kh, 16, 0),

                    ),

                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 188.kh,
                            width: 344.kw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),

                            ),

                            // margin: EdgeInsets.fromLTRB(16, 24.kh, 16, 0),

                          ),
                        ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey.shade50,
                      maxRadius: 60,
                      child: Lottie.asset(
                          'assets/json/default_profile.json'),
                      //  FileImage(controller.pickedImage.value),
                    ),
                  ),


                  Spacer(),
              controller.instanceOfGlobalData.loader.value==true?Center(
                child: SizedBox(
                    width: 200.kh,
                    height: 100.kh,
                    child: Lottie.asset('assets/json/car_loader.json')),
              ):ButtonDesign(name: "Next", onPressed: (){
                    controller.upDateDl().then((value){
                      if(value==1){
                        Get.toNamed(Routes.PRE_INSURANCE_VERIFICATION,);
                      }
                    });

                  })


                ]),
          ),),
      ),
    );
  }
}
