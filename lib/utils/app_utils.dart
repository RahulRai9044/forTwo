

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class ApplicationUtils {
  static showSnackBar(
      {required String? titleText, required String? messageText}) {
    return Get.snackbar('', '',
        messageText: Text(
          messageText!,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        titleText: Text(
          titleText!,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: kPrimaryColor?.withOpacity(0.3),
        borderRadius: 8,
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        padding: const EdgeInsets.all(12));
  }

  static showDialogueAchievements(
      {required String? titleText, required String? messageText}) {
   return Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: size.width * 0.6,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(titleText!),
                  ),
                  SizedBox(height:10,),
                  Image.asset("assets/images/badge_icons.png",height:30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Please check your connection again,or connect to wi-fi.",),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }



  static showDialogueNoLimitWishAdd(
      {required String? titleText, required String? messageText}) {
    return Get.dialog(
        barrierDismissible: true,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => true,
            child: Container(

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child:CustomizedTextWidget(
                      color: kTextColor,
                      fontSize: 15,
                      textValue: titleText ?? "",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomizedTextWidget(
                      color: kTextColor,
                      fontSize: 12,
                      textAlignment: TextAlign.center,
                      textValue: messageText ?? "",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  GestureDetector(
                    onTap: (){
                      
                      Get.back();
                      
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                            width: size.width * 0.30,
                            decoration: new BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                shape: BoxShape.rectangle,
                                border: new Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                gradient: const LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white
                                ])),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: CustomizedTextWidget(
                                          color: Colors.red.shade400,
                                          fontSize: 16,
                                          textValue: 'Close')),
                                  const SizedBox(width: 10),
                                 Icon(Icons.close,size: 20,)
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  static shareFacebookConfirmationDialogue() {
    WishListController controller = Get.find<WishListController>();
   return  Get.dialog(
        barrierDismissible: true,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => true,
            child: Container(

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomizedTextWidget(
                      color: buttonSecondColor,
                      fontSize: 15,
                      textValue: "Share on Facebook",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomizedTextWidget(
                      color: kTextColor,
                      fontSize: 12,
                      textAlignment: TextAlign.center,
                      textValue: "Are you sure want to share this completed wish on facebook",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                                width: size.width * 0.30,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    border: new Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2.0,
                                    ),
                                    gradient: const LinearGradient(colors: [
                                      Colors.white,
                                      Colors.white
                                    ])),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CustomizedTextWidget(
                                              color: Colors.red.shade400,
                                              fontSize: 16,
                                              textValue: 'Close')),
                                      const SizedBox(width: 10),
                                      Icon(Icons.close, size: 20,)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {


                          controller.shareOnFacebook();

                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                                width: size.width * 0.30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    border: new Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2.0,
                                    ),
                                    gradient:  LinearGradient(colors: [
                                      Colors.white,
                                      Colors.white,
                                    ])),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CustomizedTextWidget(
                                              color: Colors.black,
                                              fontSize: 16,
                                              textValue: 'Share')),
                                      const SizedBox(width: 10),
                                      Icon(Icons.facebook, size: 20,color: Colors.blue,)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }

}
