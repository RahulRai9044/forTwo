import 'package:cloud_firestore/cloud_firestore.dart';

class NewMeetingModel{

  late String inviteeName;
  late String inviteePhoneNumber;
  late String inviterName;
  late String? inviterUID;
  late String meetingAddress;
  late String meetingDate;
  late String meetingLat;
  late String meetingLng;
  late String meetingPrice;
  late String meetingStatus;
  late String meetingTime;


  NewMeetingModel({
    required this.inviteeName,
    required this.inviteePhoneNumber,
    required this.inviterName,
    required this.inviterUID,
    required this.meetingAddress,
    required this.meetingDate,
    required this.meetingLat,
    required this.meetingLng,
    required this.meetingPrice,
    required this.meetingStatus,
    required this.meetingTime,
  });

/*
  NewMeetingModel.fromMap(Map<String, dynamic> mapData) {
    this.inviteeName = mapData["inviteeName"];
    this.inviteePhoneNumber = mapData["inviteePhoneNumber"];
    this.inviterName = mapData["inviterName"];
    this.inviterUID = mapData["inviterUID"];
    this.meetingAddress = mapData["meetingAddress"];
    this.meetingDate = mapData["meetingDate"];
    this.meetingLat = mapData["meetingLat"];
    this.meetingLng = mapData["meetingLng"];
    this.meetingPrice = mapData["meetingPrice"];
    this.meetingStatus = mapData["meetingStatus"];
    this.meetingTime = mapData["meetingTime"];
  }*/
  NewMeetingModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    inviteeName = documentSnapshot["inviteeName"];
    inviteePhoneNumber = documentSnapshot["inviteePhoneNumber"];
    inviterName = documentSnapshot["inviterName"];
    inviterUID = documentSnapshot["inviterUID"];
    meetingAddress = documentSnapshot["meetingAddress"];
    meetingDate = documentSnapshot["meetingDate"];
    meetingLat = documentSnapshot["meetingLat"];
    meetingLng = documentSnapshot["meetingLng"];
    meetingPrice = documentSnapshot["meetingPrice"];
    meetingStatus = documentSnapshot["meetingStatus"];
    meetingTime = documentSnapshot["meetingTime"];

  }

}