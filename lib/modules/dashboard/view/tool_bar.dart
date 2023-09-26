import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:get/get.dart';

class CustomToolbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find<DashboardController>();
   return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () async {
                      await Prefrence.setBadgeStatus(false);
                      //   Get.to(() => const NotificationView());
                    },
                    child: Icon(Icons.settings,color: buttonFirstColor,size: 25,)),
                const Spacer(),
                GestureDetector(
                    onTap: () async {
                      await Prefrence.setBadgeStatus(false);
                      //   Get.to(() => const NotificationView());
                    },
                    child: badge.Badge(
                      showBadge: dashboardController.badgeStatus == true
                          ? true
                          : false,
                      position:
                      badge.BadgePosition.topEnd(top: 0, end: 1),
                      badgeContent: null,
                      child: Icon(Icons.notifications,color: buttonFirstColor,size: 25,),
                    )),
              ],
            ),

            const SizedBox(height: 10),

            Divider(color: Colors.grey.shade500.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }




}