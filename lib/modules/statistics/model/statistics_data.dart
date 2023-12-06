// To parse this JSON data, do
//
//     final statisticsData = statisticsDataFromJson(jsonString);

import 'dart:convert';

StatisticsData statisticsDataFromJson(String str) => StatisticsData.fromJson(json.decode(str));

String statisticsDataToJson(StatisticsData data) => json.encode(data.toJson());

class StatisticsData {
  bool? success;
  String? status;
  String? statusCode;
  List<Result> result;

  StatisticsData({
    this.success,
    this.status,
    this.statusCode,
    required this.result,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) => StatisticsData(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  DateTime? resultDate;
  int? userScore;
  int? partnerScore;
  double? averageScore;

  Result({
    this.resultDate,
    this.userScore,
    this.partnerScore,
    this.averageScore,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resultDate: DateTime.parse(json["result_date"]),
    userScore: json["user_score"],
    partnerScore: json["partner_score"],
    averageScore: json["average_score"]!.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "result_date": "${resultDate?.year.toString().padLeft(4, '0')}-${resultDate?.month.toString().padLeft(2, '0')}-${resultDate?.day.toString().padLeft(2, '0')}",
    "user_score": userScore,
    "partner_score": partnerScore,
    "average_score": averageScore,
  };
}
