import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/statistics/controller/statistics_controller.dart';
import 'package:for_two/modules/statistics/widgetsStatistics/rectangular_box.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class StatisticsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
        init: StatisticsController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.record.length,
                  itemBuilder: (BuildContext context, int index) {
                    int? userScore = controller.record[index].userScore ?? 0;
                    int? partnerScore = controller.record[index].partnerScore ?? 0;
                    double? avgScore = controller.record[index].averageScore ?? 0.0;

                    print(controller.record[index].userScore);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CommonRectangularBox(),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomizedTextWidget(
                                  color: buttonFirstColor,
                                  fontSize: 15,
                                  textValue: controller.statisticDate(
                                      controller.record[index].resultDate),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  width: size.width * 0.80,
                                  child: Divider(
                                    color: dividerColor,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Container(
                                  height: 50,
                                  width: size.width * 0.25,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFF01828),
                                        Color(0xFFEF3B85)
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                        child: CustomizedTextWidget(
                                          color: Colors.white,
                                          fontSize: 12,
                                          textValue:
                                          'Your Point ' + userScore.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  )),
                              trailing: Container(
                                  height: 50,
                                  width: size.width * 0.30,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFF01828),
                                        Color(0xFFEF3B85)
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                        child: CustomizedTextWidget(
                                      color: Colors.white,
                                      fontSize: 12,
                                      textValue: 'Average Score ' +
                                          avgScore.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  )),
                              title: Container(
                                  height: 50,
                                  width: size.width * 0.25,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFF01828),
                                        Color(0xFFEF3B85)
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                        child: CustomizedTextWidget(
                                      color: Colors.white,
                                      fontSize: 12,
                                      textValue:
                                          'Partner Point ' + partnerScore.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  )),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
