import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/evolution/controller/evolutions_controller.dart';
import 'package:for_two/modules/statistics/widgetsStatistics/rectangular_box.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class LastWeekEvolutions extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EvolutionsController());
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Card(
                  child: ExpansionTile(
                    trailing: controller.isExpanded ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_right),
                    initiallyExpanded: true,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.bottomCenter,
                         onExpansionChanged: controller.changeExpansionFlutter(),
                         title: CustomizedTextWidget(color: buttonFirstColor, fontSize: 16, textValue: 'Evaluated by your Partner', overflow: TextOverflow.ellipsis,
                           fontFamily: 'Poppins-SemiBold',fontWeight: FontWeight.w700,),
                    children: [

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Divider(
                                  height: 1,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomizedTextWidget(
                                        color: blackTextColor,
                                        fontSize: 15,
                                        textAlignment: TextAlign.start,
                                        textValue: 'Relationship Status',
                                        fontFamily: 'Poppins-Regular',
                                      ),

                                      CustomizedTextWidget(
                                        color: blackTextColor,
                                        fontSize: 15,
                                        textAlignment: TextAlign.start,
                                        textValue: controller.latestEvaluationsData?.score.toString() ?? "",
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue: '\u2022 Partner\'s Feedback',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      readOnly: true,
                                      controller:controller.feedbackController,
                                      minLines: 5,
                                      maxLines: 10,
                                      decoration: const InputDecoration(
                                          hintText: 'feedback',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue:
                                  '\u2022 Partner say good about you',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      readOnly: true,
                                      controller:controller.evaluationGoodAreasController,
                                      minLines: 5,
                                      maxLines: 10,
                                      decoration: const InputDecoration(
                                          hintText: 'good areas',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue:
                                  '\u2022 Partner advised in some areas',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      readOnly: true,
                                      controller:controller.improvementAreaController,
                                      minLines: 5,
                                      maxLines: 10,
                                      decoration: const InputDecoration(
                                          hintText: 'improvement areas',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),




                                SizedBox(
                                  height: 20,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                       ),
                ),

                Card(
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    expandedAlignment: Alignment.bottomCenter,
                    title: CustomizedTextWidget(color: buttonFirstColor, fontSize: 16, textValue: 'Evaluated by your Partner', overflow: TextOverflow.ellipsis,
                      fontFamily: 'Poppins-SemiBold',fontWeight: FontWeight.w700,),
                    children: [

                      controller.latestPatnerEvaluationsData?.id != null ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Divider(
                                  height: 1,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomizedTextWidget(
                                      color: blackTextColor,
                                      fontSize: 15,
                                      textAlignment: TextAlign.start,
                                      textValue: 'Relationship Status',
                                      fontFamily: 'Poppins-Regular',
                                    ),

                                    CustomizedTextWidget(
                                      color: blackTextColor,
                                      fontSize: 15,
                                      textAlignment: TextAlign.start,
                                      textValue: controller.latestPatnerEvaluationsData!.score.toString(),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins-Bold',
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue: '\u2022 Partner\'s Feedback',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      controller:controller.partnerFeedbackController,
                                      minLines: 5,
                                      readOnly: true,
                                      maxLines: 10,

                                      decoration: const InputDecoration(
                                          hintText: '',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue:
                                  '\u2022 Partner say good about you',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      controller:controller.PartnerEvaluationGoodAreasController,
                                      minLines: 5,
                                      readOnly: true,
                                      maxLines: 10,
                                      decoration: const InputDecoration(
                                          hintText: '',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomizedTextWidget(
                                  color: blackTextColor,
                                  fontSize: 15,
                                  textValue:
                                  '\u2022 Partner advised in some areas',
                                  fontFamily: 'Poppins-Regular',
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.purple, style: BorderStyle.solid)),
                                    child: TextField(
                                      controller:controller.partnerImprovementAreaController,
                                      minLines: 5,
                                      maxLines: 10,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText: '',
                                          contentPadding: EdgeInsets.all(15),
                                          border: InputBorder.none),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),




                                SizedBox(
                                  height: 20,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ) :
                      showCard()

                    ],
                  ),
                ),
                 
              ],
            );
          },
        ),
      ),

    );



  }


  showCard(){
    return Container(
      width: size.width,
      child: Card(
        elevation: 50,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/no_data_found.png",
                height: size.height * 0.2,
                width: size.width * 0.4,
              ),
              const SizedBox(
                height: 10,
              ), //SizedBox
              CustomizedTextWidget(color: buttonFirstColor, fontSize: 15, textValue: 'No Evaluation from your side!', overflow: TextOverflow.ellipsis,
                fontFamily: 'Poppins-Regular',),
              const SizedBox(
                height: 10,
              ), //SizedBox
           //SizedBox
              CommonElevatedButton(
                height: size.height * 0.05,
                width: size.width * 0.50,
                title: 'Evaluate Now',
                onTap: () async {

                },
              ) //SizedBox
            ],
          ), //Column
        ), //SizedBox
      ),
    );//Card

  }


}