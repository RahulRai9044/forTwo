import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
class PartnerWishList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishListController());
    controller.topController.play();
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height/2.5,
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
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // number of items in your list
                    itemCount: 5, itemBuilder: (BuildContext context, int index) {

                    return  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Row(
                        children: [
                          CustomizedTextWidget(color: buttonFirstColor, fontSize: 16, textValue: '01'),
                          const SizedBox(width: 10),
                          Container(
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
                          const SizedBox(width: 20),
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
                                child: Center(child: CustomizedTextWidget(color: Colors.white, fontSize: 16, textValue: '200 Pts')),
                              )),
                        ],

                      ),
                    );


                  },
                  ),
                ),

                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: size.height/2.5,

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
                            children: [

                              Image.asset(
                                "assets/images/dreamer_badge.png",
                                height: size.height * 0.10,
                                width: size.width * 0.2,
                              ),

                              Center(
                                child: CustomizedTextWidget(color: Colors.red, fontSize: 16, textValue: 'Level 1 Completed',fontWeight: FontWeight.w700,),
                              ),


                              Expanded(
                                child: Center(
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 30,
                                        left: size.width *0.25,
                                        height:150,
                                        width: 150,
                                        child: RotationTransition(
                                          turns: new AlwaysStoppedAnimation(-15 / 360),
                                          child: Container(
                                            width: 150,
                                            height: 150,
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
                                                  height: 120,
                                                  width: 150,
                                                  fit: BoxFit.fill,
                                                ),

                                                CustomizedTextWidget(color: Colors.white, fontSize: 12, textValue: 'Lisa  90 pts',),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 30,
                                        left: size.width *0.25 + 150,
                                        width: 150,
                                        height: 150,
                                        child: RotationTransition(
                                          turns: new AlwaysStoppedAnimation(15 / 360),
                                          child: Container(
                                            width: 150,
                                            height: 150,
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
                                                  height: 120,
                                                  width: 150,
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

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Center(
                                  child: CustomizedTextWidget(color: Colors.red, fontSize: 16, textValue: 'Total Score : 245/1000',fontWeight: FontWeight.w700,),
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



}