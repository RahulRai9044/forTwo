import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/model/VerifiedPassModel.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordController extends GetxController {
  final AuthService _auth = AuthService();
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late StreamController<ErrorAnimationType> errorController;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  dynamic argumentData = Get.arguments;

  VerifiedPassModel? _verifiedOtp;
  VerifiedPassModel? get verifiedOtp => _verifiedOtp;

  bool isLoading = true;

  bool isOtpFieldVisible = false;


  bool isChangePassowrdFieldVisible = false;
  bool isObsecure = true;
  bool isObsecureCNF = true;
  bool isResendOTP = false;
  double current_opacity_reset=0.1;

  late String _currentEmail;
  late String _currentOtp;





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



  resetPasswordDetails() async {
    try {
      isLoading = true;
      _verifiedOtp = await _auth.changePasswordDetails(
          userEmail: _currentEmail,
          userNewPassword: passwordController.text, changePasswordOTP: _currentOtp);
      if (_verifiedOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;
        ApplicationUtils.showSnackBar(titleText: _verifiedOtp?.status, messageText: _verifiedOtp?.msg);
        Get.offAll(() => const LoginScreen());
      } else {
        isLoading = false;

      }
    } catch (e) {
      isLoading = false;

    }
    update();
  }


  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();


    _currentEmail= argumentData[0]['user_email'];
    _currentOtp=argumentData[1]['user_otp'];


    print(_currentEmail);
    print("_currentEmail");
    print(_currentOtp);
    print("_currentOtp");


    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    errorController.close();
  }

  void updateView() {

    isOtpFieldVisible=true;
    update();

  }
}
