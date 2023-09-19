import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/view/check_your_mail.dart';
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
            return Container(
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

                    CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: 'Forgot Password'),

                    const SizedBox(height: 20),

                    Align(
                        alignment: Alignment.centerLeft,
                        child:CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 20, textValue: 'Please enter your registered email to reset your password.')),
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
                        text: 'Email ID'),
                    const SizedBox(height: 30),



                    Opacity(
                      opacity: controller.current_opacity,
                      child: CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 1.0,
                        title: 'Send Code',
                        onTap: () async {
                          var isValid =
                          controller.formKey.currentState!.validate();
                          if (isValid) {
                            //   await controller.sendOtpForPasswordChange();

                            Get.off(CheckYourMail());

                          }
                        },
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // Visibility(
                    //   visible: controller.isOtpFieldVisible,
                    //   child: Column(
                    //     children: [
                    //       const Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text('OTP')),
                    //       const SizedBox(height: 20),
                    //       PinCodeTextField(
                    //         appContext: context,
                    //         length: 4,
                    //         keyboardType: TextInputType.number,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly
                    //         ], // Only numbers can be entered
                    //         obscureText: false,
                    //         obscuringCharacter: '*',
                    //         animationType: AnimationType.fade,
                    //         pinTheme: PinTheme(
                    //           shape: PinCodeFieldShape.box,
                    //           borderRadius: BorderRadius.circular(5),
                    //           fieldHeight: 40,
                    //           fieldWidth: 60,
                    //           activeFillColor: Colors.white,
                    //         ),
                    //         animationDuration:
                    //             const Duration(milliseconds: 300),
                    //         backgroundColor: Colors.white,
                    //         enableActiveFill: false,
                    //         errorAnimationController:
                    //             controller.errorController,
                    //         controller: controller.otpController,
                    //         onCompleted: (value) async {
                    //           controller.otpController.text = value;
                    //         //  await controller.verifyOtp();
                    //         },
                    //         onChanged: (value) async {},
                    //         beforeTextPaste: (text) {
                    //           return true;
                    //         },
                    //       ),
                    //      /* TextButton(
                    //         onPressed: controller.isResendOTP
                    //             ? () async {
                    //                 controller.resendOtp();
                    //               }
                    //             : null,
                    //         child: Text(
                    //           'Resend OTP',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText2
                    //               ?.copyWith(
                    //                   color: controller.isResendOTP
                    //                       ? kBlackColor?.withOpacity(0.7)
                    //                       : kBlackColor?.withOpacity(0.3)),
                    //         ),
                    //       ),*/
                    //       /*Countdown(
                    //         seconds: 60,
                    //         build: (BuildContext context, double time) =>
                    //             Text(time.toStringAsFixed(0)),
                    //         interval: const Duration(seconds: 1),
                    //         onFinished: controller.onTimerComplete,
                    //         controller: controller.countdownController,
                    //       ),*/
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Expanded(
                    //   child: Visibility(
                    //     visible: controller.isChangePassowrdFieldVisible,
                    //     child: Form(
                    //       key: controller.formKey2,
                    //       child: Column(
                    //         children: [
                    //           InputTextField(
                    //             textColors: kWhiteColor,
                    //             text: "Password*",
                    //             controller: controller.passwordController,
                    //             inputType: TextInputType.text,
                    //             isVisible: controller.isObsecure,
                    //             icon: controller.isObsecure
                    //                 ? Icons.visibility_off
                    //                 : Icons.visibility,
                    //             onTap: controller.showPassword,
                    //             validator: (value) {
                    //               if (value!.isEmpty) {
                    //                 return 'Password can not be empty';
                    //               }
                    //               return null;
                    //             },
                    //           ),
                    //           const SizedBox(height: 10),
                    //           InputTextField(
                    //             textColors: kWhiteColor,
                    //             text: "Confirm Password*",
                    //             controller:
                    //                 controller.confirmPasswordController,
                    //             inputType: TextInputType.text,
                    //             isVisible: controller.isObsecureCNF,
                    //             icon: controller.isObsecure
                    //                 ? Icons.visibility_off
                    //                 : Icons.visibility,
                    //             onTap: controller.showPasswordCNF,
                    //             validator: (value) {
                    //               if (value!.isEmpty) {
                    //                 return 'Password can not be empty';
                    //               } else if (value !=
                    //                   controller.passwordController.text) {
                    //                 return "Password did not match.Try Again";
                    //               } else {
                    //                 return null;
                    //               }
                    //             },
                    //           ),
                    //           const SizedBox(height: 30),
                    //           ElevatedButton(
                    //             style: ElevatedButton.styleFrom(
                    //               shape: const RoundedRectangleBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(20)),
                    //               ),
                    //               backgroundColor: kPrimaryColor,
                    //               fixedSize: Size(
                    //                 size.width,
                    //                 50,
                    //               ),
                    //             ),
                    //             onPressed: () async {
                    //               bool isValid = controller
                    //                   .formKey2.currentState!
                    //                   .validate();
                    //               if (isValid) {
                    //                 EasyLoading.show();
                    //                 await controller.changePasswordandLogin();
                    //                 EasyLoading.dismiss();
                    //               }
                    //             },
                    //             child: const Text('Change Password'),
                    //           ),
                    //           const SizedBox(height: 10),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
