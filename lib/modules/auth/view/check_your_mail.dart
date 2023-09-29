import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/view/reset_password_screen.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CheckYourMail extends StatelessWidget {
  const CheckYourMail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: GetBuilder<ForgotPasswordController>(
              init: ForgotPasswordController(),
              builder: (controller) {
                return Container(
                  color: Colors.white,
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: (){

                          Get.back();

                        },
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.close,size: 30,color: kBlackColor,)),
                      ),

                      SizedBox(height: size.height * 0.02),
                      Image.asset(
                        "assets/images/mail_invitation_image.png",
                        height: size.height * 0.4,
                        width: size.width * 0.4,
                      ),

                      Center(child: CustomizedTextWidget(color: buttonFirstColor, fontSize: 24, textValue:IntlKeys.check_your_mail.tr,fontWeight: FontWeight.w700,)),
                      const SizedBox(height: 20),

                      Center(child: CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: IntlKeys.reset_password_link.tr,fontWeight: FontWeight.normal,)),

                      Visibility(
                        visible: false,
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 40,
                            fieldWidth: 60,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration:
                          const Duration(milliseconds: 300),
                          backgroundColor: Colors.white,
                          enableActiveFill: false,
                          errorAnimationController:
                          controller.errorController,
                          controller: controller.otpController,
                          onCompleted: (value) async {
                            controller.otpController.text = value;
                            //  await controller.verifyOtp();
                          },
                          onChanged: (value) async {},
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 0.60,
                        title: IntlKeys.go_to_mail.tr,
                        onTap: () async {

                            //   await controller.sendOtpForPasswordChange();

                            Get.off(const ResetPasswordScreen());


                        },
                      )
                      /* TextButton(
                    onPressed: controller.isResendOTP
                        ? () async {
                            controller.resendOtp();
                          }
                        : null,
                    child: Text(
                      'Resend OTP',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                              color: controller.isResendOTP
                                  ? kBlackColor?.withOpacity(0.7)
                                  : kBlackColor?.withOpacity(0.3)),
                    ),
                  ),*/
                      /*Countdown(
                    seconds: 60,
                    build: (BuildContext context, double time) =>
                        Text(time.toStringAsFixed(0)),
                    interval: const Duration(seconds: 1),
                    onFinished: controller.onTimerComplete,
                    controller: controller.countdownController,
                  ),*/
                    ],
                  ),
                );
              }),
        ));
  }
}
