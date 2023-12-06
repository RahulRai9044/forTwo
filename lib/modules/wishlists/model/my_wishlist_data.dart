// To parse this JSON data, do
//
//     final wishListDataModel = wishListDataModelFromJson(jsonString);

import 'dart:convert';

WishListDataModel wishListDataModelFromJson(String str) => WishListDataModel.fromJson(json.decode(str));

String wishListDataModelToJson(WishListDataModel data) => json.encode(data.toJson());

class WishListDataModel {
  String status;
  String statusCode;
  List<Datum> data;
  String msg;

  WishListDataModel({
    required this.status,
    required this.statusCode,
    required this.data,
    required this.msg,
  });

  factory WishListDataModel.fromJson(Map<String, dynamic> json) => WishListDataModel(
    status: json["status"],
    statusCode: json["status_code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Datum {
  String id;
  String userId;
  String fulfillUserId;
  String title;
  String description;
  String imageUrl;
  String type;
  int points;
  int rating;
  String feedback;
  String status;
  String goodAreas;
  String improvementAreas;
  DateTime startDate;
  DateTime expectedCompletionDate;
  DateTime fulfillDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.userId,
    required this.fulfillUserId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.points,
    required this.rating,
    required this.feedback,
    required this.status,
    required this.goodAreas,
    required this.improvementAreas,
    required this.startDate,
    required this.expectedCompletionDate,
    required this.fulfillDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["user_id"],
    fulfillUserId: json["fulfill_user_id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["image_url"],
    type: json["type"],
    points: json["points"],
    rating: json["rating"],
    feedback: json["feedback"],
    status: json["status"],
    goodAreas: json["good_areas"],
    improvementAreas: json["improvement_areas"],
    startDate: DateTime.parse(json["start_date"]),
    expectedCompletionDate: DateTime.parse(json["expected_completion_date"]),
    fulfillDate: DateTime.parse(json["fulfill_date"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "fulfill_user_id": fulfillUserId,
    "title": title,
    "description": description,
    "image_url": imageUrl,
    "type": type,
    "points": points,
    "rating": rating,
    "feedback": feedback,
    "status": status,
    "good_areas": goodAreas,
    "improvement_areas": improvementAreas,
    "start_date": startDate.toIso8601String(),
    "expected_completion_date": expectedCompletionDate.toIso8601String(),
    "fulfill_date": fulfillDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
