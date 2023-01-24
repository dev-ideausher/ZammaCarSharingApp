import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/modules/widgets/date_of_birth_design.dart';
import 'package:zammacarsharing/app/modules/widgets/text_filed.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/view_insurance_controller.dart';

class ViewInsuranceView extends GetView<ViewInsuranceController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Insurance details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(height:700.kh,padding: EdgeInsets.all(16),
          child: Obx(()=>
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Insurance Number",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
                    SizedBox(height: 8.kh,),
                    TextFieldDesign(readOnly: true,hintText: "Enter insurance number",controller: controller.insuranceController.value),
                    SizedBox(height: 24.kh,),
                    Text("Valid till",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
                    SizedBox(height: 8.kh,),
                    DataOfBirthDesign(readOnly: true,dateController: controller.dateController.value,monthController: controller.monthController.value,yearController: controller.yearController.value),
                    SizedBox(height: 24.kh,),
                    Text("Upload Insurance",style: TextStyle(fontSize: 14.kh,fontWeight: FontWeight.bold),),
                    SizedBox(height: 12.kh,),
                    CachedNetworkImage(
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


                   /* Spacer(),
                    ButtonDesign(name: "Next", onPressed: (){


                       //   Get.offAllNamed(Routes.HOME,);



                    })*/


                  ]),
          ),),
      ),
    );
  }
}
