import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/modules/wishlists/view/partner_wish_update.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
class PartnerWishList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return GetBuilder<WishListController>(
        init: WishListController(),
    builder: (controller) {

      return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height/2,
                    width: size.width,
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFC7D4F9),
                            Color(0xFFC9D3EC),
                            Color(0xFFE8EBF4),
                            Color(0xFFF4C8D7),
                            Color(0xFFFFF5EB)
                          ],
                          tileMode: TileMode.clamp),

                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child:  controller.partnerWishListData.isNotEmpty
                              ? ListView.builder(

                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            // number of items in your list
                            itemCount: controller.partnerWishListData.length, itemBuilder: (BuildContext context, int index) {

                            return  GestureDetector(

                              onTap: (){

                                Get.to(() => const PartnerWishUpdateScreen(),arguments: controller.partnerWishListData[index]);

                              },

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    controller.partnerWishListData[index].status == 'new' ?
                                    Image.asset("assets/images/pending_wishes.png",
                                      height: 30,width: 30,) : Icon(Icons.check_circle_rounded,size: 30,color: Colors.green.shade600,),

                                    const SizedBox(width: 5),
                                    Container(
                                        width: size.width * 0.60,
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
                                          child: CustomizedTextWidget(color: Colors.white, fontSize: 16,
                                            textValue: controller.partnerWishListData[index].title,
                                            overflow: TextOverflow.ellipsis,),
                                        )),
                                    const SizedBox(width: 5),
                                    Container(
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
                                          child: Center(child: CustomizedTextWidget(color: Colors.white, fontSize: 16, textValue: controller.partnerWishListData[index].points.toString() + ' Pts')),
                                        )),
                                  ],

                                ),
                              ),
                            );


                          },
                          ) : Container(
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
                                    CustomizedTextWidget(
                                      color: buttonFirstColor,
                                      fontSize: 15,
                                      textValue:
                                      'No Data Found ',
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    //SizedBox
                                    //SizedBox
                                  ],
                                ), //Column
                              ), //SizedBox
                            ),
                          ) ,
                        ),
                      ],
                    ),
                  ),

                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: size.height/ 4,
                        width: size.width,

                        child:   Stack(
                          children: [

                            Align(
                              alignment:
                              // confetti will pop from top-center
                              Alignment.topCenter,
                              child: ConfettiWidget(
                                maximumSize: Size(20, 30),
                                shouldLoop: false,
                                confettiController: controller.topController,
                                blastDirection: pi/5,
                                blastDirectionality: BlastDirectionality.explosive,
                                maxBlastForce: 20, // set a lower max blast force
                                minBlastForce: 8, // set a lower min blast force
                                emissionFrequency: 1,
                                numberOfParticles: 5, // a lot of particles at once
                                gravity: 1,
                              ),

                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [

                                Image.asset(
                                  "assets/images/dreamer_badge.png",
                                  height: size.height * 0.10,
                                  width: size.width * 0.2,
                                ),

                                Center(
                                  child: CustomizedTextWidget(color: Colors.red, fontSize: 16, textValue: 'Level 1 Completed',fontWeight: FontWeight.w700,),
                                ),


                                Visibility(
                                  visible: false,
                                  child: Expanded(
                                    child: Center(
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 15,
                                            left: size.width *0.22,
                                            height:size.height * 0.15,
                                            width: size.width * 0.25,
                                            child: RotationTransition(
                                              turns: new AlwaysStoppedAnimation(-15 / 360),
                                              child: Container(
                                                width: size.width * 0.25,
                                                height:  size.height * 0.25,
                                                decoration: BoxDecoration(
                                                  color: imageCardBackgroundColor,
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.red.withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [

                                                    Image.asset(
                                                      "assets/images/partner_image.png",
                                                      height: size.height * 0.12,
                                                      width:  size.width * 0.25,
                                                      fit: BoxFit.fill,
                                                    ),

                                                    CustomizedTextWidget(color: Colors.white, fontSize: 12, textValue: 'Lisa  90 pts',),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            top: 15,
                                            left: size.width *0.25 + size.width * 0.25,
                                            width: size.width * 0.25,
                                            height: size.height * 0.15,
                                            child: RotationTransition(
                                              turns: new AlwaysStoppedAnimation(15 / 360),
                                              child: Container(
                                                width: size.width * 0.25,
                                                height: size.height * 0.15,
                                                decoration: BoxDecoration(
                                                  color: imageCardBackgroundColor,
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.red.withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/user_image.png",
                                                      height: size.height * 0.12,
                                                      width: size.width * 0.25,
                                                      fit: BoxFit.fill,
                                                    ),

                                                    CustomizedTextWidget(color: Colors.white, fontSize: 12, textValue: 'Matt   150 pts',),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Center(
                                      child: CustomizedTextWidget(color: Colors.red, fontSize: 16, textValue: 'Total Score : 245/1000',fontWeight: FontWeight.w700,),
                                    ),
                                  ),
                                ),
                              ],



                            ),

                          ],
                        ),


                      )
                  )
                ],



              ),
            ),
          )

      );


    }
    );

  }



}