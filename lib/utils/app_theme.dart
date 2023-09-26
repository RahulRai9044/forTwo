import 'package:flutter/material.dart';

Color? kPrimaryColor = const Color(0xFFDF1721);
Color? kWhiteColor = const Color(0XFFFFFFFF);
Color kBlackColor = const Color(0xFF0D0D0D);
Color? kSecondaryColor = const Color(0xFFE2F5F6);
Color? kTealColor = const Color(0XFF28B59D);
Color? kOrangeAccentColor = const Color(0xFFFFD0B3);
Color? kTextColor = const Color(0xFF616161);
Color? kTextColorRed = const Color(0xFFF4517E);
Color buttonFirstColor =  Color(0xFFEF3B85);
Color welcomeButtonColor =  Color(0xFF747373);
Color buttonSecondColor =  Color(0xFFF01828);
Color transparentColor =  Color(0x00FFFFFF);

Color gradientColorOne =  Color(0x00C7D4F9);
Color gradientColorTwo =  Color(0x00C9D3EC);
Color gradientColorThree =  Color(0x00E8EBF4);
Color gradientColorFour =  Color(0x00F4C8D7);
Color gradientColorFive =  Color(0x00FFF5EB);

ThemeData themeData() {
  return ThemeData(
    fontFamily: 'Montserrat',
    primaryColor: kBlackColor,
    textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: kBlackColor,
        ),
        headline2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: kBlackColor,
        ),
        headline3: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: kBlackColor?.withOpacity(0.8),
        ),
        headline4: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kBlackColor,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kBlackColor?.withOpacity(0.6),
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: kBlackColor,
        ),
        subtitle1: TextStyle(
          fontSize: 12,
          color: kBlackColor?.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          fontSize: 12,
          color: kBlackColor,
          fontWeight: FontWeight.w600,
        )),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: 8, left: 12, right: 10),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      hintStyle: TextStyle(
        color: kBlackColor?.withOpacity(0.8),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      border: InputBorder.none,
    ),
  );
}