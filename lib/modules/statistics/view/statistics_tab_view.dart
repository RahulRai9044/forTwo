import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/statistics/controller/statistics_controller.dart';
import 'package:for_two/modules/statistics/view/statistics_graph.dart';
import 'package:for_two/modules/statistics/view/statistics_list.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:get/get.dart';

class StatisticTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
        init: StatisticsController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(30.0),
                  child: TabBar(
                    controller: controller.tabController,
                    indicatorColor: buttonFirstColor,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomizedTextWidget(
                            color: buttonFirstColor,
                            fontSize: 15,
                            textValue: 'List'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomizedTextWidget(
                            color: buttonFirstColor,
                            fontSize: 15,
                            textValue: 'Graph'),
                      ),
                    ],
                  ),
                ),
                title: CustomizedTextWidget(
                    color: buttonFirstColor,
                    fontSize: 25,
                    textValue: 'Statistics'),
                centerTitle: true,
              ),
              body: TabBarView(
                controller: controller.tabController,
                children: [
                  StatisticsList(),
                  StatisticsGraph(
                    isShowingMainData: true,
                  ),
                  // BikePage(),
                ],
              ),
            ),
          );
        });
  }
}
