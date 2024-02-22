import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'package:zammacarsharing/app/services/responsiveSize.dart';

class ButtonDesign extends StatelessWidget {
  ButtonDesign({Key? key, required this.name, required this.onPressed})
      : super(key: key);
  String name;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtil.kPrimary,
        foregroundColor: Colors.white,
        fixedSize: Size(344.kw, 56.kh),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name), // <-- Text
          /*SizedBox(
            width: 15.kw,
          ),*/
        ],
      ),
    );
  }
}

class InspectionButton extends StatelessWidget {
  InspectionButton({Key? key, required this.name, required this.onPressed})
      : super(key: key);
  String name;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtil.kPrimary,
        fixedSize: Size(344.kw, 56.kh),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name), // <-- Text
          /*SizedBox(
            width: 15.kw,
          ),*/
        ],
      ),
    );
  }
}

class ButtonDesignDeactive extends StatelessWidget {
  ButtonDesignDeactive({Key? key, required this.name, required this.onPressed})
      : super(key: key);
  String name;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtil.ZammaDeactiveButton,
        fixedSize: Size(344.kw, 56.kh),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: GoogleFonts.urbanist(color: Colors.white),
          ), // <-- Text
          SizedBox(
            width: 10.kw,
          ),
        ],
      ),
    );
  }
}
