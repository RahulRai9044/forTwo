// To parse this JSON data, do
//
//     final updateUserProfileData = updateUserProfileDataFromJson(jsonString);

import 'dart:convert';

UpdateUserProfileData updateUserProfileDataFromJson(String str) => UpdateUserProfileData.fromJson(json.decode(str));

String updateUserProfileDataToJson(UpdateUserProfileData data) => json.encode(data.toJson());

class UpdateUserProfileData {
  String? status;
  String? statusCode;
  Data? data;
  String? message;

  UpdateUserProfileData({
    this.status,
    this.statusCode,
    this.data,
    this.message,
  });

  factory UpdateUserProfileData.fromJson(Map<String, dynamic> json) => UpdateUserProfileData(
    status: json["status"],
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? userImg;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.userImg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    userImg: json["user_img"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "user_img": userImg,
  };
}
