
import 'package:flutter/material.dart';
import 'package:for_two/modules/calanderPage/controller/calander_controller.dart';
import 'package:for_two/modules/wishlists/model/wish_list_add.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AddEventController extends GetxController {


  late TextEditingController eventType;
  late TextEditingController eventName;
  late TextEditingController eventDate;

  int radioVal=0;

  late GlobalKey<FormState> formKey;

  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();

  AddWishListData? _addEventData;
  AddWishListData? get addEventData => _addEventData;

  bool isLoading = false;

  var selectedEventType = "Birthday";
  List allEventTypes = ["Health", "Birthday", "Anniversary","Marriage","Convention","Trade","Date","Other"];

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';


  DateTime selectedDate = DateTime.now();


  @override
  void onInit() {
    super.onInit();
    eventType = TextEditingController();
    eventName = TextEditingController();
    eventDate = TextEditingController();




    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    eventType.dispose();
    eventName.dispose();
    eventDate.dispose();


  }

  Future<Null> selectDate(DateTime date) async {
    final f = new DateFormat('yyyy-MM-dd');
    eventDate.text = f.format(date);
    update();
  }

  addEventsCalender() async {
    String? userID = await _prefs.getUserId();

    try {
      isLoading = true;
      _addEventData = await _auth.addEventCalendar(
        userID: userID,
        partnerId: userID,
        eventType: selectedEventType,
        eventName:eventName.text,
        eventDate: eventDate.text,
      );

      if (_addEventData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        String? userID = await _prefs.getUserId();
        if(userID.isNotEmpty){
          CalendarController controller = Get.find<CalendarController>();
          controller.viewAllEventData(userID);

        }else{


        }

        Get.back();


      } else if(_addEventData?.status == AppConstants.StatusFailed){

        ApplicationUtils.showSnackBar(titleText: _addEventData?.status, messageText: _addEventData?.msg);
        isLoading = false;

      }else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();

  }

  void changeEventVisibility(int value) {
    radioVal = value;
    update();
  }




}
