import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/controller/login_controller.dart';
import 'package:for_two/modules/auth/controller/register_controller.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/app_icon.png",
                    height: size.height* 0.4,
                    width: size.width* 0.4,
                  ),
                  Text(
                    IntlKeys.enter_code_email.tr+" "+controller.emailController.text,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
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
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: false,
                    errorAnimationController: errorController,
                    controller: controller.otpTextController,
                    onCompleted: (v) {

                    },
                    onChanged: (value) {

                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                      //  await controller.reSendOtp();
                      },
                      child: Text(
                        IntlKeys.resend_code.tr,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  CommonElevatedButton(
                    width: size.width * 0.8,
                      onTap: () async {
                       await controller.verifyOtpAfterRegistration(controller.emailController.text);
                      },
                      title: IntlKeys.get_started.tr,)
                ],
              ),
            );
          }),
    ));
  }
}
