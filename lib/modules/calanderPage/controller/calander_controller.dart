

import 'package:flutter/cupertino.dart';
import 'package:for_two/utils/calendar_utils.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController{
  bool isLoading=false;
  late final ValueNotifier<List<Event>> selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.month;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;



  @override
  void onClose() {
    selectedEvents.dispose();
    super.onClose();
  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);
  //
  //   return [
  //     for (final d in days) ...getEventsForDay(d),
  //   ];
  // }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, selectedDay)) {

      selectedDay = selectedDay;
      focusedDay = focusedDay;

      selectedEvents.value = getEventsForDay(selectedDay);

      update();
    }
  }


  @override
  void onInit() {
    selectedDay = focusedDay;
    selectedEvents = ValueNotifier(getEventsForDay(selectedDay!));
    super.onInit();
  }
}