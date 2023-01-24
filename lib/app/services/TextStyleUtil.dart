import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zammacarsharing/app/services/colors.dart';
import 'responsiveSize.dart';

class TextStyleUtil {
  final Color color;
  final double fontsize;
  final FontWeight fontWeight;

  TextStyleUtil({
    this.color = Colors.white,
    this.fontsize = 24,
    this.fontWeight = FontWeight.w600,
  });

  static TextStyle textNimbusSanLStyleS14Wregular({
    //NimbusSanL
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: 14.kh,
        fontWeight: fontWeight,
      ),
    );
  }


  static TextStyle textMontserratStyleS14WNormalCBlack({
    //NimbusSanL
    Color color = ColorUtil.kPrimary,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      color: color,
      fontSize: 14.kh,
      fontWeight: fontWeight,
      fontFamily: 'Montserrat-Regular',
    );
  }
}
