
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/model/register.dart';
import 'package:for_two/modules/auth/model/send_otp.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:get/get.dart';


class RegisterController extends GetxController {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController userPhoneNumberController;
  late TextEditingController userZipcodeController;
  late TextEditingController userStateController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController otpController;
  late GlobalKey<FormState> formKey;

  bool isLoading = false;
  SendOtp? _sendOtp;
  SendOtp? get sendotp => _sendOtp;
  Register? _registerUser;
  Register? get register => _registerUser;
  bool isObsecure = true;
  bool isObsecureCNF = true;

  String? token;
  String? patientID = '';
  bool? isChecked = false;
  String? userData;

  CollectionReference mUserFirebaseInstance = FirebaseFirestore.instance.collection('userData');


   Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
     required String userPhoneNumber,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;

      if(user?.uid != null){

      EasyLoading.show(status: 'Please wait');

       addUser(userUID:user!.uid,userName:name,userEmail:email,userPhoneNumber: userPhoneNumber,isLogin: false);

      }else{



      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ApplicationUtils.showSnackBar(
            titleText: "Failed", messageText: 'The account already exists for that email.');

      }
    } catch (e) {
      print(e);
    }

    return user;
  }


  Future<User?> addUser ({
  required String userUID,
  required String userName,
  required String userEmail,
  required String userPhoneNumber,
  required bool isLogin})
    async{
      try {
         await mUserFirebaseInstance.doc(userUID).set({
           'userUid': userUID,
           'userName': userName,
           'userEmail': userEmail,
           'userPhoneNumber': userPhoneNumber,
           'isLogin': isLogin
         }).then((value) => {

              if(EasyLoading.isShow){

                EasyLoading.dismiss()

              }else{

                EasyLoading.dismiss()

              },

             Get.offAll(() => const LoginScreen()),

         });

      }  on FirebaseException catch(e){
         EasyLoading.dismiss();
         ApplicationUtils.showSnackBar(
            titleText: "Failed", messageText: e.message);

      }
      return null;

    }


  /*verifyAndRegister() async {
    String fcmToken = await _prefs.getFCMToken();
    try {
      isLoading = true;
      _registerUser = await _auth.registerNewUser(
        userEmail: emailController.text,
        userOTP: otpController.text,
        userPassword: passwordController.text,
        userFcmToken: fcmToken,
        userName: userNameController.text,
        privacyConsent: isChecked ?? true,
      );
      debugPrint("register ${_registerUser?.msg}");
      debugPrint("register ${_registerUser?.status}");
      if (_registerUser?.status == "Success") {
        isLoading = false;
        token = _registerUser?.data?.loginToken;
        patientID = _registerUser?.data?.sId;
        await _prefs.setPatientID(patientID);
        await Prefrence.setToken(token);
        await ApplicationUtils.showSnackBar(
            titleText: _registerUser?.status, messageText: _registerUser?.msg);
        Get.offAll(() => const LoginScreen());
      } else {
        ApplicationUtils.showSnackBar(
            titleText: _registerUser?.status, messageText: _registerUser?.msg);
      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
    }
    update();
  }*/

  showPassword() {
    isObsecure = !isObsecure;
    update();
  }

  showPasswordCNF() {
    isObsecureCNF = !isObsecureCNF;
    update();
  }

  toggleCheckBox(bool? value) {
    isChecked = value;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    userPhoneNumberController = TextEditingController();
    userStateController = TextEditingController();
    userZipcodeController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    otpController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    userPhoneNumberController.dispose();
    userStateController.dispose();
    userZipcodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
  }
}
