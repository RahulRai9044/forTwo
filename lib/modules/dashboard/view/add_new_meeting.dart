import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/dashboard/controller/new_meeting_controller.dart';
import 'package:for_two/modules/dashboard/view/tool_bar.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:for_two/utils/value_change_listner.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddNewMeeting extends StatefulWidget {
  const AddNewMeeting({super.key});

  @override
  State<AddNewMeeting> createState() => _AddNewMeetingViewState();
}

class _AddNewMeetingViewState extends State<AddNewMeeting> implements OnDialogListListner{


  late  double longitude=0;
  late  double latitude=0;


  // init the position using the user location
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<NewMeetingController>(
            init: NewMeetingController(),
            builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomToolbar(),
                    Text('Add New Meeting',
                        style: Theme.of(context).textTheme.bodyText1),
                    const Spacer(),
                    const SizedBox(height: 20),
                    Form(
                      key: controller.addNewMeetingFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Invitee Name*',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              controller: controller.inviteeNameController,
                              inputType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Invitee Phone No. *',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              controller: controller.inviteePhoneController,
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Meeting Date *',
                              controller: controller.meetingDateController,
                              inputType: TextInputType.none,
                              onPressed: () {
                                setState(() {
                                  controller.selectDate(context);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Meeting Time *',
                              controller: controller.meetingTimeController,
                              inputType: TextInputType.none,
                              onPressed: () {
                                setState(() {
                                  controller.selectTime(context);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Meeting Address *',
                              controller: controller.invitationAddressController,

                              onPressed: (){



                              },

                              inputType: TextInputType.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          InputTextField(
                              textColors: kBlackColor,
                              text: 'Meeting Price *',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4)
                              ],
                              controller: controller.invitationPriceController,
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                } else if (controller
                                        .invitationPriceController.text.length >
                                    5) {
                                  return 'Please enter value in 4 digit only';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(height: size.height * 0.1),
                    CommonElevatedButton(
                      onTap: () async {
                        if (controller.addNewMeetingFormKey.currentState!
                            .validate()) {
                          await controller.addNewMeeting(
                              meetingStatus: "Created",
                              meetingLat: latitude.toString(),
                              meetingLng: longitude.toString());
                        }
                      },
                      title: 'Save',
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  onListenDailog() {
   setState(() {

     print(StringValues.location);
     print("StringValues.location");
    // invitationAddressController.text = StringValues.location;
     print("NewMeetingController().invitationAddressController.text");
     print(NewMeetingController().invitationAddressController.text);

   });
  }



}

class StringValues{

 static String location='';

}
