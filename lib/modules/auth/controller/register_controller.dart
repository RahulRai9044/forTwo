
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/model/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/dashboard/view/dashboard_screen.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class RegisterController extends GetxController {

  final AuthService _auth = AuthService();

  late TextEditingController userFirstName;
  late TextEditingController userLastName;
  late TextEditingController emailController;
  late TextEditingController userPhoneNumberController;
  late TextEditingController userAddressController;
  late TextEditingController userDateOfBirthController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController userDobController;

  var selectedDrowpdown = IntlKeys.male.tr;
  List dropdownText = [IntlKeys.male.tr, IntlKeys.female.tr, IntlKeys.other.tr,IntlKeys.pnots.tr];


  late GlobalKey<FormState> formKey;

  bool isLoading = false;
  AuthUserModel? _registerUser;
  AuthUserModel? get register => _registerUser;
  bool isObsecure = true;
  bool isObsecureCNF = true;

  String userLoginType="normal";
  String userLoginProvider="";
  String userLoginId="";
  bool passwordFieldVisibility=true;


  String? token;
  String? userID = '';
  bool? isChecked = false;
  String? userData;
  String? gender;
  // Default Radio Button Selected Item When App Starts.

  // Group Value for Radio Button.
  int id = 1;

  DateTime selectedDate = DateTime(2015,12,01);


  Future<Null> selectDate(DateTime date) async {
    final f = new DateFormat('yyyy-MM-dd');
    userDateOfBirthController.text = f.format(date);
    update();
  }




  registerNewUserData() async {
   // String fcmToken = await _prefs.getFCMToken();
    try {
      isLoading = true;
      _registerUser = await _auth.verifyOtpAndRegister(
        firstName: userFirstName.text,
        lastName: userLastName.text,
        userEmail: emailController.text,
        userPassword: passwordController.text,
        userPhoneNumber: userPhoneNumberController.text,
        userStatus: 'active',
        userRole: 'user',
        userDOB: userDateOfBirthController.text,
        userGender: selectedDrowpdown,
        userMemberType: 'free_user',
        userSelectedLanguage: 'english',
        userLoginType: userLoginType,
        userLoginProvider: userLoginProvider,
        userLoginId: userLoginId,
      );

      if (_registerUser?.status == AppConstants.StatusSuccess) {
        isLoading = false;
        token = _registerUser?.token;
        userID = _registerUser?.user.id;

        if(_registerUser?.user.socialLoginId != null){

          await Prefrence.setUserID(userID);
          await Prefrence.setToken(token);
          await Prefrence.setUserEmail(_registerUser?.user.email);
          await Prefrence.setUserWishLimit(_registerUser!.user.wishes_plan_limit);
          await ApplicationUtils.showSnackBar(titleText: _registerUser?.statusCode, messageText: _registerUser?.msg);
          Get.offAll(() =>  DashboardScreen());


        }else{


          await Prefrence.setUserID(userID);
          await Prefrence.setToken(token);
          await Prefrence.setUserEmail(_registerUser?.user.email);
          await Prefrence.setUserWishLimit(_registerUser!.user.wishes_plan_limit);
          await ApplicationUtils.showSnackBar(titleText: _registerUser?.statusCode, messageText: _registerUser?.msg);
          Get.offAll(() =>  LoginScreen());

        }



      } else {

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
    }

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

  toggleCheckBox(bool? value) {
    isChecked = value;

    update();
  }



  @override
  void onInit() {
    super.onInit();
    userFirstName = TextEditingController();
    userLastName = TextEditingController();
    emailController = TextEditingController();
    userPhoneNumberController = TextEditingController();
    userAddressController = TextEditingController();
    userDateOfBirthController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userDobController = TextEditingController();

    if(Get.arguments != null){
      User socialLoginUser=Get.arguments;

      if(socialLoginUser.email != null){

        emailController.text=socialLoginUser.email!;
      }
      if(socialLoginUser.phoneNumber != null){

        userPhoneNumberController.text=socialLoginUser.phoneNumber ?? "";
      }
      if(socialLoginUser.uid.isNotEmpty){

        passwordController.text=socialLoginUser.uid;
        confirmPasswordController.text=socialLoginUser.uid;

        userLoginType="social";

        userLoginProvider="google";

        userLoginId=socialLoginUser.uid;

         passwordFieldVisibility=false;

      }

      userLoginType="social";


      if(socialLoginUser.displayName != null){

        userFirstName.text=socialLoginUser.displayName ?? "";
      }
      if(socialLoginUser.email != null){

        emailController.text=socialLoginUser.email!;
      }
      print("Social Login Data");
      print(socialLoginUser);
      print("Social Login Data");
    }

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    userFirstName.dispose();
    userLastName.dispose();
    emailController.dispose();
    userPhoneNumberController.dispose();
    userDateOfBirthController.dispose();
    userAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userDobController.dispose();
  }
}
