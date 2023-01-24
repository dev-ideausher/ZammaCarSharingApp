import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Help',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,

      ),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 8.kh,
          ),
          ListTile(
              leading: SvgPicture.asset("assets/icons/privacyPolicy.svg"),
              title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
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
          ListTile(
              leading: SvgPicture.asset("assets/icons/termsNCondition.svg"),
              title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text(
                    "Term’s & Condtions",
                    style: TextStyle(
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
          ListTile(
              leading: SvgPicture.asset("assets/icons/support.svg"),
              title: Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text(
                    "Support",
                    style: TextStyle(
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
