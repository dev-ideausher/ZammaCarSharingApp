import 'package:flutter/material.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
class TextFieldDesign extends StatelessWidget {
  String hintText;
  final controller;
  bool readOnly;
  TextFieldDesign({required this.hintText,required this.controller,this.readOnly=false});

  @override
  Widget build(BuildContext context) {
    return Container(


      height: 45.kh,
      width: 344.kw,
      //padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      decoration: BoxDecoration(
          color: Color(0xffF3F2F3),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Theme(
        data: Theme.of(context).copyWith(
            backgroundColor: Colors.grey, splashColor: Colors.grey),
        child: TextField(controller: controller,readOnly: readOnly,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none,
            hintText:hintText ,
          ),
        ),
      ),
    );
  }
}
