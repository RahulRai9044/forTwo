import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/wishlists/controller/new_wish_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class AddNewWish extends StatelessWidget {
  const AddNewWish({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomizedTextWidget(
          color: buttonFirstColor,
          fontSize: 25,
          textValue: 'Add new wish',
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<AddNewWishController>(
          init: AddNewWishController(),
          builder: (controller) {
            return Container(
              height: size.height,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextField(
                        controller: controller.wishTitleController,
                        textColors: kTextColor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please enter a correct wish title";
                          }
                          return null;
                        },
                        text: 'Title'),
                    const SizedBox(height: 20),

                    CustomizedTextWidget(
                        color: kTextColor ?? Colors.grey.shade700,
                        fontSize: 15,
                        textValue: 'Select Points'),

                    const SizedBox(height: 20),

                    GridView(
                      shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          childAspectRatio: (1 / .4),
                        ),
                      children: List.generate(5, (index) {

                        return  Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                shape: BoxShape.rectangle,
                                border: new Border.all(
                                  color: Colors.white,
                                  width: 2.0,),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFF01828),
                                  Color(0xFFEF3B85)
                                ])),
                            child: Center(
                                child: CustomizedTextWidget(
                                    color: Colors.white,
                                    fontSize: 16,
                                    textValue: '200 Pts')));


                      })
                    ),


                    const SizedBox(height: 20),

                    InputTextField(
                        controller: controller.wishTitleController,
                        textColors: kTextColor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please enter a correct wish date";
                          }
                          return null;
                        },
                        icon: Icons.calendar_today,
                        text: 'Assign date to fulfill your wish'),

                    const SizedBox(height: 30),

                    Center(
                      child: CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                        title: 'Add Wish',
                        onTap: () async {
                          var isValid =
                          controller.formKey.currentState!.validate();
                          if (isValid) {
                            //   await controller.sendOtpForPasswordChange();

                            // Get.off(CheckYourMail());
                          }
                        },
                      ),
                    ),

                     SizedBox(height: size.height * 0.1),
                    Image.asset(
                      "assets/images/home_bottom.png",
                      height: size.height * 0.1,
                      width: size.height,
                      fit: BoxFit.fitWidth,
                    ),

                    SizedBox(height: size.height * 0.05),

                    Center(child: CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: '\"A couple who plays together \n stays together\"',fontWeight: FontWeight.bold,textAlignment: TextAlign.center,)),

                  ],
                ),
              ),
            );
          }),
    ));
  }
}
