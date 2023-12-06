import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/calanderPage/controller/calander_controller.dart';
import 'package:for_two/modules/calanderPage/view/add_events.dart';
import 'package:for_two/modules/calanderPage/view/event_calander.dart';
import 'package:for_two/modules/calanderPage/view/wishlist_calander.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class CalanderWishEventTab extends StatelessWidget{
  const CalanderWishEventTab({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            width: size.width,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC7D4F9),
                  Color(0xFFC9D3EC),
                  Color(0xFFE8EBF4),
                  Color(0xFFF4C8D7),
                  Color(0xFFFFF5EB)
                ],
              ),
            ),
            child: TabBar(
              controller: controller.tabController,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomizedTextWidget(color: buttonFirstColor, fontSize: 12, textValue: 'Wish Calendar'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomizedTextWidget(color: buttonFirstColor, fontSize: 12, textValue: 'Event Calendar'),
                ),
              ],
            ),
          ),
        ),
        title: CustomizedTextWidget(color: kBlackColor, fontSize: 18, textValue: 'Calendar'),
        centerTitle: true,
        actions: [

          Visibility(
            visible: controller.showAddEventBtn,
            child: GestureDetector(
              onTap: (){

               Get.to(AddEventsScreen());

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
                            textValue: 'Add Events'),
                        const SizedBox(width: 10),
                        Icon(Icons.add,size: 20,color: Colors.red.shade400,)
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(

        controller: controller.tabController,
        children: [
          CalendarPage(),
          WishlistCalendarPage(),
        ],
      ),
    );

  }



}