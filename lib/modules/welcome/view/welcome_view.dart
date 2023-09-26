
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/dashboard/view/dashboard_screen.dart';
import 'package:for_two/modules/welcome/controller/welcome_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';



class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<WelcomeController>(
          init: WelcomeController(),
          builder: (controller) {
           return IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.white,
              allowImplicitScrolling: true,
              autoScrollDuration: 3000,
              infiniteAutoScroll: true,
              globalHeader: Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                   // child: buildImage('flutter.png', 100),
                  ),
                ),
              ),
              globalFooter: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  child: CommonElevatedButton(
                    height: size.height * 0.05,
                    width: size.width * 1.0,
                    title: "Let’s Start",
                    onTap: () async {

                      Get.offAll(() => DashboardScreen());

                    },
                  ),
                ),
              ),
              pages: [

                PageViewModel(
                  title: "Percentage Calculator",
                  body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ullamcorper velit mauris, sit amet viverra nibh maximus quis.",
                  image: buildImage('welcome_one.png'),
                  decoration: controller.pageDecoration,
                ),
                PageViewModel(
                  title: "Achievements",
                  body:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ullamcorper velit mauris, sit amet viverra nibh maximus quis.  ",
                  image: buildImage('welcome_two.png'),
                  decoration: controller.pageDecoration,
                ),

                PageViewModel(
                  title: "Fortune Wheel",
                  body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ullamcorper velit mauris, sit amet viverra nibh maximus quis. ",
                  image: buildImage('welcome_three.png'),
                  decoration: controller.pageDecoration.copyWith(
                    bodyFlex: 6,
                    imageFlex: 6,
                    safeArea: 80,
                  ),
                ),

              ],
              onDone: () => controller.onIntroEnd(context),
              onSkip: () => controller.onIntroEnd(context), // You can override onSkip callback
              showSkipButton: true,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: false,
              //rtl: true, // Display as right-to-left
              back: const Icon(Icons.arrow_back),
              skip:  CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: 'Skip'),
              next: CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: 'Done'),
              done: CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: 'Done'),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            );
          }),
    );
  }


  Widget buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }




}