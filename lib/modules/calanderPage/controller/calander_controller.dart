

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/calanderPage/model/appointments.dart';
import 'package:for_two/modules/wishlists/model/my_wishlist_data.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/calendar_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController with GetSingleTickerProviderStateMixin{
  bool isLoading=false;

  late final ValueNotifier<List<Event>> selectedEvents;
  late final ValueNotifier<List<Event>> selectedEventsAdded;
  CalendarFormat calendarFormat = CalendarFormat.month;
  int _activeIndex = 0;


  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final Prefrence mPrefrence = Prefrence();
  final AuthService _auth = AuthService();

  late WishListDataModel? _userWishListData;
  WishListDataModel? get userWishlist => _userWishListData;



  DateTime selectedDate = DateTime(2015,12,01);


  bool showAddEventBtn=true;



  late EventCalander? _eventCalender;
  EventCalander? get eventCalendarData => _eventCalender;



  // late final ValueNotifier<List<Event>> selectedEvents;
  // CalendarFormat calendarFormat = CalendarFormat.month;
  //
  // DateTime focusedDay = DateTime.now();
  // DateTime? selectedDay;




  Map<DateTime, List<Event>> kEventSource = {};

  Map<DateTime, List<Event>> kEventData = {};
  late TabController tabController;

  final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  final kEventsAdded = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void onClose() {
    selectedEvents.dispose();
    selectedEventsAdded.dispose();
    super.onClose();
  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example

    print(day);
    print(kEvents[day]);
    return kEvents[day] ?? [];
  }




  List<Event> getAddedEventsForDay(DateTime day) {
    // Implementation example

    print(day);
    print(kEventsAdded[day]);
    return kEventsAdded[day] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {

    print("selectedDay");
    print(selectedDay);
    print("focusedDay");
    print(focusedDay);

    if (!isSameDay(selectedDay, selectedDay)) {

      selectedDay = selectedDay;
      focusedDay = focusedDay;

      selectedEvents.value = getEventsForDay(selectedDay);


      print(selectedEvents.value);

      update();
    }else{

      print(focusedDay);
      print("object");
      print(selectedDay);

      focusedDay=selectedDay;
      selectedEvents.value = getEventsForDay(selectedDay);
      update();
    }

  }

  void onDaySelectedAddedEvent(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, selectedDay)) {

      selectedDay = selectedDay;
      focusedDay = focusedDay;

      selectedEventsAdded.value = getAddedEventsForDay(selectedDay);


      print(selectedEventsAdded.value);

      update();
    }else{

      print("object");

      focusedDay=selectedDay;
      selectedEventsAdded.value = getAddedEventsForDay(selectedDay);
      update();
    }

  }


  @override
  Future<void> onInit() async {

    selectedDay = focusedDay;
    selectedEvents = ValueNotifier(getEventsForDay(selectedDay!));
    selectedEventsAdded=ValueNotifier(getEventsForDay(selectedDay!));
    tabController = TabController(vsync: this, length: 2);


    String? userID = await mPrefrence.getUserId();
    if(userID.isNotEmpty){

      viewAllWishListData(userID);

      viewAllEventData(userID);

    }else{



    }





    print(kEvents);

   // print(selectedEvents.value);


    super.onInit();
  }







  viewAllWishListData(String userDetail)  async {
    isLoading = true;
    _userWishListData = await _auth.userWishListData(userId: userDetail);
    if (_userWishListData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");
      print(_userWishListData!.data.toList());
      // userWishList.clear();
      // userWishList.assignAll(_userWishListData!.data);

      for(int i=0;i<_userWishListData!.data.length ;i++){
        DateTime element=_userWishListData!.data[i].startDate;
        String eventTitle=_userWishListData!.data[i].title;
        String eventStatus=_userWishListData!.data[i].status;
        kEventSource[DateTime(
          element.year,
          element.month,
          element.day,
        )] = kEventSource[DateTime(
          element.year,
          element.month,
          element.day,
        )] !=
            null
            ? [
          ...?kEventSource[DateTime(
            element.year,
            element.month,
            element.day,
          )],
          Event(eventTitle,eventStatus)
        ]
        : [Event(eventTitle,eventStatus)];


        print(_userWishListData!.data[i].startDate);

        kEvents.addAll(kEventSource);



      }

    } else {

    }
    update();

  }

  viewAllEventData(String userDetail)  async {
    isLoading = true;
    _eventCalender = await _auth.getEventCalender(userId: userDetail);
    if (_eventCalender?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");
      print(_eventCalender!.data!.toList());
      // userWishList.clear();
      // userWishList.assignAll(_userWishListData!.data);

      if(_eventCalender!.data != null){

        for(int i=0;i<_eventCalender!.data!.length ;i++){
          DateTime? element=_eventCalender!.data![i].eventDate;
          String? eventTitle=_eventCalender!.data![i].eventName;
          kEventData[DateTime(
            element!.year,
            element.month,
            element.day,
          )] = kEventData[DateTime(
            element.year,
            element.month,
            element.day,
          )] !=
              null
              ? [
            ...?kEventData[DateTime(
              element.year,
              element.month,
              element.day,
            )],
            Event(eventTitle!,"")
          ]
              : [Event(eventTitle!,"")];


        //  print(_userWishListData!.data[i].startDate);

          kEventsAdded.addAll(kEventData);



        }

      }



    } else {

    }
    update();

  }



}