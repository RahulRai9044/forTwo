// To parse this JSON data, do
//
//     final addWishListData = addWishListDataFromJson(jsonString);

import 'dart:convert';

AddWishListData addWishListDataFromJson(String str) => AddWishListData.fromJson(json.decode(str));

String addWishListDataToJson(AddWishListData data) => json.encode(data.toJson());

class AddWishListData {
  String status;
  String statusCode;
  String msg;

  AddWishListData({
    required this.status,
    required this.statusCode,
    required this.msg,
  });

  factory AddWishListData.fromJson(Map<String, dynamic> json) => AddWishListData(
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

