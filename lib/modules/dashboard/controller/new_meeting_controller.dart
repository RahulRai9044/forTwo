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

class NewMeetingController extends GetxController  {

  CollectionReference _mNewMeetingCollection = FirebaseFirestore.instance.collection("InvitationsList");
  CollectionReference _mUserFirebaseInstance = FirebaseFirestore.instance.collection('userData');
  final Prefrence mPrefrence = Prefrence();

  late TextEditingController inviteeNameController;
  late TextEditingController inviteePhoneController;
  late TextEditingController meetingDateController;
  late TextEditingController meetingTimeController;
  late TextEditingController invitationAddressController;
  late TextEditingController invitationPriceController;
  late TextEditingController invitationOTPController;
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

  Future<NewMeetingModel?> addNewMeeting(
      {required String meetingStatus,
        required String meetingLat,
        required String meetingLng,
      }) async {
    EasyLoading.show(status: 'Please wait');

    String? userDetail = await mPrefrence.getUserId();
    try {

      dynamic dataToSubmit = {
        'inviteeName': inviteeNameController.text,
        'inviteePhoneNumber': inviteePhoneController.text,
        'inviterName': 'Rahul',
        'inviterUID': userDetail,
        'meetingAddress': invitationAddressController.text,
        'meetingDate': meetingDateController.text,
        'meetingLat': meetingLat,
        'meetingLng': meetingLng,
        'meetingPrice': invitationPriceController.text,
        'meetingStatus': meetingStatus,
        'meetingTime': meetingTimeController.text,
      };

      DocumentReference ref = _mNewMeetingCollection.doc();
     // DocumentReference applicationIdRef = _mNewMeetingCollection.doc(userDetail);
    //  await ref.set({"meetingDetails": FieldValue.arrayUnion([dataToSubmit])},
      await ref.set(dataToSubmit,
          SetOptions(merge : true)).then((value) => {
            //   newMeeting=value;
            if (EasyLoading.isShow)
              {EasyLoading.dismiss()}
            else
              {EasyLoading.dismiss()},

               getInviteeFCMToken(inviteePhoneController.text),

               Get.back(),


          });
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      ApplicationUtils.showSnackBar(
          titleText: "Failed", messageText: e.message);
    }
    return null;
  }


  Future<void> getInviteeFCMToken(String inviteePhoneNumber) async {
    final collection = await _mUserFirebaseInstance.where("userPhoneNumber",isEqualTo: inviteePhoneNumber).get();
    Map<String, dynamic> data = collection as Map<String, dynamic>;

    UserData userData=UserData.fromJson(data);

    if(userData.userFCmToken.isNotEmpty){



    }else{


      ApplicationUtils.showSnackBar(
          titleText: "Failed", messageText: 'User phone number not to be empty');


    }

    print(data);
  }



  @override
  void onInit() {
    super.onInit();

    inviteeNameController = TextEditingController();
    inviteePhoneController = TextEditingController();
    meetingDateController = TextEditingController();
    meetingTimeController = TextEditingController();
    invitationAddressController = TextEditingController(text: '');
    invitationPriceController = TextEditingController();
    invitationOTPController = TextEditingController();

    invitationAddressController.addListener(() {
      controllerText.value = invitationAddressController.text;
    });



    addNewMeetingFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();

    inviteeNameController.dispose();
    inviteePhoneController.dispose();
    meetingTimeController.dispose();
    meetingTimeController.dispose();
    invitationAddressController.dispose();
    invitationPriceController.dispose();
    invitationOTPController.dispose();
  }

}
