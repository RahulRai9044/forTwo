// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  bool isLogin;
  String userFCmToken;
  String userPhoneNumber;
  String userEmail;
  String userName;
  String userUid;

  UserData({
    required this.isLogin,
    required this.userFCmToken,
    required this.userPhoneNumber,
    required this.userEmail,
    required this.userName,
    required this.userUid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    isLogin: json["isLogin"],
    userFCmToken: json["userFCmToken"],
    userPhoneNumber: json["userPhoneNumber"],
    userEmail: json["userEmail"],
    userName: json["userName"],
    userUid: json["userUid"],
  );

  Map<String, dynamic> toJson() => {
    "isLogin": isLogin,
    "userFCmToken": userFCmToken,
    "userPhoneNumber": userPhoneNumber,
    "userEmail": userEmail,
    "userName": userName,
    "userUid": userUid,
  };
}
