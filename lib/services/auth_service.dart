import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:for_two/modules/auth/model/VerifiedPassModel.dart';
import 'package:for_two/modules/auth/model/error_model.dart';
import 'package:for_two/modules/auth/model/register.dart';
import 'package:for_two/modules/auth/model/send_otp.dart';
import 'package:for_two/modules/calanderPage/model/appointments.dart';
import 'package:for_two/modules/dashboard/model/user_partner_data_model.dart';
import 'package:for_two/modules/evolution/models/evaluations_model.dart';
import 'package:for_two/modules/settings/model/upload_user_data.dart';
import 'package:for_two/modules/settings/model/user_profile_data.dart';
import 'package:for_two/modules/statistics/model/statistics_data.dart';
import 'package:for_two/modules/wishlists/model/my_wishlist_data.dart';
import 'package:for_two/modules/wishlists/model/wish_list_add.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class AuthService {

  String base_url = 'http://16.171.232.15:4002/api';

  Prefrence prefs = Prefrence();


  Future<SendOtpModel> sendOtpForVerifyEmail({
    required String userEmail,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/activation-send-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        SendOtpModel sendOtpModel = SendOtpModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${sendOtpModel.msg}");
        return sendOtpModel;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<SendOtpModel> verifyOTPScreen({
    required String userEmail,
    required String activationOtp,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/activation-send-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
        'activation_otp': activationOtp,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        SendOtpModel sendOtpModel = SendOtpModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${sendOtpModel}");
        return sendOtpModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<ErrorModel> checkUserExistance({
    required String userEmail,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/userexists");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200 || response.statusCode == 401) {
        ErrorModel sendOtpModel = ErrorModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${sendOtpModel}");
        return sendOtpModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AuthUserModel> verifyOtpAndRegister({
    required String firstName,
    required String lastName,
    required String userEmail,
    required String userPassword,
    required String userPhoneNumber,
    required String userStatus,
    required String userRole,
    required String userDOB,
    required String userGender,
    required String userMemberType,
    required String userSelectedLanguage,
    required String userLoginType,
    required String userLoginProvider,
    required String userLoginId,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/register");
      print(uri);
      Map<String, dynamic> body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': userEmail,
        'password': userPassword,
        'phone': userPhoneNumber,
        'status': userStatus,
        'role': userRole,
        'dob': userDOB,
        'gender': userGender,
        'membership_type': userMemberType,
        'language': userSelectedLanguage,
        "login_type":userLoginType,
        "social_login_provider":userLoginProvider,
        "social_login_id":userLoginId,
        "fcm_token":""
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        AuthUserModel registerData = AuthUserModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${registerData.user}");
        return registerData;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AuthUserModel> userLogin({
    required String userEmail,
    required String userPassword,
    required String userRole,
    required String socialLoginId,
    required String userLoginType,
    required String socialType,
    String? userFcmToken,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/login");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
        'password': userPassword,
        'role': userRole,
        'social_login_id': socialLoginId,
        'login_type': userLoginType,
        'social_login_provider': socialType,
        'fcm_token': "",
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AuthUserModel registerData = AuthUserModel.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        debugPrint("Data : ${registerData.user}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<UserProfileData> getUserProfileData({
    required String userId,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/profile");
      print(uri);
      Map<String, dynamic> body = {
        'userId': userId,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });


      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        UserProfileData registerData = UserProfileData.fromJson(jsonDecode(response.body));
        return registerData;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }




  //send otp for forget password
  Future<SendOtpModel> sendOtpForForgetPassword({
    required String userEmail,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/forgot-password-send-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        SendOtpModel sendOtpModel = SendOtpModel.fromJson(jsonDecode(response.body));
        return sendOtpModel;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<VerifiedPassModel> verifyOTPForgetPassword({
    required String userEmail,
    required String changePasswordOTP,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/verify-reset-password-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
        'otp': changePasswordOTP,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        VerifiedPassModel verifiedPassModel = VerifiedPassModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${verifiedPassModel}");
        return verifiedPassModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<VerifiedPassModel> changePasswordDetails({
    required String userEmail,
    required String userNewPassword,
    required String changePasswordOTP,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/reset-password-with-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
        "password":userNewPassword,
        'otp': changePasswordOTP,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        VerifiedPassModel sendOtpModel = VerifiedPassModel.fromJson(jsonDecode(response.body));
        return sendOtpModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<SendOtpModel> partnerSendConnectOtp({
    required String partnerEmail,
    required String userEmail,
    required String partnerName,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/partner-connect-send-otp");
      print(uri);
      Map<String, dynamic> body = {
        'partner_email': partnerEmail,
        'email': userEmail,
        'partner_name': partnerName,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        SendOtpModel sendOtpModel = SendOtpModel.fromJson(jsonDecode(response.body));
        return sendOtpModel;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<VerifiedPassModel> partnerVerifyOtpPassword({
    required String userEmail,
    required String partnerEmail,
    required String partnerOtpCode,
  }) async {
    try {
      final Uri uri = Uri.parse("$base_url/users/partner-accept-with-otp");
      print(uri);
      Map<String, dynamic> body = {
        'email': userEmail,
        'partner_email': partnerEmail,
        'partner_otp': partnerOtpCode,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      debugPrint("body $body");

      final http.Response response = await http
          .post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {
        VerifiedPassModel verifiedPassModel = VerifiedPassModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${verifiedPassModel.status}");
        return verifiedPassModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }




  verifyOTPChangePass(
      String customerEmail,
      String customerOTP,
      ) async {
    final Uri uri = Uri.parse("$base_url/forgot-password-verify-otp");
    try {
      Map<String, dynamic> body = {
        'email': customerEmail,
        'otp': customerOTP,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
      final http.Response response =
      await http.post(uri, body: jsonEncode(body), headers: header);

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   VerifyOTP verifyOTP = VerifyOTP.fromJson(jsonDecode(response.body));
      //   return verifyOTP;
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<AddWishListData> addWishListData({
    required String userId,
    required String partnerUserId,
    required String wishTitle,
    required String wishListDescription,
    required String wishListPoint,
    required String wishListDate,
  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/wishes/add-wish");
      print(uri);
      Map<String, dynamic> body = {
        'user_id': userId,
        'fulfill_user_id': partnerUserId,
        'title': wishTitle,
        'description': wishListDescription,
        'points': wishListPoint,
        'start_date': wishListDate,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<WishListDataModel> userWishListData ({
    required String userId,

  }) async {
    try {
      String token = await prefs.getToken();
      final queryParameters = {
        'user_id': userId,
      };
      final Uri uri = Uri.parse('$base_url/wishes/get-wishes?user_id=$userId');
      print(uri);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $queryParameters");

      final http.Response response = await http.get(
        uri,
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        WishListDataModel registerData = WishListDataModel.fromJson(jsonDecode(response.body));

        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  //partner wish list

  Future<WishListDataModel> userPartnerWishListData({
    required String userPartnerId,
  }) async {
    try {
      String token = await prefs.getToken();

      final Uri uri = Uri.parse('$base_url/wishes/get-partner-wishes?fulfill_user_id=$userPartnerId');
      print(uri);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };

      final http.Response response = await http.get(
        uri,
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        WishListDataModel registerData = WishListDataModel.fromJson(jsonDecode(response.body));

        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  Future<AddWishListData> updateUserWishDetails({
    required String wishId,
    required String wishTitle,
    required String wishListDescription,
    required String wishStatus,

  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/wishes/edit-wish");
      print(uri);
      Map<String, dynamic> body = {
        'wishId':wishId,
        'title':wishTitle,
        'description':wishListDescription,
        'status':wishStatus,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<AddWishListData> deleteUserWishData({
    required String wishId,

  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/wishes/delete-wish");
      print(uri);
      Map<String, dynamic> body = {
        'wishId':wishId,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
       'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.delete(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<AddWishListData> updatePartnerWishData({
    required String wishId,
    required String fullfillUserId,

  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/wishes/fulfill-partner-wish");
      print(uri);
      Map<String, dynamic> body = {
        'wishId':wishId,
        'fulfill_user_id':fullfillUserId,
        'status':"fulfilled",
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AddWishListData> updateFullfilledWishData({
    required String wishId,
    required String userId,

  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/wishes/approve-fulfilled-wish");
      print(uri);
      Map<String, dynamic> body = {
        'wishId':wishId,
        'user_id':userId,
        'status':"approved",
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<UserPartnerModel> getUserAndPartnerData({
    required String userID,
  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/users/get-user-and-partner-profile");
      print(uri);
      print(token);
      Map<String, dynamic> body = {
        'userId': userID,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      if (response.statusCode == 200) {

        print(response.body);
        UserPartnerModel verifiedPassModel = UserPartnerModel.fromJson(jsonDecode(response.body));
        debugPrint("Data : ${verifiedPassModel}");
        return verifiedPassModel;
      } else {
        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }
  }


  Future<AddWishListData> addEvaluationsData({
    required String evaluatorId,
    required String evaluatedUserId,
    required String evaluationsFeedback,
    required String evaluationStatus,
    required int evaluationPoint,
    required String evaluationGoodAreas,
    required String evaluationImprovementAreas,
    required String evaluationDate,
    required String evaluationDueDate,
  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/evaluations/add-evaluation");
      print(uri);
      Map<String, dynamic> body = {
        'evaluator_id': evaluatorId,
        'evaluated_user_id': evaluatedUserId,
        'feedback': evaluationsFeedback,
        'status': evaluationStatus,
        'score': evaluationPoint,
        'good_areas': evaluationGoodAreas,
        'improvement_areas': evaluationImprovementAreas,
        'evaluation_date': evaluationDate,
        'evaluation_due_date': evaluationDueDate,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AddWishListData> editEvaluationsData({
    required String evaluationId,
    required String evaluatedUserId,
    required String evaluationsFeedback,
    required String evaluationStatus,
    required int evaluationPoint,
    required String evaluationGoodAreas,
    required String evaluationImprovementAreas,
    required String evaluationDate,
    required String evaluationDueDate,
  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/evaluations/edit-evaluation");
      print(uri);
      Map<String, dynamic> body = {
        'evaluationId': evaluationId,
        'evaluated_user_id': evaluatedUserId,
        'feedback': evaluationsFeedback,
        'status': evaluationStatus,
        'score': evaluationPoint,
        'good_areas': evaluationGoodAreas,
        'improvement_areas': evaluationImprovementAreas,
        'evaluation_date': evaluationDate,
        'evaluation_due_date': evaluationDueDate,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AddWishListData> deleteUserEvaluationData({
    required String evaluationId,

  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/evaluations/delete-evaluation");
      print(uri);
      Map<String, dynamic> body = {
        'evaluationId':evaluationId,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.delete(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  Future<EvaluationsListData> userEvolutionsListData({
    required String userId,
  }) async {
    try {
      String token = await prefs.getToken();

      final Uri uri = Uri.parse('$base_url/evaluations/get-user-partner-evaluations?evaluator_id=$userId');
      print(uri);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };

      final http.Response response = await http.get(
        uri,
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        EvaluationsListData evolutionsData = EvaluationsListData.fromJson(jsonDecode(response.body));
        return evolutionsData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  Future<UpdateUserProfileData?> userUpdateProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String userEmail,
    required String userPhoneNumber,
    required int wishPlanLimit,
    String? userImage,
  }) async {
   try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/users/edit-profile-and-image");
      print(uri);
      /*Map<String, dynamic> body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': userEmail,
        'phone': userPhoneNumber,
        'wishes_plan_limit': wishPlanLimit,
        'user_img': userImage,
        'userId': userId,
      };*/
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(header);
      request.fields.addAll({
        "first_name": firstName,
        "last_name": lastName,
        "email": userEmail,
        "phone": userPhoneNumber,
        "userId": userId,
      });
      print("first_name: ${firstName}\n"
          "last_name: $lastName\n"
          "email: $userEmail");
      print('phone : $userPhoneNumber');
      File file = File.fromUri(Uri.parse(userImage!));
      print("file-$file");
      print(file.existsSync());
      request.files.add(
          await http.MultipartFile.fromPath('user_img', file.path,));
      String fileName = path.basename(file.path);
      String extension = path.extension(fileName);
      String fileNameWithoutExtension = path.withoutExtension(fileName);

      print("filename-$fileName");
      print("extension-$extension");
      print("filenameWithoutExtension-$fileNameWithoutExtension");


      var response = await request.send();

      print(response.toString());
      print(response.reasonPhrase);
      var responsed = await http.Response.fromStream(response);


      print(responsed.body);

      print(responsed);


      if (responsed.statusCode == 200) {
        UpdateUserProfileData registerData = UpdateUserProfileData.fromJson(jsonDecode(responsed.body));
        debugPrint("Data : ${registerData}");
        return registerData;
      } else {
       // debugPrint("Data : Register Data"+responsed.statusCode);
       ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(responsed.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        //throw Exception(res.statusCode);
       // debugPrint("Data : Register Data"+respStr);

      }
    } catch (e) {
      throw Exception("Exception : ${e.toString()}");
    }

  }


  //statistic data

  Future<StatisticsData> userStatisticsData ({
    required String userId,

  }) async {
    try {
      String token = await prefs.getToken();
      final queryParameters = {
        'user_id': userId,
      };
      final Uri uri = Uri.parse('$base_url/evaluations/get-user-partner-evaluation-scores-for-stats?evaluator_id=$userId');
      print(uri);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $queryParameters");

      final http.Response response = await http.get(
        uri,
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        StatisticsData registerData = StatisticsData.fromJson(jsonDecode(response.body));

        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  // event calender list

  Future<EventCalander> getEventCalender ({
    required String userId,

  }) async {
    try {
      String token = await prefs.getToken();
      final queryParameters = {
        'user_id': userId,
      };
      final Uri uri = Uri.parse('$base_url/events/get-events?user_id=$userId&visibility=shared');
      print(uri);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $queryParameters");

      final http.Response response = await http.get(
        uri,
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        debugPrint("Res : ${response.body}");
        EventCalander eventCalander = EventCalander.fromJson(jsonDecode(response.body));

        return eventCalander;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }

  Future<AddWishListData> addEventCalendar({
    required String userID,
    required String partnerId,
    required String eventType,
    required String eventName,
    required String eventDate,
    String? userFcmToken,
  }) async {
    try {
      String token = await prefs.getToken();
      final Uri uri = Uri.parse("$base_url/events/add-event");
      print(uri);
      Map<String, dynamic> body = {
        'user_id': userID,
        'partner_id': partnerId,
        'event_type': eventType,
        'event_name': eventName,
        'visibility': "shared",
        'event_date': eventDate,
      };
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      };
      debugPrint("body $body");

      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: header,
      )
          .catchError((err) {
        debugPrint("Err : $err");
      });

      print(response.body);

      if (response.statusCode == 200) {
        AddWishListData registerData = AddWishListData.fromJson(jsonDecode(response.body));
        debugPrint("Res : ${response.body}");
        return registerData;
      } else {

        debugPrint("Data : Register Data"+response.body);
        ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
        print(errorModel);
        debugPrint(errorModel.status);
        ApplicationUtils.showSnackBar(
            titleText: errorModel.status, messageText: errorModel.msg);
        throw Exception(response.statusCode);

      }
    } catch (e) {
      print(e.toString());
      throw Exception("Exception : ${e.toString()}");
    }
  }



  Future userLogout() async {
    var token = await prefs.getToken();
    Uri url = Uri.parse("$base_url/logout");
    try {
      Map<String, String> header = {
        "Authorization": 'Bearer $token',
      };
      http.Response response =
      await http.post(url, headers: header).catchError((err) {
        debugPrint(err);
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> user = json.decode(response.body);
        return user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


}