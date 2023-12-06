import 'package:flutter/material.dart';
import 'package:for_two/intl/intl.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/welcome/view/welcome_view.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: IntlKeys.change_language.tr,fontFamily: 'Poppins-SemiBold',),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomizedTextWidget(color: blackTextColor, fontSize: 18, textValue: IntlKeys.select_language.tr,fontFamily: 'Poppins-Medium',),


            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(

                onTap: (){

                  final _locale = Intl.localeEN_US;

                  Get.updateLocale(_locale);

                  Get.offAll(() =>  WelcomeScreen());

                },

                child: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.white,
                        width: 2.0,),
                      gradient:  LinearGradient(colors: [
                        Color(0xFFF4F0F0),
                        Color(0xFFFFFEFE)
                      ])),
                  child:  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Image.asset(
                            "assets/images/us_flag.png",
                            height: size.height * 0.05,
                            width: size.width * 0.05,
                          ),

                          SizedBox(width: 10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomizedTextWidget(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  textValue: 'English',fontFamily: 'Poppins-Bold',),
                              SizedBox(height: 10),
                              CustomizedTextWidget(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                  textValue: '(US)',fontFamily: 'Poppins-Bold',),
                            ],
                          ),
                        ],
                      ))),
              ),

              GestureDetector(

                onTap: (){

                  final _locale = Intl.localeSpanish;

                  Get.updateLocale(_locale);
                  Get.offAll(() =>  WelcomeScreen());
                },

                child: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.1,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: Colors.white,
                          width: 2.0,),
                        gradient: const LinearGradient(colors: [
                          Color(0xFFF4F0F0),
                          Color(0xFFFFFEFE)
                        ])),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/spanish_flag.png",
                          height: size.height * 0.05,
                          width: size.width * 0.05,
                        ),

                        SizedBox(width: 10),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomizedTextWidget(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                textValue: 'Spanish',fontFamily: 'Poppins-Bold',),

                            SizedBox(height: 10),
                            CustomizedTextWidget(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                                textValue: '(US)',fontFamily: 'Poppins-Bold',),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),




          // const Divider(endIndent: 30, indent: 30),
          // ListTile(
          //   title: Text(IntlKeys.defaultText.tr),
          //   dense: true,
          //   onTap: () {
          //     final _locale = Get.deviceLocale ?? Intl.localeEN_US;
          //
          //     Get.updateLocale(_locale);
          //   },
          // ),
        ],
      ),
    );
  }
}
