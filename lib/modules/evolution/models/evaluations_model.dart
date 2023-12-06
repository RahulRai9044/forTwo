// To parse this JSON data, do
//
//     final evaluationsListData = evaluationsListDataFromJson(jsonString);

import 'dart:convert';

EvaluationsListData evaluationsListDataFromJson(String str) => EvaluationsListData.fromJson(json.decode(str));

String evaluationsListDataToJson(EvaluationsListData data) => json.encode(data.toJson());

class EvaluationsListData {
  bool? success;
  String? status;
  String? statusCode;
  Result? result;

  EvaluationsListData({
    this.success,
    this.status,
    this.statusCode,
    this.result,
  });

  factory EvaluationsListData.fromJson(Map<String, dynamic> json) => EvaluationsListData(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "result": result!.toJson(),
  };
}

class Result {
  List<Partner>? user;
  List<Partner>? partner;

  Result({
    this.user,
    this.partner,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: List<Partner>.from(json["user"].map((x) => Partner.fromJson(x))),
    partner: List<Partner>.from(json["partner"].map((x) => Partner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user!.map((x) => x.toJson())),
    "partner": List<dynamic>.from(partner!.map((x) => x.toJson())),
  };
}

class Partner {
  String? id;
  String? evaluatorId;
  String? evaluatedUserId;
  String? status;
  int? rating;
  int? score;
  String? feedback;
  String? goodAreas;
  String? improvementAreas;
  DateTime? evaluationDate;
  DateTime? evaluationDueDate;


  Partner({
    this.id,
    this.evaluatorId,
    this.evaluatedUserId,
    this.status,
    this.rating,
    this.score,
    this.feedback,
    this.goodAreas,
    this.improvementAreas,
    this.evaluationDate,
    this.evaluationDueDate,

  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
    id: json["_id"],
    evaluatorId: json["evaluator_id"],
    evaluatedUserId: json["evaluated_user_id"],
    status: json["status"],
    rating: json["rating"],
    score: json["score"],
    feedback: json["feedback"],
    goodAreas: json["good_areas"],
    improvementAreas: json["improvement_areas"],
    evaluationDate: DateTime.parse(json["evaluation_date"]),
    evaluationDueDate: DateTime.parse(json["evaluation_due_date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "evaluator_id": evaluatorId,
    "evaluated_user_id": evaluatedUserId,
    "status": status,
    "rating": rating,
    "score": score,
    "feedback": feedback,
    "good_areas": goodAreas,
    "improvement_areas": improvementAreas,
    "evaluation_date": evaluationDate!.toIso8601String(),
    "evaluation_due_date": evaluationDueDate!.toIso8601String(),
  };
}
