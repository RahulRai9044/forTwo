import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/evolution/controller/evolutions_controller.dart';
import 'package:for_two/modules/evolution/view/add_evolutions.dart';
import 'package:for_two/modules/evolution/view/edit_evaluations_screen.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class EvolutionsHistory extends StatelessWidget{
  const EvolutionsHistory({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EvolutionsController());
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0),
        child:  controller.evolutionList.isNotEmpty ? Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.evolutionList.length,
          itemBuilder: (BuildContext context, int index) {

            return GestureDetector(

              onTap: (){

                Get.to(EditEvaluationScreen(),arguments:controller.evolutionList[index]);

              },

              child: ListTile(
                trailing: Container(
                    height: 40,
                    width: size.width * 0.30,
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
                      child: Center(child: CustomizedTextWidget(color: Colors.white, fontSize: 12, textValue: controller.evaluationTime(controller.evolutionList[index].evaluationDate))),
                    )),
                title:  Container(
                    width: size.width * 0.70,
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
                      child: CustomizedTextWidget(color: Colors.white, fontSize: 16, textValue: controller.evaluationDate(controller.evolutionList[index].evaluationDate),overflow: TextOverflow.ellipsis,),
                    )),
              ),
            ) ;
            //Card


          },
        )) :   Center(
          child: Container(
          width: size.width,
          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    "assets/images/no_data_found.png",
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                  ),
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  CustomizedTextWidget(color: buttonFirstColor, fontSize: 15, textValue: 'No Evaluation added yet !', overflow: TextOverflow.ellipsis,
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

                      Get.to(AddEvolutionsScreen());

                    },
                  ) //SizedBox
                ],
              ), //Column
            ), //SizedBox
          ),
          ),
        ),
      ),

    );

  }



}