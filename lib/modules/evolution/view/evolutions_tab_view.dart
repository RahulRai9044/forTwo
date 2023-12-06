import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/evolution/controller/evolutions_controller.dart';
import 'package:for_two/modules/evolution/view/add_evolutions.dart';
import 'package:for_two/modules/evolution/view/evolutions_history.dart';
import 'package:for_two/modules/evolution/view/last_week_evolution.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class EvaluationsTabView extends StatelessWidget{
  const EvaluationsTabView({super.key});


  @override
  Widget build(BuildContext context) {

    return GetBuilder<EvolutionsController>(
        init: EvolutionsController(),
    builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),

          actions: [

            Visibility(
              visible: controller.showAddEvaluationsButton,
              child: GestureDetector(
                onTap: () {
                  Get.to(AddEvolutionsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: size.width * 0.30,
                      decoration: new BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.grey.shade200,
                            width: 2.0,
                          ),
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white
                          ])),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          CustomizedTextWidget(
                              color: Colors.red.shade400,
                              fontSize: 12,
                              textValue: 'Evaluate'),
                          const SizedBox(width: 10),
                          Icon(Icons.add, size: 20, color: Colors.red.shade400,)
                        ],
                      )),
                ),
              ),
            ),

          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
              controller: controller.tabController,
              indicatorColor: buttonFirstColor,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomizedTextWidget(color: buttonFirstColor,
                      fontSize: 15,
                      textValue: 'Last week'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomizedTextWidget(color: buttonFirstColor,
                      fontSize: 15,
                      textValue: 'History'),
                ),
              ],
            ),
          ),
          title: CustomizedTextWidget(
              color: buttonFirstColor, fontSize: 25, textValue: 'Evaluations'),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            LastWeekEvolutions(),
            EvolutionsHistory(),
            // BikePage(),
          ],
        ),
      );
    });

  }



}