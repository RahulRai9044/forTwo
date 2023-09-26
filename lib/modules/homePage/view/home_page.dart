import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/modules/dashboard/view/add_new_meeting.dart';
import 'package:for_two/modules/dashboard/view/tool_bar.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 20, right: 20),
                    child: Column(
                      children: [

                        CustomToolbar(),

                        CustomizedTextWidget(color: buttonFirstColor, fontSize: 35, textValue: ' ForTwo',fontWeight: FontWeight.bold,),

                        const SizedBox(height: 20),

                        LiquidCustomProgressIndicator(
                          value: controller.percent / 100,
                          center: CustomizedTextWidget(color: kBlackColor ?? Colors.grey.shade700, fontSize: 28, textValue: '50%'),
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                          backgroundColor: Colors.grey[100],
                          direction: Axis.vertical,
                          shapePath: controller.buildBoatPath(),
                        ),

                        const SizedBox(height: 20),

                        CustomizedTextWidget(color: buttonFirstColor, fontSize: 15, textValue: 'Lorem Ipsum is simply dummy text of the printing  and  \n typesetting industry . Lorem Ipsum has been the industry\'s  \n standard dummy text ever since the 1500s,',fontWeight: FontWeight.normal,textAlignment: TextAlign.center,),

                        const SizedBox(height: 30),

                        CommonElevatedButton(
                          height: size.height * 0.05,
                          width: size.width * 0.50,
                          title: 'Continue to PLay',
                          onTap: () async {
                            //Get.offAll(() => DashboardScreen());
                          },
                        ),

                        const SizedBox(height: 30),

                        Image.asset(
                          "assets/images/home_bottom.png",
                          height: size.height * 0.1,
                          width: size.height,
                        ),

                        const SizedBox(height: 30),

                        CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: '\"A couple who plays together \n stays together\"',fontWeight: FontWeight.bold,textAlignment: TextAlign.center,),
                      ],
                    ),
                  );
          }),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
