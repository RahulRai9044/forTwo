import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/modules/wishlists/view/my_wishlist.dart';
import 'package:for_two/modules/wishlists/view/partner_wishlist.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class WishListScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {


    return GetBuilder<WishListController>(
        init: WishListController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Image.asset(
                    "assets/images/star_icon.png",
                    height: 30,
                    width: 30,
                  ),
                ),

              ],
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
                        child: CustomizedTextWidget(color: buttonFirstColor,
                            fontSize: 12,
                            textValue: 'My Wishes'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomizedTextWidget(color: buttonFirstColor,
                            fontSize: 12,
                            textValue: 'My Partner’s Wishes'),
                      ),
                    ],
                  ),
                ),
              ),
              title: CustomizedTextWidget(
                  color: kBlackColor, fontSize: 18, textValue: 'Wishlist'),
              centerTitle: true,
            ),
            body: TabBarView(
              controller: controller.tabController,
              children: [
                MyWishList(),
                PartnerWishList(),
                // BikePage(),
              ],
            ),
          );
        }

    );
  }

}