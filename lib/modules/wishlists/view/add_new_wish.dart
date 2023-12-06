import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/wishlists/controller/new_wish_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class AddNewWish extends StatelessWidget {
  const AddNewWish({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomizedTextWidget(
          color: buttonFirstColor,
          fontSize: 25,
          textValue: 'Add new wish',
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<AddNewWishController>(
          init: AddNewWishController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTextField(
                          controller: controller.wishTitleController,
                          textColors: kTextColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                          text: 'Title'),
                      const SizedBox(height: 20),

                      CustomizedTextWidget(
                        color: kTextColor,
                        fontSize: 15,
                        textValue:
                        'Describe your wish',
                        fontFamily: 'Poppins-Regular',
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Color(0xFFDBDBDB), style: BorderStyle.solid)),
                          child: TextField(
                            controller: controller.wishDescriptionController,
                            minLines: 5,
                            maxLines: 10,
                            decoration: const InputDecoration(
                                hintText: 'wish description',
                                contentPadding: EdgeInsets.all(5),
                                border: InputBorder.none),
                            onChanged: (value) {},
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      CustomizedTextWidget(
                          color: kTextColor,
                          fontSize: 15,
                          textValue: 'Select Points'),

                      const SizedBox(height: 10),

                      GridView(
                        shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: (1 / .4),
                          ),
                        children: List.generate(5, (index) {
                          return  GestureDetector(

                            onTap: (){

                              controller.selectPoints(index);

                            },

                            child: Opacity(
                              opacity: controller.selectedCard == index ? 0.5 : 1.0,
                              child: Container(
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: Colors.white,
                                        width: 2.0,),
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFF01828),
                                        Color(0xFFEF3B85)
                                      ])),
                                  child: Center(
                                      child: CustomizedTextWidget(
                                          color: Colors.white,
                                          fontSize: 15,
                                          textValue: controller.pointsListData[index]['points'] +' pts'))),
                            ),
                          );


                        })
                      ),


                      const SizedBox(height: 20),

                      InputTextField(
                          controller: controller.addWishDateController,
                          textColors: kTextColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                          icon: Icons.calendar_today,
                          onTap: (){
                            controller.selectDate(context);

                          },
                          text: 'Assign date to fulfill your wish'),

                      const SizedBox(height: 20),

                      Center(
                        child: CommonElevatedButton(
                          height: size.height * 0.05,
                          width: size.width * 0.6,
                          title: 'Add Wish',
                          onTap: () async {
                            var isValid =
                            controller.formKey.currentState!.validate();
                            if (isValid) {
                                 await controller.addNewWishListData();

                            }
                          },
                        ),
                      ),

                       SizedBox(height: 20),
                      Image.asset(
                        "assets/images/home_bottom.png",
                        height: size.height * 0.1,
                        width: size.height,
                        fit: BoxFit.fitWidth,
                      ),

                      SizedBox(height: 20),

                      Center(child: CustomizedTextWidget(color: buttonFirstColor, fontSize: 20, textValue: '\"A couple who plays together \n stays together\"',fontWeight: FontWeight.bold,textAlignment: TextAlign.center,)),

                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
