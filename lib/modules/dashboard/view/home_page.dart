import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/modules/dashboard/view/apple_pay.dart';
import 'package:for_two/modules/dashboard/view/connect_partner_screen.dart';
import 'package:for_two/modules/dashboard/view/tool_bar.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 20, right: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CustomToolbar(),

                          CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: 'ForTwoSouls',fontWeight: FontWeight.bold,),

                          const SizedBox(height: 20),

                          Visibility(
                            visible: !(controller.connectPartnerButton),
                            child: Container(
                              height: size.height * 0.20,
                              width: size.width,
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.grey.shade50,
                                color: Colors.white,
                                child: Row(
                                  children: [

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            CustomizedTextWidget(
                                              color: blackTextColor,
                                              fontSize: 12,
                                              textValue: '2 wishes completed out of 5',
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Poppins-Regular',
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),
                                            LinearProgressIndicator(
                                              backgroundColor: Colors.red,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade200),

                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ), //SizedBox

                                            Row(

                                              mainAxisAlignment: MainAxisAlignment.start,

                                             children: [

                                               Image.asset(
                                                 "assets/images/user_image.png",
                                                 height: 20,
                                                 width: 20,
                                               ),

                                               const SizedBox(
                                                 width: 10,
                                               ),

                                               CustomizedTextWidget(
                                                 color: blackTextColor,
                                                 fontSize: 15,
                                                 textValue: controller.userName,
                                                 overflow: TextOverflow.ellipsis,
                                                 fontFamily: 'Poppins-Medium',
                                               ),
                                               const SizedBox(
                                                 width: 10,
                                               ),

                                               CustomizedTextWidget(
                                                 color: blackTextColor,
                                                 fontSize: 12,
                                                 textValue: '200 Pts',
                                                 overflow: TextOverflow.ellipsis,
                                                 fontFamily: 'Poppins-Regular',
                                               ),

                                             ],

                                            ),

                                            const SizedBox(
                                              height: 10,
                                            ),


                                            Row(
                                              children: [

                                                Image.asset(
                                                  "assets/images/partner_image.png",
                                                  height: 20,
                                                  width: 20,
                                                ),

                                                const SizedBox(
                                                  width: 10,
                                                ),

                                                CustomizedTextWidget(
                                                  color: blackTextColor,
                                                  fontSize: 15,
                                                  textValue: controller.partnerName,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontFamily: 'Poppins-Medium',
                                                ),

                                                const SizedBox(
                                                  width: 10,
                                                ),

                                                CustomizedTextWidget(
                                                  color: blackTextColor,
                                                  fontSize: 12,
                                                  textValue: '200 Pts',
                                                  overflow: TextOverflow.ellipsis,
                                                  fontFamily: 'Poppins-Regular',
                                                ),

                                              ],

                                            ),//SizedBox
                                            //SizedBox
                                            //SizedBox
                                          ],
                                        ),
                                      ),
                                    ),

                                    Visibility(
                                      visible: false,
                                      child: Container(
                                        height: size.height * 0.15,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: buttonSecondColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(100.0),

                                          ),
                                        ),

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CustomizedTextWidget(
                                              color: Colors.white,
                                              fontSize: 15,
                                              textValue: 'Total Score',
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                            CustomizedTextWidget(
                                              color: Colors.white,
                                              fontSize: 15,
                                              textValue: '800/1000',
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                  ],
                                ), //SizedBox
                              ),
                            ),
                          ) ,


                          LiquidCustomProgressIndicator(
                            value: controller.percent / 100,
                            center: CustomizedTextWidget(color: kBlackColor, fontSize: 28, textValue: '50%'),
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                            backgroundColor: Colors.grey[100],
                            direction: Axis.vertical,
                            shapePath: controller.buildHeartPath(),
                          ),

                          const SizedBox(height: 20),

                          CustomizedTextWidget(color: buttonFirstColor, fontSize: 15, textValue: IntlKeys.home_desc.tr,fontWeight: FontWeight.normal,textAlignment: TextAlign.center,),

                          const SizedBox(height: 10),

                          Visibility(
                            visible: controller.connectPartnerButton,
                            child: CommonElevatedButton(
                              height: size.height * 0.05,
                              width: size.width * 0.70,
                              title: IntlKeys.connect_play.tr,
                              onTap: () async {
                                Get.to(() => ConnectPartnerScreen());
                              },
                            ),
                          ),

                          CommonElevatedButton(
                            height: size.height * 0.05,
                            width: size.width * 0.70,
                            title: "Pay Now",
                            onTap: () async {
                           //   Get.to(() => GooglePayScreen());

                           controller.makePayment();

                            },
                          ),


                          const SizedBox(height: 30),

                          Image.asset(
                            "assets/images/home_bottom.png",
                            height: size.height * 0.1,
                            width: size.height,
                          ),

                          const SizedBox(height: 30),

                          CustomizedTextWidget(color: buttonFirstColor, fontSize: 20, textValue: IntlKeys.home_quote.tr,fontWeight: FontWeight.bold,textAlignment: TextAlign.center,),

                          const SizedBox(height: 20),



                        ],
                      ),
                    ),
                  );
          }),
    );
  }


}
