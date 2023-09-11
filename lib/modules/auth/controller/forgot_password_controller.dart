import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/model/changepassword.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _auth = AuthService();
  // final Prefrence _prefs = Prefrence();
  late TextEditingController otpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late StreamController<ErrorAnimationType> errorController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  // ChangePasswordSendOTP? otpData;
  // VerifyOTP? verifiedOTP;
  bool isLoading = true;
  ChangePassword? _changePassword;
  ChangePassword? get changePassword => _changePassword;

  bool isOtpFieldVisible = false;
  bool isChangePassowrdFieldVisible = false;
  bool isObsecure = true;
  bool isObsecureCNF = true;
  bool isResendOTP = false;

  onTimerComplete() {
    isResendOTP = true;
    update();
  }

  showPassword() {
    isObsecure = !isObsecure;
    update();
  }

  showPasswordCNF() {
    isObsecureCNF = !isObsecureCNF;
    update();
  }

  // resendOtp() async {
  //   isResendOTP = false;
  //   await sendOtpForPasswordChange();
  //   otpController.clear();
  //   countdownController.restart();
  // }

  // sendOtpForPasswordChange() async {
  //   isLoading = true;
  //   otpData = await _auth.sendOTPForChangePassword(emailController.text);
  //   if (otpData?.status == 'Success') {
  //     isLoading = false;
  //     isOtpFieldVisible = true;
  //   } else {
  //     isLoading = false;
  //     ApplicationUtils.showSnackBar(
  //         titleText: otpData?.status, messageText: otpData?.msg);
  //   }
  //   update();
  // }

 /* verifyOtp() async {
    try {
      isLoading = true;
      verifiedOTP = await _auth.verifyOTPChangePass(
          emailController.text, otpController.text);

      if (verifiedOTP?.status == "Success") {
        isLoading = false;
        isChangePassowrdFieldVisible = true;
        await Prefrence.setToken(verifiedOTP?.data?.loginToken);
        ApplicationUtils.showSnackBar(
            titleText: verifiedOTP?.status, messageText: verifiedOTP?.msg);
      } else {
        isLoading = false;

        isChangePassowrdFieldVisible = false;
        ApplicationUtils.showSnackBar(
            titleText: "Failed", messageText: "Invalid OTP");
      }
    } catch (e) {
      isLoading = false;

      debugPrint(e.toString());
    }

    update();
  }*/

  changePasswordandLogin() async {
    try {
      isLoading = true;
      _changePassword = await _auth.changePassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (_changePassword?.status == "Success") {
        isLoading = false;
        ApplicationUtils.showSnackBar(
            titleText: _changePassword?.status,
            messageText: _changePassword?.msg);
        Get.offAll(() => const LoginScreen());
      } else {
        isLoading = false;
        ApplicationUtils.showSnackBar(
            titleText: _changePassword?.status,
            messageText: _changePassword?.msg);
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  /*inputOtp(String otp) async {
    otpController.text = otp;
    await verifyOtp();
    update();
  }*/

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    errorController.close();
  }
}
