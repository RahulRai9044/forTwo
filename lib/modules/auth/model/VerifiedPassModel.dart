// To parse this JSON data, do
//
//     final verifiedPassModel = verifiedPassModelFromJson(jsonString);

import 'dart:convert';

VerifiedPassModel verifiedPassModelFromJson(String str) => VerifiedPassModel.fromJson(json.decode(str));

String verifiedPassModelToJson(VerifiedPassModel data) => json.encode(data.toJson());

class VerifiedPassModel {
  String status;
  String statusCode;
  String msg;

  VerifiedPassModel({
    required this.status,
    required this.statusCode,
    required this.msg,
  });

  factory VerifiedPassModel.fromJson(Map<String, dynamic> json) => VerifiedPassModel(
    status: json["status"],
    statusCode: json["status_code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "msg": msg,
  };
}
