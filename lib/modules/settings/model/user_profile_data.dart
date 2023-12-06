// To parse this JSON data, do
//
//     final userProfileData = userProfileDataFromJson(jsonString);

import 'dart:convert';

UserProfileData userProfileDataFromJson(String str) => UserProfileData.fromJson(json.decode(str));

String userProfileDataToJson(UserProfileData data) => json.encode(data.toJson());

class UserProfileData {
  bool success;
  String status;
  String statusCode;
  List<Result> result;

  UserProfileData({
    required this.success,
    required this.status,
    required this.statusCode,
    required this.result,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  bool termsAccepted;
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String status;
  String role;
  DateTime dob;
  bool isDel;
  String userImg;
  String gender;
  String membershipType;
  String partnerType;
  String language;
  String? partnerId;
  DateTime createdAt;
  DateTime updatedAt;


  Result({
    required this.termsAccepted,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.status,
    required this.role,
    required this.dob,
    required this.isDel,
    required this.userImg,
    required this.gender,
    required this.membershipType,
    required this.partnerType,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    this.partnerId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    termsAccepted: json["terms_accepted"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    status: json["status"],
    role: json["role"],
    dob: DateTime.parse(json["dob"]),
    isDel: json["is_del"],
    userImg: json["user_img"],
    gender: json["gender"],
    membershipType: json["membership_type"],
    partnerType: json["partner_type"],
    language: json["language"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    partnerId: json["partner_id"],
  );

  Map<String, dynamic> toJson() => {
    "terms_accepted": termsAccepted,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "status": status,
    "role": role,
    "dob": dob.toIso8601String(),
    "is_del": isDel,
    "user_img": userImg,
    "gender": gender,
    "membership_type": membershipType,
    "partner_type": partnerType,
    "language": language,
    "partner_id": partnerId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
