import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  late bool isShowingMainData;

  @override
  void onInit() {

    tabController = TabController(vsync: this, length: 2);
    isShowingMainData = true;
    super.onInit();
  }

}