
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
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
        ],
    )
        : CupertinoTabScaffold(
        backgroundColor: kWhiteColor,
        tabBar: CupertinoTabBar(
            height: 54,
            activeColor: kWhiteColor,
            inactiveColor: kWhiteColor!.withOpacity(0.6),
            backgroundColor: kPrimaryColor,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            items: const [
              BottomNavigationBarItem(
                label: "Invited",
                icon: Icon(Icons.insert_invitation),
              ),
              BottomNavigationBarItem(
                label: "Invitations",
                icon: Icon(Icons.insert_invitation_sharp),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
              ),
            ]),
        tabBuilder: ((context, index) {
          return CupertinoTabView(
            builder: (context) {

             return controller.getPage(index);

            },
          );
        }
        ));
  }

}