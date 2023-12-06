import 'dart:async';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/model/VerifiedPassModel.dart';
import 'package:for_two/modules/auth/model/send_otp.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConnectPartnerController extends GetxController {
  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();
  late TextEditingController otpController;
  late TextEditingController partnerEmailController;
  late TextEditingController partnerNameController;
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

  late String userEmail='';


  bool isChangePassowrdFieldVisible = false;
  bool isResendOTP = false;
  bool isOtpVisible=false;
  double current_opacity=0.4;
  double current_opacity_reset=0.1;





  onTimerComplete() {
    isResendOTP = true;
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


  partnerConnectSendOtp() async {
    try {
      isLoading = true;
      _sendOtp = await _auth.partnerSendConnectOtp(
        userEmail: userEmail,
        partnerEmail: partnerEmailController.text,
        partnerName: partnerNameController.text,
      );
      debugPrint("register ${_sendOtp?.msg}");

      if (_sendOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;
        debugPrint("register ${_sendOtp?.data}");
        await ApplicationUtils.showSnackBar(titleText: _sendOtp?.status, messageText: _sendOtp?.msg);

        isOtpVisible=true;


      } else {
        isOtpVisible=false;
        isLoading = false;
      }
    } catch (e) {
      isOtpVisible=false;
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();


  }


  verifyOtpRegisterPartner() async {
    try {
      isLoading = true;
      _verifiedOtp = await _auth.partnerVerifyOtpPassword(
        userEmail: partnerEmailController.text,
        partnerEmail: userEmail,
        partnerOtpCode:otpController.text,
      );

      if (_verifiedOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;


        debugPrint("register ${_verifiedOtp?.statusCode}");
        ApplicationUtils.showSnackBar(titleText: _verifiedOtp?.status, messageText: _verifiedOtp?.msg);
        String userId= await _prefs.getUserId();
        DashboardController controller = Get.find<DashboardController>();
        controller.userAndPartnerDataModel(userId);

        Get.back(closeOverlays: true);

        debugPrint("register ${_verifiedOtp?.status}");
      } else {
        isLoading = false;
        ApplicationUtils.showSnackBar(titleText: _verifiedOtp?.status, messageText: _verifiedOtp?.msg);

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;

    }

    update();


  }



  @override
  Future<void> onInit() async {
    super.onInit();
    otpController = TextEditingController();
    partnerEmailController = TextEditingController();
    partnerNameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();

    String? userEmailId = await _prefs.getUserEmail();
    if(userEmailId!.isNotEmpty){

      userEmail=userEmailId;

    }else{


    }


  }

  @override
  void dispose() {
    super.dispose();
    partnerEmailController.dispose();
    partnerNameController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    errorController.close();
  }

  void updateView() {

    isOtpFieldVisible=true;
    update();

  }
}
