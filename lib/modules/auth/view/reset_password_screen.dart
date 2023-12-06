import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/controller/reset_password_controller.dart';
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
       resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:  Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () => Get.back(),
            ),
          ),
          body: GetBuilder<ResetPasswordController>(
              init: ResetPasswordController(),
              builder: (controller) {
                return controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomizedTextWidget(color: buttonFirstColor, fontSize: 20, textValue: 'Reset Password'),

                             SizedBox(height: 20.0),

                            CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 16, textValue: 'Please enter your new password and confirm the password'),

                             SizedBox(height: size.height * 0.05),

                            InputTextField(
                              textColors: kTextColor,
                              text: IntlKeys.new_password.tr,
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
                                  return IntlKeys.required.tr;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputTextField(
                              textColors: kTextColor,
                               text: IntlKeys.cnf_password.tr,
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
                                  return IntlKeys.required.tr;
                                } else if (value !=
                                    controller
                                        .passwordController.text) {
                                  return IntlKeys.pass_not_match_try.tr;
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

                                  await controller.resetPasswordDetails();

                              }
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
