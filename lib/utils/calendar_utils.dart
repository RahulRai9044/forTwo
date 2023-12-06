import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

class Event {
  final String title;
  final String status;


  const Event(this.title,this.status);

  @override
  String toString() => title;
}






int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}



final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month-5, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 11, kToday.day);