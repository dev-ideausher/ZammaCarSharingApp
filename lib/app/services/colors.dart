import 'package:flutter/material.dart';
import 'hexColorToFlutterColor.dart';

extension ColorUtil on BuildContext {
  Color dynamicColor({required int light, required int dark}) {
    return (Theme.of(this).brightness == Brightness.light)
        ? Color(light)
        : Color(dark);
  }

  Color dynamicColour({required Color light, required Color dark}) {
    return (Theme.of(this).brightness == Brightness.light) ? light : dark;
  }

  Color get brandColor1 =>
      dynamicColour(light: HexColor("#5D48D0"), dark: HexColor("#000000"));

  Color get brandColor2 =>
      dynamicColour(light: HexColor("#8032A8"), dark: HexColor("#000000"));

  static const Color kPrimary = Color(0xff031569);
  static const Color ZammaBlack = Colors.black;

  static const Color ZammaGrey = Color(0xffA3A3A3);
  static const Color ZammaDeactiveButton = Color(0xffCDD0E1);

}
