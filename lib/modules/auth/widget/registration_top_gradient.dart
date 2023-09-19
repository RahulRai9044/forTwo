import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/utils/size.dart';

class RegistrationTopGradient extends StatelessWidget {
   RegistrationTopGradient({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming constraints here.
    // Play with width and height values
    double widgetWidth = size.width;
     double widgetHeight = size.height * 0.2;
    // To get a semicircle
     double bottomRadius = widgetWidth / 2;
    //Since we have 5 colors . Each color bars height is 60/5 = 12
     double colorBarHeight = widgetHeight / 5;

    return Container(
      height: widgetHeight,
      width: widgetWidth,

      child: Container(
        height: bottomRadius,
        width: bottomRadius,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(600.0),
          ),

          gradient: LinearGradient(colors: [Color(0xFFF03C86), Color(0xFFF01B2F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),

        ),

        child:  Stack(
          clipBehavior: Clip.none,
         children: [

            Positioned(
              bottom: -30, // half of icon size
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                 width: 100,
                 height: 100,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   boxShadow: [
                     BoxShadow(
                       color: Color(0XFFF01B2F),
                       offset: const Offset(
                         5.0,
                         5.0,
                       ),
                       blurRadius: 10.0,
                       spreadRadius: 2.0,
                     ), //BoxShadow
                     BoxShadow(
                       color: Colors.white,
                       offset: const Offset(0.0, 0.0),
                       blurRadius: 0.0,
                       spreadRadius: 0.0,
                     ), //BoxShadow
                   ],
                 ),
                 child: CircleAvatar(
                   radius: 50,
                   backgroundColor: Colors.white,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(0.0),
                     child: Image.asset(
                       "assets/images/app_icon.png",
                       height:50,
                       width: 50,
                     ),

                   ),


                 ),
           ),

              ),
            ),

         ],
        ),


      ),

    );
  }
}