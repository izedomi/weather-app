import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff003366);
const Color secondaryColor = Color(0xff90B2F8);

//Create a shader linear gradient
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class AppColor {
  static const Color brandBlue = Color(0xff003366);
  static const Color brandOrange = Colors.deepOrange;
  static const Color brandBlack = Color(0xff000B23);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color blue = Color(0xff003CC2);
  static const Color red = Color(0xffFF0000);
  static const Color grey = Color(0xff7D7D7D);
  static const Color lightGrey = Color(0xffC9C9C9);
  static const Color brownGrey = Color(0xffF3F3F3);
  static const Color dipBlack = Color(0xff4B4B4B);
  static const Color shadowGrey = Color(0xffEDEDED);
  static const Color bsDivider = Color(0xffE7E7E7);
}
