import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/evolution/controller/add_evolution_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class AddEvolutionsScreen extends StatelessWidget {
  const AddEvolutionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: CustomizedTextWidget(
                color: buttonFirstColor,
                fontSize: 25,
                textValue: IntlKeys.add_evolutions.tr,
                fontFamily: 'Poppins-SemiBold',
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: GetBuilder<AddEvolutionsController>(
                init: AddEvolutionsController(),
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


                                  controller.addEvaluationData();

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })));
  }
}
