import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefrence {
  SharedPreferences? _prefs;

  Future<bool> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {
      debugPrint('prefrence Error : $e');
    });
    return true;
  }

  //User Id save

  static setUserID(String? pid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isData = await prefs.setString('user_uid', pid ?? "");
    print(isData);
  }

  Future<String> getUserId() async {
    _prefs = await SharedPreferences.getInstance();
    String? id = _prefs!.getString('user_uid');
    print('ID : $id');
    return id ?? "";
  }

  //partner User ID
  static setPartnerUserID(String? pid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isData = await prefs.setString('partner_user_id', pid ?? "");
    print(isData);
  }

  Future<String> getPartnerId() async {
    _prefs = await SharedPreferences.getInstance();
    String? id = _prefs!.getString('partner_user_id');
    print('Partner ID : $id');
    return id ?? "";
  }

  static setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token!);
  }

  Future<String> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    String? getToken = _prefs!.getString('token');
    debugPrint(getToken);
    return getToken ?? "";
  }

  static Future<bool> setFCMToken(String fcmToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isTrue = await preferences.setString('fcm', fcmToken);

    return isTrue;
  }

  Future<String> getFCMToken() async {
    _prefs = await SharedPreferences.getInstance();
    String? fcm = _prefs!.getString('fcm');
    debugPrint("fcm $fcm");
    return Future.value(fcm!);
  }

  static Future<bool> setBadgeStatus(bool badge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setBool('badgeStatus', badge);
    return status;
  }

  getBadgStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool? status = _prefs?.getBool('badgeStatus');

    return status ?? false;
  }





  static setUserEmail(String? value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    bool? userData = await _prefs.setString("user_email", value!);
    debugPrint("user_email $userData");
    return userData;
  }

  Future<String> getUserEmail() async {
    _prefs = await SharedPreferences.getInstance();
    String? user = _prefs!.getString("user_email");
    print('user_email $user');
    return user ?? "";
  }


  static setUserWishLimit(int? value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    bool? userData = await _prefs.setInt("user_wishlist", value!);
    debugPrint("user_wishlist $userData");
    return userData;
  }

  Future<int> getUserWishLimit() async {
    _prefs = await SharedPreferences.getInstance();
    int? user = _prefs!.getInt("user_wishlist");
    print('user_wishlist $user');
    return user ?? 0;
  }

  Future<bool> clearData() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.clear();
    return true;
  }
}