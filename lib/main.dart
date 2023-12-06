import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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


  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51OJs9ESELNqdqFaiaBhFc5RcNj36Y1SlItOoCofrphyyZT9HPKIFYaB7JUIYf1jRWEITyutOGy1WkHeITlBOUwEN00YagcKlzG";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  if (Platform.isAndroid) {


    await Firebase.initializeApp(
        name: "ForTwoSouls",
        options: const FirebaseOptions(
          apiKey: "AIzaSyB9qL9REbouhZ8DY04yxUkRmVfVq8rnRGk",
          appId: "1:433287989665:android:846962c12af42714a663e0",
          messagingSenderId: "433287989665",
          projectId: "fortwosouls-6c36e",
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

