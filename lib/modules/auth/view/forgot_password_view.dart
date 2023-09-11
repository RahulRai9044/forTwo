import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Change Password",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please enter your email address',
                            style: Theme.of(context).textTheme.headline1,
                          )),
                      const SizedBox(height: 20),
                      InputTextField(
                          controller: controller.emailController,
                          textColors: kWhiteColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            } else if (!GetUtils.isEmail(value)) {
                              return "Please enter a correct email address";
                            }
                            return null;
                          },
                          text: 'Email*'),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          backgroundColor: kPrimaryColor,
                          fixedSize: Size(
                            size.width,
                            50,
                          ),
                        ),
                        onPressed: () async {
                          var isValid =
                              controller.formKey.currentState!.validate();
                          if (isValid) {
                         //   await controller.sendOtpForPasswordChange();
                          }
                        },
                        child: const Text('Send Code'),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: controller.isOtpFieldVisible,
                        child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('OTP')),
                            const SizedBox(height: 20),
                            PinCodeTextField(
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
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Visibility(
                          visible: controller.isChangePassowrdFieldVisible,
                          child: Form(
                            key: controller.formKey2,
                            child: Column(
                              children: [
                                InputTextField(
                                  textColors: kWhiteColor,
                                  text: "Password*",
                                  controller: controller.passwordController,
                                  inputType: TextInputType.text,
                                  isVisible: controller.isObsecure,
                                  icon: controller.isObsecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onTap: controller.showPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password can not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                InputTextField(
                                  textColors: kWhiteColor,
                                  text: "Confirm Password*",
                                  controller:
                                      controller.confirmPasswordController,
                                  inputType: TextInputType.text,
                                  isVisible: controller.isObsecureCNF,
                                  icon: controller.isObsecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onTap: controller.showPasswordCNF,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password can not be empty';
                                    } else if (value !=
                                        controller.passwordController.text) {
                                      return "Password did not match.Try Again";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    backgroundColor: kPrimaryColor,
                                    fixedSize: Size(
                                      size.width,
                                      50,
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool isValid = controller
                                        .formKey2.currentState!
                                        .validate();
                                    if (isValid) {
                                      EasyLoading.show();
                                      await controller.changePasswordandLogin();
                                      EasyLoading.dismiss();
                                    }
                                  },
                                  child: const Text('Change Password'),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
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
