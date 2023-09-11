
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';


class DashboardScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) => Scaffold(
            body: controller.getPage(controller.tabIndex),
            bottomNavigationBar:
            buildBottomNavigationMenu(context, controller),
          )),
    );
  }

  buildBottomNavigationMenu(context, DashboardController controller) {
    return GetPlatform.isAndroid
        ? BottomNavigationBar(
      unselectedItemColor: Colors.white.withOpacity(0.6),
      selectedItemColor: Colors.white,
      backgroundColor: kPrimaryColor,
      currentIndex: controller.tabIndex,
      onTap: controller.changeTabIndex,
      type: BottomNavigationBarType.fixed,
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