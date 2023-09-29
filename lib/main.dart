import 'dart:io';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:for_two/firebaseNotification/firebase_notification.dart';
import 'package:for_two/modules/splash/splash_screen.dart';
import 'package:for_two/route/app_route.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart';
import 'intl/intl.dart';
import 'intl/intl_keys.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        name: "fortwo",
        options: const FirebaseOptions(
          apiKey: "AIzaSyCB628qsRRaRJW_zTJbySS4z-OE1DdE6uU",
          appId: "1:862903860102:android:70d82f844ac2cc4cfb4a07",
          messagingSenderId: "862903860102",
          projectId: "fortwo-74c79",
        ));



  } else {
    await Firebase.initializeApp();
  }
  await NotificationService.initialize();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
     // initialBinding: RootBindings(),
      title: IntlKeys.select_language.tr,
      translations: Intl(),
      locale: Get.deviceLocale,
      fallbackLocale: Intl.localeEN_US,
      builder: EasyLoading.init(),
      theme: themeData(),
      defaultTransition: Transition.fade,
      getPages: AppRoute.routes,
    );
  }
}

