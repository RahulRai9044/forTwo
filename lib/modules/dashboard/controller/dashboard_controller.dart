

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/model/add_meeting.dart';
import 'package:for_two/modules/dashboard/view/profile_screen.dart';
import 'package:for_two/modules/invitations/view/invitation_list.dart';
import 'package:for_two/modules/invited/view/invited_list.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  bool isLoading=false;
  bool badgeStatus=true;
  var tabIndex = 0;
  final Prefrence mPrefrence = Prefrence();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  // initialize the final data
  Rxn<List<NewMeetingModel>> finalNewsModel = Rxn<List<NewMeetingModel>>();

  // input data to list
  List<NewMeetingModel>? get newsModelList => finalNewsModel.value;


  //stream builder
  Stream<List<NewMeetingModel>> streamDemo(String value) {
    return FirebaseFirestore.instance
        .collection('InvitationsList').where("inviterUID",isEqualTo: value)
        .snapshots()
        .map((ds) {

          List<NewMeetingModel> newsModelList = [];

          for (var todo in ds.docs) {

            final todoModel =
            NewMeetingModel.fromDocumentSnapshot(documentSnapshot: todo);
            newsModelList.add(todoModel);
          }
      // var mapData = ds.metadata;
      // SnapshotMetadata mapList = mapData;
      // List<NewMeetingModel> newsModelList = [];
      // mapList.forEach((element) {
      //   newsModelList.add(NewMeetingModel.fromMap(element));
      // });
      //
      
      
     // print(newsModelList);
      return newsModelList;
    });
  }




  // initialize the final data
  Rxn<List<NewMeetingModel>> finalInvitationList = Rxn<List<NewMeetingModel>>();

  // input data to list
  List<NewMeetingModel>? get invitationLists => finalInvitationList.value;

  //stream builder
  Stream<List<NewMeetingModel>> getDataOfMeetingsForInvitee(String value) {

    return FirebaseFirestore.instance
        .collection('InvitationsList').where("inviteePhoneNumber",isEqualTo: value)
        .snapshots()
        .map((ds) {

      List<NewMeetingModel> invitationLists = [];

      for (var todo in ds.docs) {

        final todoModel =
        NewMeetingModel.fromDocumentSnapshot(documentSnapshot: todo);
        invitationLists.add(todoModel);
      }
      // var mapData = ds.metadata;
      // SnapshotMetadata mapList = mapData;
      // List<NewMeetingModel> newsModelList = [];
      // mapList.forEach((element) {
      //   newsModelList.add(NewMeetingModel.fromMap(element));
      // });
      //


      // print(newsModelList);
      return invitationLists;
    });
  }


  void changeTabIndex(int index) {
    tabIndex = index;
    if (index == 0) {
      Get.delete<DashboardController>();
      Get.put(DashboardController());
    } else if (index == 1) {
      Get.delete<DashboardController>();
      Get.put(DashboardController());
    } else if (index == 2) {
      // Get.delete<ContactController>();
      // Get.put(ContactController());
    } else {
      // Get.delete<AccountController>();
      // Get.put(AccountController());
    }
    update();
  }




  @override
  void onReady() {


  }

  @override
  void onInit() {

    mPrefrence.getUserId().then((value) => {

      if(value != null){

        finalNewsModel.bindStream(streamDemo(value))

      }


    });

    mPrefrence.getUserPhoner().then((value) => {

      if(value != null){

        finalInvitationList.bindStream(getDataOfMeetingsForInvitee(value))

      }


    });



    super.onInit();
  }



  Widget getPage(int index) {
    switch (index) {
      case 0:
        return  InvitedList();
      case 1:
        return  InvitationList();
      case 2:
        return  ProfileScreen();
      default:
        return  InvitedList();
    }
  }

}