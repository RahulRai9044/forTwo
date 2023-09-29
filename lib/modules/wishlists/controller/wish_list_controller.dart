

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



  void getData(){




  }


  @override
  void onReady() {



  }

  @override
  void onInit() {

    tabController = TabController(vsync: this, length: 2);
    topController = ConfettiController(duration: const Duration(seconds: 10));
    topController.play();


    super.onInit();
  }

}
