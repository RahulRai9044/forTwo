import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/chooseLanguage/view/select_language.dart';
import 'package:for_two/modules/evolution/view/add_evolutions.dart';
import 'package:for_two/modules/evolution/view/evolutions_tab_view.dart';
import 'package:for_two/modules/settings/view/achievements_screen.dart';
import 'package:for_two/modules/settings/view/profile_screen.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';


class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue:IntlKeys.setting_title.tr,fontFamily: 'Poppins-SemiBold',),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),

            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){

                        Get.to(() =>  ProfileScreen());

                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.person_outline,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.profile.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                       Icon(Icons.arrow_forward_ios,size: 20,)

                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){

                        Get.to(() =>  const AchievementsScreen());

                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.shield_moon_outlined,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.achievements.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)




                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){

                        Get.to(() =>  const EvaluationsTabView());

                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [

                                        Icon(Icons.assignment_outlined,size: 24,),
                                        const SizedBox(width: 20),

                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.evaluation.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)




                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){


                        Get.to(() =>  const SelectLanguage());

                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.language,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.select_lang.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)
                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){



                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.notifications_none,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.notifications.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)




                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){



                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.key,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.change_password.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)




                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(

                      onTap: (){



                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.share,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.share_link.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),

                                    Icon(Icons.arrow_forward_ios,size: 20,)




                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(

                      onTap: (){

                        final Prefrence _mPrefrence = Prefrence();
                        _mPrefrence.clearData();

                        Get.offAll(() =>  const LoginScreen());


                      },

                      child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 5)
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 15)
                                )
                              ],
                              gradient:  LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child:  Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(Icons.logout,size: 24,),
                                        const SizedBox(width: 20),
                                        CustomizedTextWidget(
                                          color: kTextColor ?? Colors.grey.shade700,
                                          fontSize: 16,
                                          textValue: IntlKeys.logout.tr,fontFamily: 'Poppins-Medium',),
                                      ],
                                    ),


                                    Icon(Icons.arrow_forward_ios,size: 20,)

                                  ],
                                ),
                              ))),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ))

    );

  }



}