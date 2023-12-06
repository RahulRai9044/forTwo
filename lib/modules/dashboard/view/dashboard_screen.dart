
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';


class DashboardScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) => Scaffold(
            extendBody: true,
            body: controller.getPage(controller.tabIndex),
            bottomNavigationBar: buildBottomNavigationMenu(context, controller),
          )),
    );
  }

  buildBottomNavigationMenu(context, DashboardController controller) {
    return GetPlatform.isAndroid
        ? CurvedNavigationBar(
        color: buttonFirstColor,
        buttonBackgroundColor: buttonSecondColor,
        backgroundColor: transparentColor,
        index: controller.tabIndex,
        height: 60,
        onTap: controller.changeTabIndex,
        animationCurve: Curves.easeInCirc,
        items: const [
            Icon(Icons.home, size: 20,color: Colors.white,),
            Icon(Icons.star, size: 20,color: Colors.white,),
            Icon(Icons.calendar_today, size: 20,color: Colors.white,),
            Icon(Icons.auto_graph, size: 20,color: Colors.white,),
        ],
    )
        : CurvedNavigationBar(
      color: buttonFirstColor,
      buttonBackgroundColor: buttonSecondColor,
      backgroundColor: transparentColor,
      index: controller.tabIndex,
      height: 60,
      onTap: controller.changeTabIndex,
      animationCurve: Curves.easeInCirc,
      items: const [
        Icon(Icons.home, size: 20,color: Colors.white,),
        Icon(Icons.star, size: 20,color: Colors.white,),
        Icon(Icons.calendar_today, size: 20,color: Colors.white,),
        Icon(Icons.auto_graph, size: 20,color: Colors.white,),
      ],
    );
  }

}