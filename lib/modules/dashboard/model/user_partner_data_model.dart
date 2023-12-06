// To parse this JSON data, do
//
//     final userPartnerModel = userPartnerModelFromJson(jsonString);

import 'dart:convert';

UserPartnerModel userPartnerModelFromJson(String str) => UserPartnerModel.fromJson(json.decode(str));

String userPartnerModelToJson(UserPartnerModel data) => json.encode(data.toJson());

class UserPartnerModel {
  bool? success;
  String? status;
  String? statusCode;
  Result? result;

  UserPartnerModel({
    this.success,
    this.status,
    this.statusCode,
    this.result,
  });

  factory UserPartnerModel.fromJson(Map<String, dynamic> json) => UserPartnerModel(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "result": result?.toJson() ?? '',
  };
}

class Result {
  Partner? user;
  Partner? partner;

  Result({
    this.user,
    this.partner,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: Partner.fromJson(json["user"]),
    partner: json["partner"] != null ? Partner.fromJson(json["partner"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson() ?? {},
    "partner": partner?.toJson() ?? '',
  };
}

class Partner {
  int? wishesPlanLimit;
  String? fcmToken;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? status;
  String? role;
  String? partnerId;

  Partner({
    this.wishesPlanLimit,
    this.fcmToken,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.status,
    this.role,
    this.partnerId,
  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
    wishesPlanLimit: json["wishes_plan_limit"] ?? "",
    fcmToken: json["fcm_token"] ?? "",
    id: json["_id"] ?? "",
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    gender: json["gender"] ?? "",
    status: json["status"] ?? "",
    role: json["role"] ?? "",
    partnerId: json["partner_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "wishes_plan_limit": wishesPlanLimit,
    "fcm_token": fcmToken,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "gender": gender,
    "status": status,
    "role": role,
    "partner_id": partnerId,
  };
}
