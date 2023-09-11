import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/model/user.dart';
import 'package:for_two/modules/dashboard/view/dashboard_screen.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginController extends GetxController {
  final Prefrence mPrefs = Prefrence();

  User? _loginUser;
  User? get loginUser => _loginUser;

  bool isLoading = false;

  bool isObsecure = true;
  String? token;
  String? userData;
  String? patientID;

 CollectionReference mUserFirebaseInstance = FirebaseFirestore.instance.collection('userData');

  late TextEditingController emailController, passwordController;
  late GlobalKey<FormState> loginFormKey;

  showPassword() {
    isObsecure = !isObsecure;
    update();
  }


 Future<User?> signInUserWithEmailAndPassword({
   required String email,
   required String password,
 }) async {
   FirebaseAuth auth = FirebaseAuth.instance;
   User? user;

   try {
     UserCredential userCredential = await auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );

     user = userCredential.user;


     user = auth.currentUser;

     if(user?.uid != null){

       EasyLoading.show(status: 'Please wait');

       String fcmToken = await mPrefs.getFCMToken();

       updateUserData(userUID:user!.uid,isLogin: true,fcmToken: fcmToken);

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


 Future<User?> updateUserData ({
   required String userUID,
   required bool isLogin,
   required String fcmToken})
 async{
   try {
     await mUserFirebaseInstance.doc(userUID).update({
       'userUid': userUID,
       'isLogin': isLogin,
       'userFCmToken': fcmToken
     }).then((value) => {

       mPrefs.setUserID(userUID),

       if(EasyLoading.isShow){

         EasyLoading.dismiss()

       }else{

         EasyLoading.dismiss()

       },

       getUserData(userUID),



     //

     });

   }  on FirebaseException catch(e){
     EasyLoading.dismiss();
     ApplicationUtils.showSnackBar(
         titleText: "Failed", messageText: e.message);

   }
   return null;

 }

 Future<void> getUserData(String userUID) async {
   final collection = await mUserFirebaseInstance.doc(userUID).get();
   Map<String, dynamic> data = collection.data() as Map<String, dynamic>;

   UserData userData=UserData.fromJson(data);

   if(userData.userPhoneNumber.isNotEmpty){

     mPrefs.setUserPhoneNumber(userData.userPhoneNumber);


     Get.offAll(() => DashboardScreen());

   }else{


     ApplicationUtils.showSnackBar(
         titleText: "Failed", messageText: 'User phone number not to be empty');


   }

   print(data);
 }

  @override
  void onInit() {
    super.onInit();
   // getFcmTokenn();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();
  }



  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }






  bool _userLoginAutoValidate=false;

  TextEditingController _passwordController=TextEditingController();

  TextEditingController _userIdController =TextEditingController();

  bool _passwordVisible=false;

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool value) {
    _passwordVisible = value;
   update();
  }

  TextEditingController get userIdController => _userIdController;

  set userIdController(TextEditingController value) {
    _userIdController = value;
    update();
  }

  TextEditingController get passwordControllers => _passwordController;

  set passwordControllers(TextEditingController value) {
    _passwordController = value;
    update();
  }

  bool get userLoginAutoValidate => _userLoginAutoValidate;
  set userLoginAutoValidate(bool value) {
    _userLoginAutoValidate = value;
    update();
  }



  clearAllModels(){
    _userLoginAutoValidate=false;
    _passwordController=TextEditingController();
    _userIdController=TextEditingController();
    _passwordVisible=false;
  }


  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;


  loginFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      _userData = userInfo;
      print('ResultStatus: ${_userData}');
      print('Message: ${_userData!.values}');
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }

}
