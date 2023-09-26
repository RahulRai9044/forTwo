import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class MyWishList extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishListController());
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

                      child:   Align(
                        alignment:
                        // confetti will pop from top-center
                        Alignment.topCenter,
                        child: ConfettiWidget(
                          confettiController: controller.topController,
                          blastDirection: pi / 2,
                          maxBlastForce: 5,
                          minBlastForce: 1,
                          emissionFrequency: 0.01,

                          // 10 paticles will pop-up at a time
                          numberOfParticles: 20,

                          // particles will come down
                          gravity: 1,

                          // start again as soon as the
                          // animation is finished
                          shouldLoop: true,
                          // assign colors of any choice
                          colors: const [
                            Colors.green,
                            Colors.yellow,
                            Colors.pink,
                            Colors.orange,
                            Colors.blue
                          ],
                        ),
                      ),
                        // child: Center(
                        //   child: TextButton(
                        //       onPressed: () {
                        //
                        //         // invoking confettiController
                        //         // to come into play
                        //      //   _topController.play();
                        //       },
                        //       child: Text('Top',
                        //           style: const TextStyle(
                        //               color: Colors.white, fontSize: 20))),
                        // ),


                    )
                )
              ],



            ),
          ),
        )

    );

  }



}