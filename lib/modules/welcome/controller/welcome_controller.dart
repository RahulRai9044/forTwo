import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeController extends GetxController{


    PageDecoration pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    //bodyTextStyle: bodyStyle,
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );


  void onIntroEnd(context) {

  }



}