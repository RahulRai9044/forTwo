import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/chooseLanguage/view/select_language.dart';
import 'package:for_two/modules/dashboard/view/dashboard_screen.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  final Prefrence _prefs = Prefrence();

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    String? userDetail = await _prefs.getUserId();
    if (userDetail.isNotEmpty) {
      Timer(const Duration(seconds: 10), () {
        Get.offAll(() => DashboardScreen());
      });
    } else {
      Timer(const Duration(seconds: 10), () {
        Get.offAll(() =>  SelectLanguage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/app_icon.png",
            height: size.height * 0.3,
            width: size.height * 0.3,
          ),
          const SizedBox(
            height: 10,
          ),
           Text(
            IntlKeys.splash_head.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54,fontSize: 15),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
            ),
          ),
        ],
      ),
    );
  }
}