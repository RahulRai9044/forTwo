import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/settings/controller/profile_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: CustomizedTextWidget(
                color: buttonFirstColor,
                fontSize: 25,
                textValue: IntlKeys.achievements.tr,
                fontFamily: 'Poppins-SemiBold',
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Container(
                            height: size.height * 0.10,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Color(0xFFF01828), Color(0xFFEF3B85)]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/badge_icons.png",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 20),
                                Center(
                                  child: CustomizedTextWidget(
                                      color: Colors.white,
                                      fontSize: 18,
                                      textValue: IntlKeys.achievement_desc.tr),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.2),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 10.0),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/"+controller.myProducts[index]["image"],
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),


                                              GestureDetector(
                                                onTap:(){

                                                  ApplicationUtils.showDialogueAchievements(titleText: "showDialogueAchievements", messageText: "showDialogueAchievements");

                                                  },
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,0.0),
                                                  child: Icon(
                                                    Icons.info_outline,
                                                    color: Colors.red.shade500,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFF01828),
                                                  Color(0xFFEF3B85)
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: CustomizedTextWidget(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    textValue: controller.myProducts[index]["name"],
                                                    fontFamily: 'Poppins-Medium',
                                                  ),
                                                ),
                                              ),
                                              RatingBar(
                                                initialRating:controller.myProducts[index]["badge_count"],
                                                direction: Axis.horizontal,
                                                itemSize: 15,
                                                allowHalfRating: false,
                                                itemCount: 4,
                                                ratingWidget: RatingWidget(
                                                  full: Image.asset(
                                                    "assets/images/badge_icons.png",
                                                  ),
                                                  half: Image.asset(
                                                    "assets/images/badge_icons.png",
                                                  ),
                                                  empty: Container(),
                                                ),
                                                itemPadding: EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                })));
  }
}
