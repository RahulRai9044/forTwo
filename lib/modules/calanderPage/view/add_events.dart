import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/calanderPage/controller/add_events_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class AddEventsScreen extends StatelessWidget {
  const AddEventsScreen({super.key});

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
                textValue: "Add Event",
                fontFamily: 'Poppins-SemiBold',
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: GetBuilder<AddEventController>(
                init: AddEventController(),
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue:"Event Type"),
                              DropdownButton(
                                  isExpanded: true,
                                  hint: CustomizedTextWidget(color: kTextColor, fontSize: 18, textValue: "Select Event Type"),
                                  onChanged: (newValue) {
                                    controller.selectedEventType=newValue.toString();
                                    controller.update();
                                  },
                                  value: controller.selectedEventType,
                                  items: [
                                    for (var data in controller.allEventTypes)
                                      DropdownMenuItem(
                                        child: CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue: data),
                                        value: data,
                                      )
                                  ]),



                              const SizedBox(
                                height: 10,
                              ),
                              InputTextField(
                                textColors: kTextColor,
                                text: "Event Name",
                                controller: controller.eventName,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return IntlKeys.required.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              InputTextField(
                                textColors: kTextColor,
                                text: "Event Date",
                                readOnly: true,
                                controller: controller.eventDate,
                                inputType: TextInputType.none,
                                icon: Icons.calendar_today,
                                onTap: (){

                                  _selectDate(context, controller);

                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return IntlKeys.required.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [
                                  CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue:"Event Visibility :"),
                                  Radio(
                                    value: 0,
                                    groupValue: controller.radioVal,
                                    onChanged: (int? value) {
                                      if (value != null) {

                                        controller.changeEventVisibility(value);

                                      }
                                    },
                                  ),
                                  CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue:"Self"),
                                  Radio(
                                    value: 1,
                                    groupValue: controller.radioVal,
                                    onChanged: (int? value) {
                                      if (value != null) {

                                       controller.changeEventVisibility(value);

                                      }
                                    },
                                  ),
                                  CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue:"With Partner"),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              CommonElevatedButton(
                                height: size.height * 0.05,
                                width: size.width * 1.0,
                                title: 'Add Event',
                                onTap: () async {


                                  controller.addEventsCalender();

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






  Future<void> _selectDate(BuildContext context,AddEventController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: buttonFirstColor, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.blueAccent, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: buttonSecondColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: controller.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1920),
        lastDate: DateTime(2030));
    if (picked != null) controller.selectedDate = picked;
    controller.selectDate(controller.selectedDate);

  }

}
