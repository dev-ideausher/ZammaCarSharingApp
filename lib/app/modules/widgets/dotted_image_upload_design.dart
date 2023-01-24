import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';
class DottedContainer extends StatelessWidget {
  DottedContainer({Key? key,required this.onPressed}) : super(key: key);
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onPressed,
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
        child: DottedBorder(
            strokeWidth: 1,
            strokeCap: StrokeCap.round,
            color: Colors.grey,
            dashPattern: [10, 5],
            borderType: BorderType.RRect,
            radius: Radius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10))),
              // color: Colors.white,
              child: Center(
                  child: SvgPicture.asset(
                      "assets/icons/image_upload_container_text.svg")),
            )),
      ),
    );
  }
}
