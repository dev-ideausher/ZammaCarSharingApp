import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/modules/widgets/button_design.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/report_an_issue_controller.dart';

class ReportAnIssueView extends GetView<ReportAnIssueController> {
  const ReportAnIssueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:  Text(
          'Report An Issue',
          style: GoogleFonts.urbanist(color: ColorUtil.ZammaBlack),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: 800.kh,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.kh,
              ),
              Text(
                "What’s the issue",
                style: GoogleFonts.urbanist(
                    fontSize: 24,
                    color: ColorUtil.ZammaBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.kh,
              ),
              Container(
                height: 80.kh,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: ColorUtil.kPrimary)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Obx(() => SizedBox(
                            width: 200.kw,
                            child: Text("${controller.filename.value}",
                                style: GoogleFonts.urbanist(color: ColorUtil.kPrimary)))),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: InkWell(
                            onTap: () {
                              controller.pickFromCamera();
                            },
                            child: SvgPicture.asset(
                              "assets/icons/camera.svg",
                              color: ColorUtil.kPrimary,
                            )),
                      ),
                    ]),
              ),
              SizedBox(
                height: 16.kh,
              ),
              Text(
                "Add comment ",
                style: GoogleFonts.urbanist(
                    fontSize: 20,
                    color: ColorUtil.ZammaBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.kh,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F2F3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: ColorUtil.kPrimary,
                    )),
                child: TextField(
                  controller: controller.textEditingController.value,
                  maxLength: 250,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                  ),
                ),
              ),
              SizedBox(
                height: 80.kh,
              ),
              Container(
                child: ButtonDesign(
                    name: "Submit",
                    onPressed: () {
                      controller.issueloader.value == true ? print(
                        "No"
                      ):
                      controller.uploadIssue();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
