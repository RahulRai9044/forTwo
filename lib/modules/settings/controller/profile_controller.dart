

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/model/register.dart';
import 'package:for_two/modules/settings/model/upload_user_data.dart';
import 'package:for_two/modules/settings/model/user_profile_data.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  bool isLoading = false;
  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();

  late TextEditingController userFirstName;
  late TextEditingController userLastName;
  late TextEditingController emailController;
  late TextEditingController userPhoneNumberController;
  late TextEditingController userLocationController;
  late TextEditingController userStateController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController otpController;
  late GlobalKey<FormState> formKey;

  var selectedDrowpdown =IntlKeys.male.tr;
  List dropdownText = [IntlKeys.male.tr, IntlKeys.female.tr, IntlKeys.other.tr,IntlKeys.pnots.tr];

  final _picker = ImagePicker();

  UpdateUserProfileData? _updateUserProfileData;
  UpdateUserProfileData? get updateUserProfleData => _updateUserProfileData;

  UserProfileData? _userProfileData;
  UserProfileData? get userData => _userProfileData;

  String? gender;

   String userprofileImage="";

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'Female';

  // Group Value for Radio Button.
  int id = 1;
  Rx<XFile> image = XFile('').obs;


  Future<void> btnPickImageTap(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (pickedFile != null) {
      Get.back();
      image.value = XFile(pickedFile.path,mimeType:"image/png");

    } else {
      Get.back();
      print('No image selected.');
    }

    print(image.value.path);
      updateUserProfile();
    print("Rahul");
  }

 /* Future<void> btnPickImageTap(ImageSource imageSource) async {
    File?  selectImageFile = (await MediaPicker.pickMedia(
      source: imageSource,
      isEditing: true, // Default false
    ))!;

   //

     if (selectImageFile.path.isNotEmpty) {
       Get.back();
       image.value = XFile(selectImageFile.path,mimeType: "image/png");

     } else {
       Get.back();
       print('No image selected.');
     }

    print(image);
  //  updateUserProfile();
     print("Rahul");

  }*/


  final List<Map> myProducts =[
    {"image": 'influencer_badge.png', "name": "Influencer","visibility":true,"badge_count":1.0},
    {"image": 'dreamer.png', "name": "Dreamer","visibility":true,"badge_count":2.0},
    {"image": 'trailblazer.png', "name": "Trailblazer","visibility":true,"badge_count":3.0},
    {"image": 'gifter.png', "name": "Gifter","visibility":true,"badge_count":4.0},
    {"image": 'surprise_badge.png', "name": "Coming Soon","visibility":false,"badge_count":0.0},
    {"image": 'comming_soon_badge.png', "name": "Coming Soon","visibility":false,"badge_count":0.0},

  ];


  getUserProfileData(String userId) async {
    try {
      isLoading = true;
      _userProfileData = await _auth.getUserProfileData(userId: userId);

      if (_userProfileData?.status == AppConstants.StatusSuccess) {


        if(_userProfileData!.result.isNotEmpty){

          userFirstName.text=_userProfileData!.result[0].firstName;
          userLastName.text=_userProfileData!.result[0].lastName;
          userPhoneNumberController.text=_userProfileData!.result[0].phone;
          emailController.text=_userProfileData!.result[0].email;
          userLocationController.text=_userProfileData!.result[0].firstName;
          await Prefrence.setPartnerUserID(_userProfileData!.result[0].partnerId);

          userprofileImage=_userProfileData!.result[0].userImg;

          print(_prefs.getPartnerId());
          print("_prefs.getPartnerId()");
     //     selectedDrowpdown=_userProfileData!.result[0].gender;
          isLoading = false;
        }else{

          isLoading = false;

        }

      } else {

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }
    update();

  }

  updateUserProfile() async {
    String userId = await _prefs.getUserId();
    try {
      isLoading = true;
      _updateUserProfileData = await _auth.userUpdateProfile(
        firstName: userFirstName.text,
        lastName: userLastName.text,
        userEmail: emailController.text,
        userPhoneNumber: userPhoneNumberController.text,
        userId: userId,
        wishPlanLimit: 10,
        userImage:image.value.path,
      );

      if (_updateUserProfileData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        if(_updateUserProfileData?.data != null){

          await Prefrence.setUserEmail(_updateUserProfileData!.data!.email);
          await ApplicationUtils.showSnackBar(titleText: _updateUserProfileData?.statusCode, messageText: _updateUserProfileData?.message);

          getUserProfileData(userId);

          update();

        }else{

          await ApplicationUtils.showSnackBar(titleText: _updateUserProfileData?.statusCode, messageText: _updateUserProfileData?.message);
          update();

        }



      } else {

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
    }

    update();
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    userFirstName = TextEditingController();
    userLastName = TextEditingController();
    emailController = TextEditingController();
    userPhoneNumberController = TextEditingController();
    userStateController = TextEditingController();
    userLocationController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    otpController = TextEditingController();

    formKey = GlobalKey<FormState>();

    String? userDetail = await _prefs.getUserId();
    if(userDetail.isNotEmpty){

      getUserProfileData(userDetail);

    }else{


    }

  }

  @override
  void dispose() {
    super.dispose();
    userFirstName.dispose();
    userLastName.dispose();
    emailController.dispose();
    userPhoneNumberController.dispose();
    userStateController.dispose();
    userLocationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
  }

}