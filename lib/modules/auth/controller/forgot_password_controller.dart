import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/model/VerifiedPassModel.dart';
import 'package:for_two/modules/auth/model/changepassword.dart';
import 'package:for_two/modules/auth/model/send_otp.dart';
import 'package:for_two/modules/auth/view/check_your_mail.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/view/reset_password_screen.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
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
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SendOtpModel? _sendOtp;
  SendOtpModel? get sendotp => _sendOtp;

  VerifiedPassModel? _verifiedOtp;
  VerifiedPassModel? get verifiedOtp => _verifiedOtp;

  bool isLoading = false;
  SendOtpModel? _changePassword;
  SendOtpModel? get changePassword => _changePassword;

  bool isOtpFieldVisible = false;


  bool isChangePassowrdFieldVisible = false;
  bool isObsecure = true;
  bool isObsecureCNF = true;
  bool isResendOTP = false;
  double current_opacity=0.4;
  double current_opacity_reset=0.1;





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

 double checkEnteredEmail(String emails) {
    var email = emails;
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
    print (emailValid); // true
    if(emailValid){
      current_opacity=1.0;
      update();
    }else{
      current_opacity=0.4;
      update();
    }
    return current_opacity;
  }

  double checkEnteredPassword(String emails) {
    if(passwordController.text == emails){

      current_opacity_reset=1.0;

      update();
      }else{

      current_opacity_reset=0.1;

      update();

    }

    return current_opacity_reset;

  }

  sendOTPForForgetPassword() async {
    try {
      isLoading = true;
      _sendOtp = await _auth.sendOtpForForgetPassword(
        userEmail: emailController.text,
      );
      debugPrint("register ${_sendOtp?.msg}");

      if (_sendOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;
         debugPrint("register ${_sendOtp?.data}");
        await ApplicationUtils.showSnackBar(titleText: _sendOtp?.status, messageText: _sendOtp?.msg);

        Get.off(CheckYourMail());

      } else {


      }
    } catch (e) {

      debugPrint("catch Error ${e.toString()}");

    }

    update();


  }


  verifyOtpChangePassword() async {
    try {
      isLoading = true;
      _verifiedOtp = await _auth.verifyOTPForgetPassword(
        userEmail: emailController.text,
        changePasswordOTP: otpController.text,
      );
      debugPrint("register ${_verifiedOtp?.msg}");
      debugPrint("register ${_verifiedOtp?.statusCode}");
      if (_verifiedOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        await ApplicationUtils.showSnackBar(titleText: _verifiedOtp?.status, messageText: _verifiedOtp?.msg);

        Get.off(const ResetPasswordScreen(),arguments: [{"user_email": emailController.text}, {"user_otp": otpController.text}]);

      } else {

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      ApplicationUtils.showSnackBar(
          titleText: _verifiedOtp?.status, messageText: _verifiedOtp?.msg);

    }


  }



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

  void updateView() {

    isOtpFieldVisible=true;
    update();

  }
}
