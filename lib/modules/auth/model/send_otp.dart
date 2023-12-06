// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  String status;
  String statusCode;
  String data;
  String msg;

  SendOtpModel({
    required this.status,
    required this.statusCode,
    required this.data,
    required this.msg,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    status: json["status"],
    statusCode: json["status_code"],
    data: json["data"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "data": data,
    "msg": msg,
  };
}
