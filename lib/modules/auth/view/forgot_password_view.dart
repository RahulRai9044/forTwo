import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
            return controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
              color: Colors.white,
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: IntlKeys.forgot_password.tr),

                    const SizedBox(height: 20),

                    Align(
                        alignment: Alignment.centerLeft,
                        child:CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 20, textValue: IntlKeys.reset_pass_desc.tr)),
                    const SizedBox(height: 20),
                    InputTextField(
                        controller: controller.emailController,
                        textColors: kTextColor,
                        onChange: (newValue) {
                        controller.checkEnteredEmail(controller.emailController.text);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please enter a correct email address";
                          }
                          return null;
                        },
                        text: IntlKeys.email_id.tr),
                    const SizedBox(height: 30),



                    Opacity(
                      opacity: controller.current_opacity,
                      child: CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 1.0,
                        title: IntlKeys.send_code.tr,
                        onTap: () async {
                          var isValid =
                          controller.formKey.currentState!.validate();
                          if (isValid) {
                              await controller.sendOTPForForgetPassword();



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
