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

  setUserID(String? pid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isData = await prefs.setString('user_uid', pid ?? "");
    print(isData);
  }

  Future<String?> getUserId() async {
    _prefs = await SharedPreferences.getInstance();
    String? id = _prefs?.getString('user_uid');
    print('ID : $id');
    return id;
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

  Future<bool> setConsent(bool? value) async {
    _prefs = await SharedPreferences.getInstance();
    bool consent = await _prefs!.setBool('consent', value!);
    return consent;
  }

  Future<bool> getConsent() async {
    _prefs = await SharedPreferences.getInstance();
    bool? userConsent = _prefs!.getBool("consent");
    return userConsent ?? false;
  }

  Future<bool?> setUserPhoneNumber(String? value) async {
    _prefs = await SharedPreferences.getInstance();
    bool? userData = await _prefs!.setString("userPhoneNumber", value!);
    debugPrint("userPhoneNumber $userData");
    return userData;
  }

  Future<String> getUserPhoner() async {
    _prefs = await SharedPreferences.getInstance();
    String? user = _prefs!.getString("userPhoneNumber");
    print('userPhoneNumber $user');
    return user ?? "";
  }

  Future<bool> clearData() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.clear();
    return true;
  }
}