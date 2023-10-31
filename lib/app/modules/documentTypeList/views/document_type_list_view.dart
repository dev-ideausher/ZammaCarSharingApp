import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/routes/app_pages.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/document_type_list_controller.dart';

class DocumentTypeListView extends GetView<DocumentTypeListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title:  Text(
            'Documents',
            style: GoogleFonts.urbanist(color: Colors.black),
          ),
          centerTitle: true,

        ),
        body: Container(
          child: Column(children: [
            SizedBox(
              height: 8.kh,
            ),
            ListTile(onTap: (){
              Get.toNamed(Routes.VIEW_LICENCE);
            },
                leading: SvgPicture.asset("assets/icons/privacyPolicy.svg"),
                title: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Text(
                      "Licence",
                      style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.kh,
                      ),
                    )),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.white),
            SizedBox(
              height: 3.kh,
            ),
            ListTile(onTap: (){
              Get.toNamed(Routes.VIEW_INSURANCE);
            },
                leading: SvgPicture.asset("assets/icons/privacyPolicy.svg"),
                title: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Text(
                      "Insurance",
                      style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.kh,
                      ),
                    )),
                trailing: Icon(Icons.arrow_forward_ios),
                tileColor: Colors.white),
            SizedBox(
              height: 3.kh,
            ),

            Expanded(child: Container(color: Colors.white,)),
          ],),
        )
    );
  }
}
