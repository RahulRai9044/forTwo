import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/statistics/controller/statistics_controller.dart';
import 'package:for_two/modules/statistics/widgetsStatistics/rectangular_box.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class StatisticsList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    CommonRectangularBox(),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomizedTextWidget(color: buttonFirstColor, fontSize: 15, textValue: 'Fri, 8 September 2023',overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          width: size.width * 0.8,
                          child:  Divider(
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
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading:  Icon(Icons.check_circle_rounded,color: Colors.green.shade700,),
                      trailing: Container(
                        height: 50,
                          width: 100,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              gradient: const LinearGradient(colors: [Color(0xFFF01828),Color(0xFFEF3B85)])
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CustomizedTextWidget(color: Colors.white, fontSize: 12, textValue: '200 Pts')),
                          )),
                      title:  Container(
                          width: size.width * 0.7,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              gradient: const LinearGradient(colors: [Color(0xFFF01828),Color(0xFFEF3B85)])
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomizedTextWidget(color: Colors.white, fontSize: 16, textValue: 'Take me and kids to a lake on the weekend',   overflow: TextOverflow.ellipsis,),
                          )),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),

    );

  }



}