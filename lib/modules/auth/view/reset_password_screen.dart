import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/view/check_your_mail.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:  Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () => Get.back(),
            ),
          ),
          body: GetBuilder<ForgotPasswordController>(
              init: ForgotPasswordController(),
              builder: (controller) {
                return Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: 'Reset Password'),

                               SizedBox(height: 20.0),

                              CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 20, textValue: 'Please enter your new password and confirm the password'),

                               SizedBox(height: size.height * 0.05),

                              InputTextField(
                                textColors: kTextColor,
                                text: "New Password",
                                controller:
                                controller.passwordController,
                                inputType: TextInputType.text,
                                isVisible: controller.isObsecure,
                                icon: controller.isObsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                onTap: controller.showPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required*';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InputTextField(
                                textColors: kTextColor,
                                text: "Confirm Password",
                                controller: controller
                                    .confirmPasswordController,
                                inputType: TextInputType.text,
                                isVisible: controller.isObsecureCNF,
                                icon: controller.isObsecureCNF
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                onTap: controller.showPasswordCNF,
                                onChange: (newValue) {
                                  controller.checkEnteredPassword(newValue);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required*';
                                  } else if (value !=
                                      controller
                                          .passwordController.text) {
                                    return "Password did not match.Try Again";
                                  } else {
                                    return null;
                                  }
                                },
                              ),


                            ],
                          ),

                           SizedBox(height: size.height * 0.08),

                          Opacity(
                            opacity: controller.current_opacity_reset,
                            child: CommonElevatedButton(
                              height: size.height * 0.05,
                              width: size.width * 0.80,
                              title: 'Update',
                              onTap: () async {
                                var isValid =
                                controller.formKey.currentState!.validate();
                                if (isValid) {
                                  //   await controller.sendOtpForPasswordChange();

                                  Get.put(CheckYourMail());

                                }
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
