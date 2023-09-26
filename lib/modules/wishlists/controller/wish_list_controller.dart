

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:get/get.dart';


class WishListController extends GetxController  with GetSingleTickerProviderStateMixin {
  bool isLoading = false;
  bool badgeStatus = true;
  var tabIndex = 0;
  final Prefrence mPrefrence = Prefrence();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TabController tabController;
  late ConfettiController topController;

  //FETCHING DATA FROM ARRAY LIST IN COLLECTION


/*  // initialize the final data
  Rxn<List<NewMeetingModel>> finalNewsModel = Rxn<List<NewMeetingModel>>();

  // input data to list
  List<NewMeetingModel>? get newsModelList => finalNewsModel.value;

  int get listSize => finalNewsModel.value!.length;

  //stream builder
  Stream<List<NewMeetingModel>> streamDemo(String? value) {
    return FirebaseFirestore.instance
        .collection('InvitationsList')
        .doc(value)
        .snapshots()
        .map((ds) {
      var mapData = ds.data();
      List mapList = mapData!['meetingDetails'];
      List<NewMeetingModel> newsModelList = [];
      mapList.forEach((element) {
        newsModelList.add(NewMeetingModel.fromMap(element));
      });

      print("newsModelList");
      print(newsModelList);
      print("newsModelList");
      return newsModelList;
    });
  }*/

  void getData(){




  }


  @override
  void onReady() {


  }

  @override
  void onInit() {
   /* mPrefrence
        .getUserId()
        .then((value) => {finalNewsModel.bindStream(streamDemo(value))});
*/

    tabController = TabController(vsync: this, length: 2);
    topController = ConfettiController(duration: const Duration(seconds: 10));


    super.onInit();
  }

}
