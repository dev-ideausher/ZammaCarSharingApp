import 'package:flutter/material.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
class DataOfBirthDesign extends StatelessWidget {
  final dateController;
  final monthController;
  final yearController;
  bool readOnly;
   DataOfBirthDesign({Key? key,required this.dateController,required this.monthController,required this.yearController,this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45.kh,
          width: 64.kw,
          //padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          decoration: BoxDecoration(
              color: Color(0xffF3F2F3),
              borderRadius: BorderRadius.all(Radius.circular(5),),),
          child: Theme(
            data: Theme.of(context).copyWith(
                backgroundColor: Colors.grey,
                splashColor: Colors.grey),
            child: TextField(readOnly: readOnly,
              controller: dateController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                //   border: OutlineInputBorder(),
                hintText: 'DD',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 24.kw,
        ),
        Container(
          height: 45.kh,
          width: 64.kw,
          //padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          decoration: BoxDecoration(
              color: Color(0xffF3F2F3),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Theme(
            data: Theme.of(context).copyWith(
                backgroundColor: Colors.grey,
                splashColor: Colors.grey),
            child: TextField(readOnly: readOnly,
              controller: monthController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                //   border: OutlineInputBorder(),
                hintText: 'MM',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 24.kw,
        ),
        Container(
          height: 45.kh,
          width: 100.kw,
          //padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          decoration: BoxDecoration(
              color: Color(0xffF3F2F3),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Theme(
            data: Theme.of(context).copyWith(
                backgroundColor: Colors.grey,
                splashColor: Colors.grey),
            child: TextField(readOnly: readOnly,
              controller: yearController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                //   border: OutlineInputBorder(),
                hintText: 'YYYY',
              ),
            ),
          ),
        ),


      ],
    );
  }
}
