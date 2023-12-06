import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/settings/controller/profile_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
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
                textValue: IntlKeys.profile.tr,
                fontFamily: 'Poppins-SemiBold',
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (controller) {
                  return controller.isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
                      ),
                    )
                   :
                  SingleChildScrollView(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height / 3.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFFC7D4F9),
                              Color(0xFFC9D3EC),
                              Color(0xFFE8EBF4),
                              Color(0xFFF4C8D7),
                              Color(0xFFFFF5EB)
                            ], tileMode: TileMode.clamp),
                          ),
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFC7D4F9),
                                                Color(0xFFC9D3EC),
                                                Color(0xFFE8EBF4),
                                                Color(0xFFF4C8D7),
                                                Color(0xFFFFF5EB)
                                              ],
                                            )),
                                        child: ClipOval(
                                          child: Container(
                                            height: size.height * 0.60,
                                            width: size.width * 0.60,
                                            child: controller.userprofileImage.isNotEmpty ? Image.network(
                                              "http://16.171.232.15:4002/uploads/"+controller.userprofileImage,
                                              height: size.height * 0.40,
                                              width: size.width * 0.40,
                                              fit: BoxFit.cover,
                                            ) :Image.asset(
                                              "assets/images/user_img_pro.png",
                                              height: size.height * 0.40,
                                              width: size.width * 0.40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))),
                                Positioned(
                                  bottom: 10,
                                  right: 20,
                                  child: InkWell(
                                    onTap: () {
                                      showGeneralDialog(
                                        barrierLabel: "Pick Image",
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black,
                                        transitionDuration:
                                            Duration(milliseconds: 700),
                                        context: context,
                                        pageBuilder: (context, anim1, anim2) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: size.height * 0.5,
                                              width: size.width,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                              CommonElevatedButton(
                                                height: size.height * 0.05,
                                                width: size.width * 0.60,
                                                title: IntlKeys
                                                    .pick_image_camera.tr,
                                                onTap: () async {
                                                  controller.btnPickImageTap(
                                                      ImageSource.camera);
                                                },
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CommonElevatedButton(
                                                height: size.height * 0.05,
                                                width: size.width * 0.60,
                                                title: IntlKeys
                                                    .pick_image_gallery.tr,
                                                onTap: () async {
                                                  controller.btnPickImageTap(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(
                                                  bottom: 50,
                                                  left: 12,
                                                  right: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                            ),
                                          );
                                        },
                                        transitionBuilder:
                                            (context, anim1, anim2, child) {
                                          return SlideTransition(
                                            position: Tween(
                                                    begin: Offset(0, 1),
                                                    end: Offset(0, 0))
                                                .animate(anim1),
                                            child: child,
                                          );
                                        },
                                      );
                                    },
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 15.0,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Color(0xFFF01828), Color(0xFFEF3B85)]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Center(
                                    child: CustomizedTextWidget(
                                        color: Colors.white,
                                        fontSize: 18,
                                        textValue: IntlKeys.personal_setting.tr),
                                  ),
                                ),
                                GestureDetector(

                                  onTap: (){

                                    controller.updateUserProfile();

                                  },

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                Row(
                                  children: [
                            ClipOval(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Text(
                                        "R",
                                        style: TextStyle(color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          InputTextField(
                                            textColors: kTextColor,
                                            text: IntlKeys.user_first_name.tr,
                                            controller: controller.userFirstName,
                                            inputType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return IntlKeys.required.tr;
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          InputTextField(
                                            textColors: kTextColor,
                                            text: IntlKeys.user_last_name.tr,
                                            controller: controller.userLastName,
                                            inputType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return IntlKeys.required.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.grey,
                                        child: Center(
                                          child: Icon(Icons.phone,size: 20,),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: InputTextField(
                                          textColors: kTextColor,
                                          text: IntlKeys.phone_number.tr,
                                          controller: controller.userPhoneNumberController,
                                          inputType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return IntlKeys.required.tr;
                                            }
                                            return null;
                                          }),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.grey,
                                        child: Center(
                                          child:Icon(Icons.email,size: 20,),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: InputTextField(
                                          textColors: kTextColor,
                                          text: IntlKeys.email_id.tr,
                                          controller: controller.emailController,
                                          inputType: TextInputType.name,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return IntlKeys.required.tr;
                                            }
                                            return null;
                                          }),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 20,),

                                Row(
                                  children: [

                                    ClipOval(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.grey,
                                        child: Center(
                                          child:Icon(Icons.male,size: 20,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),


                                    Flexible(
                                      child: DropdownButton(
                                        isExpanded: true,
                                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                                          hint: CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: "Select Gender"),
                                          onChanged: (newValue) {
                                            controller.selectedDrowpdown=newValue.toString();
                                            controller.update();
                                          },
                                          value: controller.selectedDrowpdown,
                                          items: [
                                            for (var data in controller.dropdownText)
                                              DropdownMenuItem(
                                                child: CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 15, textValue: data),
                                                value: data,
                                              )
                                          ]),
                                    )



                                  ],
                                ),

                                SizedBox(height: 20,),



                              ],



                            ),
                          ),
                        ),



                      ],
                  ),
                    );
                })));
  }


}
