// To parse this JSON data, do
//
//     final eventCalander = eventCalanderFromJson(jsonString);

import 'dart:convert';

EventCalander eventCalanderFromJson(String str) => EventCalander.fromJson(json.decode(str));

String eventCalanderToJson(EventCalander data) => json.encode(data.toJson());

class EventCalander {
  String? status;
  String? statusCode;
  List<Datum>? data;
  String? msg;

  EventCalander({
    this.status,
    this.statusCode,
    this.data,
    this.msg,
  });

  factory EventCalander.fromJson(Map<String, dynamic> json) => EventCalander(
    status: json["status"],
    statusCode: json["status_code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Datum {
  String? id;
  String? userId;
  String? eventType;
  String? eventName;
  DateTime? eventDate;
  String? partnerId;

  Datum({
    this.id,
    this.userId,
    this.eventType,
    this.eventName,
    this.eventDate,
    this.partnerId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["user_id"],
    eventType: json["event_type"],
    eventName: json["event_name"],
    eventDate: DateTime.parse(json["event_date"]),
    partnerId: json["partner_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "event_type": eventType,
    "event_name": eventName,
    "event_date": eventDate!.toIso8601String(),
    "partner_id": partnerId,
  };
}
