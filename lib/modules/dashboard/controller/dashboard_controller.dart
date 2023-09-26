

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/dashboard/model/add_meeting.dart';
import 'package:for_two/modules/dashboard/view/profile_screen.dart';
import 'package:for_two/modules/homePage/view/home_page.dart';
import 'package:for_two/modules/wishlists/view/wish_lists.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  bool isLoading=false;
  bool badgeStatus=true;
  var tabIndex = 0;
  final Prefrence mPrefrence = Prefrence();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  double percent = 50.0;


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
        return  HomePage();
      case 1:
        return  WishListScreen();
      case 2:
        return  ProfileScreen();
      default:
        return  HomePage();
    }
  }

  Path buildBoatPath() {

    // double width = size.width/2;
    // double height = size.height/3;
    //
    // Path path = Path();
    // path.moveTo(0.5 * width, height * 0.35);
    // path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6, 0.5 * width, height);
    // path.moveTo(0.5 * width, height * 0.35);
    // path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
    //     0.5 * width, height);

    Path path = Path();
     double width = size.width/2;
    double height = size.height/3.5;
    // Starting point
    path.moveTo(width / 2, height / 5);

    // Upper left path
    path.cubicTo(5 * width / 14, 0, 0, height / 15, width / 28, 2 * height / 5);

    // Lower left path
    path.cubicTo(width / 14, 2 * height / 3, 3 * width / 7, 5 * height / 5, width / 2, height);

    // Lower right path
    path.cubicTo(4 * width / 7, 5 * height / 5, 13 * width / 14, 2 * height / 3, 27 * width / 28, 2 * height / 5);

    // Upper right path
    path.cubicTo(width, height / 15, 9 * width / 14, 0, width / 2, height / 5);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth=10.0
      ..color = Colors.black;

    

    return path;
  }

}