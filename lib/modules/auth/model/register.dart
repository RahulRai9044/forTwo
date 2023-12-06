// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

AuthUserModel registerModelFromJson(String str) => AuthUserModel.fromJson(json.decode(str));

String registerModelToJson(AuthUserModel data) => json.encode(data.toJson());

class AuthUserModel {
  String status;
  String statusCode;
  String msg;
  String token;
  Users user;

  AuthUserModel({
    required this.status,
    required this.statusCode,
    required this.msg,
    required this.token,
    required this.user,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
    status: json["status"],
    statusCode: json["status_code"],
    msg: json["msg"],
    token: json["token"],
    user: Users.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
    "token": token,
    "user": user.toJson(),
  };
}

class Users {
  int wishes_plan_limit;
  String id;

  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  DateTime dob;
  String gender;
  String status;
  String role;
  bool isDel;
  String token;
  String userImg;
  String membershipType;
  String partnerType;
  String language;
  bool termsAccepted;
  String partnerEmail;
  String partnerStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String activationStatus;
  String? socialLoginId;

  Users({
    required this.wishes_plan_limit,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.status,
    required this.role,
    required this.isDel,
    required this.token,
    required this.userImg,
    required this.membershipType,
    required this.partnerType,
    required this.language,
    required this.termsAccepted,
    required this.partnerEmail,
    required this.partnerStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.activationStatus,
    this.socialLoginId,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    wishes_plan_limit: json["wishes_plan_limit"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    status: json["status"],
    role: json["role"],
    isDel: json["is_del"],
    token: json["token"],
    userImg: json["user_img"],
    membershipType: json["membership_type"],
    partnerType: json["partner_type"],
    language: json["language"],
    termsAccepted: json["terms_accepted"],
    partnerEmail: json["partner_email"],
    partnerStatus: json["partner_status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    activationStatus: json["activation_status"],
    socialLoginId:json["social_login_id"],
  );

  Map<String, dynamic> toJson() => {
    "wishes_plan_limit": wishes_plan_limit,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "dob": dob.toIso8601String(),
    "gender": gender,
    "status": status,
    "role": role,
    "is_del": isDel,
    "token": token,
    "user_img": userImg,
    "membership_type": membershipType,
    "partner_type": partnerType,
    "language": language,
    "terms_accepted": termsAccepted,
    "partner_email": partnerEmail,
    "partner_status": partnerStatus,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "activation_status": activationStatus,
    "social_login_id": socialLoginId,
  };
}
