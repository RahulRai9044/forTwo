// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  String msg;
  String status;
  String statusCode;

  ErrorModel({
    required this.msg,
    required this.status,
    required this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    msg: json["msg"],
    status: json["status"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "status_code": statusCode,
  };
}
