import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/evolution/controller/edit_evaluation_controller.dart';
import 'package:for_two/modules/evolution/controller/evolutions_controller.dart';
import 'package:for_two/modules/statistics/widgetsStatistics/rectangular_box.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class EditEvaluationScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: CustomizedTextWidget(
          color: buttonFirstColor,
          fontSize: 25,
          textValue: "Edit Evaluation",
          fontFamily: 'Poppins-SemiBold',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,

        actions: [

          GestureDetector(
              onTap: (){

                deleteWish();

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.delete,size: 25,color: kTextColor,),
              ))

        ],

      ),
        body: GetBuilder<EditEvaluationController>(
            init: EditEvaluationController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: CustomizedTextWidget(
                          maxline: 2,
                          color: buttonFirstColor,
                          fontSize: 18,
                          textValue: IntlKeys.add_evolution_des.tr,
                          fontFamily: 'Poppins-SemiBold',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NumberPicker(
                                  value: controller.currentValue,
                                  minValue: 0,
                                  maxValue: 10,
                                  step: 1,
                                  itemHeight: size.height *0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  axis: Axis.vertical,
                                  itemWidth: size.width* 0.3,
                                  onChanged: (value) => controller
                                      .changeEvolutionsNumberOne(value)),
                              SizedBox(
                                width: 20,
                              ),
                              NumberPicker(
                                  value: controller.currentValueTwo,
                                  minValue: 0,
                                  axis: Axis.vertical,
                                  maxValue: 10,
                                  selectedTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  step: 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  zeroPad: false,
                                  itemHeight: size.height *0.1,
                                  itemWidth: size.width* 0.3,
                                  onChanged: (value) => controller
                                      .changeEvolutionsNumberTwo(value)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomizedTextWidget(
                                color: buttonFirstColor,
                                fontSize: 18,
                                textAlignment: TextAlign.start,
                                textValue: 'Provide feedback / Communicate',
                                fontFamily: 'Poppins-SemiBold',
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              CustomizedTextWidget(
                                color: blackTextColor,
                                fontSize: 15,
                                textValue:
                                '\u2022 Anything you want to thank your significant other for?',
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
                                    controller: controller.feedbackController,
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: const InputDecoration(
                                        hintText: 'feedback',
                                        contentPadding: EdgeInsets.all(15),
                                        border: InputBorder.none),
                                    onChanged: (value) {


                                    },
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
                                '\u2022 Complement your partner, what was done great? what made you feel special?',
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
                                    controller: controller.evaluationGoodAreasController,
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
                                '\u2022 Share areas of improvement that can help strengthen your bond. ',
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
                                    controller: controller.improvementAreaController,
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: const InputDecoration(
                                        hintText: 'improvement areas',
                                        contentPadding: EdgeInsets.all(15),
                                        border: InputBorder.none),
                                    onChanged: (value) {


                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          CommonElevatedButton(
                            height: size.height * 0.05,
                            width: size.width * 1.0,
                            title: 'Submit',
                            onTap: () async {


                              controller.updateEvaluationData();

                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })

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

  void deleteWish() {
    EditEvaluationController controller = Get.find<EditEvaluationController>();
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => true,
            child: Container(

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomizedTextWidget(
                      color: buttonSecondColor,
                      fontSize: 15,
                      textValue: "Delete?",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomizedTextWidget(
                      color: kTextColor,
                      fontSize: 12,
                      textAlignment: TextAlign.center,
                      textValue: "Are you sure want to delete this evaluation ?",
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                                width: size.width * 0.30,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    border: new Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2.0,
                                    ),
                                    gradient: const LinearGradient(colors: [
                                      Colors.white,
                                      Colors.white
                                    ])),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CustomizedTextWidget(
                                              color: Colors.red.shade400,
                                              fontSize: 16,
                                              textValue: 'Close')),
                                      const SizedBox(width: 10),
                                      Icon(Icons.close, size: 20,)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.deleteWish();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                                width: size.width * 0.30,
                                decoration: new BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    border: new Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2.0,
                                    ),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFFF01828),
                                      Color(0xFFEF3B85)
                                    ])),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: CustomizedTextWidget(
                                              color: Colors.white,
                                              fontSize: 16,
                                              textValue: 'Delete')),
                                      const SizedBox(width: 10),
                                      Icon(Icons.close, size: 20,color: Colors.white,)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }

}