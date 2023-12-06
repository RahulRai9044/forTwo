
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
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
           return SafeArea(
             child: IntroductionScreen(
                key: introKey,
               // globalBackgroundColor: Colors.white,
                allowImplicitScrolling: true,
                autoScrollDuration: 3000,
                infiniteAutoScroll: true,
                globalHeader: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                   // child: buildImage('flutter.png', 100),
                  ),
                ),
                globalFooter: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CommonElevatedButton(
                    height: size.height * 0.05,
                    width: size.width * 0.5,
                    title: IntlKeys.button_welcome.tr,
                    onTap: () async {

                      Get.offAll(() => LoginScreen());

                    },
                  ),
                ),
                pages: [

                  PageViewModel(
                    title:IntlKeys.head_one_welcome.tr,
                    body: IntlKeys.desc_one_welcome.tr,
                    image: buildImage('welcome_one.png'),
                    decoration: controller.pageDecoration,
                  ),
                  PageViewModel(
                    title: IntlKeys.head_two_welcome.tr,
                    body:IntlKeys.desc_two_welcome.tr,
                    image: buildImage('welcome_two.png'),
                    decoration: controller.pageDecoration,
                  ),

                  PageViewModel(
                    title: IntlKeys.head_three_welcome.tr,
                    body: IntlKeys.desc_three_welcome.tr,
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
                skip:  CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: IntlKeys.skip_btn.tr,),
                next: CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: IntlKeys.done_btn.tr,),
                done: GestureDetector(
                    onTap: (){


                    },
                    child: CustomizedTextWidget(color: welcomeButtonColor, fontSize: 16, textValue: IntlKeys.done_btn.tr,)),
                curve: Curves.fastLinearToSlowEaseIn,
                controlsMargin: const EdgeInsets.all(10),
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
              ),
           );
          }),
    );
  }


  Widget buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/images/$assetName', width: width,height: 200,);
  }




}