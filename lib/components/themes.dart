import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color.fromRGBO(199, 131, 64, 1);
Color secondaryColor = Color.fromRGBO(237, 183, 131, 1);
Color accentColor = Color.fromRGBO(249, 158, 68, 1);
Color primaryTextColor = Color.fromRGBO(21, 18, 15, 1);
Color secondaryTextColor = Color(0xFFEEEEEE);
// Color primaryButtonColor = Color(0xFF0D47A1);
// Color secondaryButtonColor = Color(0xFFE3F2FD);
// Color primaryIconColor = Color(0xFF0D47A1);
Color backgroundColor = Color.fromRGBO(7, 13, 89, 1);

double width = Get.width;
double height = Get.height;

TextStyle appBar (){
  return GoogleFonts.montserrat(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle HeaderTextStyle() {
  return GoogleFonts.montserrat(
    fontSize: 18,
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle SubHeaderTextStyle() {
  return GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle BodyTextStyle() {
  return GoogleFonts.montserrat(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
}

TextStyle bodyTextStyle2() {
  return GoogleFonts.montserrat(
    fontSize: 15,
    color: primaryTextColor,
    fontWeight: FontWeight.w400,
  );
}