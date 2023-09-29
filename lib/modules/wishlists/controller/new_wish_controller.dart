import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/model/user.dart';
import 'package:for_two/modules/dashboard/model/add_meeting.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNewWishController extends GetxController  {
  final Prefrence mPrefrence = Prefrence();

  late TextEditingController wishTitleController;
  late TextEditingController meetingDateController;
  late TextEditingController meetingTimeController;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString controllerText = ''.obs;
  dynamic argumentData = Get.arguments;

  late GlobalKey<FormState> addNewMeetingFormKey;



  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
                   lastDate: DateTime(2101));
    if (picked != null) selectedDate = picked;
    meetingDateController.text = DateFormat.yMMMMEEEEd().format(selectedDate);
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) selectedTime = picked;
    _hour = selectedTime.hour.toString();
    _minute = selectedTime.minute.toString();
    _time = _hour + ' : ' + _minute;
    meetingTimeController.text = _time;
    meetingTimeController.text = formatDate(
        DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
  }






  @override
  void onInit() {
    super.onInit();

    wishTitleController = TextEditingController();

    meetingDateController = TextEditingController();
    meetingTimeController = TextEditingController();

    addNewMeetingFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();

    wishTitleController.dispose();
    meetingTimeController.dispose();
    meetingTimeController.dispose();

  }

}
