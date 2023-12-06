import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/utils/calendar_utils.dart';
import 'package:for_two/utils/size.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:for_two/modules/calanderPage/controller/calander_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:get/get.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CalendarController>(
            init: CalendarController(),
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
                      ),
                    )
                  : Column(children: [
                    TableCalendar<Event>(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: controller.focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(controller.selectedDay, day),


                      calendarFormat: controller.calendarFormat,
                      eventLoader: controller.getEventsForDay,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: CalendarStyle(
                        // Use `CalendarStyle` to customize the UI
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: buttonSecondColor, // inner circle color
                        ),
                        outsideDaysVisible: false,
                        selectedDecoration: BoxDecoration(
                            color: buttonFirstColor,
                            shape: BoxShape.circle),
                        defaultTextStyle:
                            TextStyle(color: Color(0xFF49454F)),
                        weekNumberTextStyle: TextStyle(color: Colors.grey),
                        weekendTextStyle: TextStyle(color: Colors.pink),
                      ),
                      onDaySelected: controller.onDaySelected,
                      onFormatChanged: (format) {
                        if (controller.calendarFormat != format) {
                          controller.calendarFormat = format;
                        }
                      },

                      onPageChanged: (focusedDay) {
                        controller.focusedDay = focusedDay;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: controller.selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    {value[index].status}.contains("new")  ?
                                    Image.asset("assets/images/pending_wishes.png",
                                      height: 30,width: 30,) : Icon(Icons.check_circle_rounded,size: 30,color: Colors.green.shade600,),
                                    // CustomizedTextWidget(
                                    //     color: buttonFirstColor,
                                    //     fontSize: 16,
                                    //     textValue: '${value[index].dateTime}'),
                                    const SizedBox(width: 5),
                                    Container(
                                        width: size.width * 0.70,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFF01828),
                                                  Color(0xFFEF3B85)
                                                ])),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.all(10.0),
                                          child: CustomizedTextWidget(
                                            color: Colors.white,
                                            fontSize: 16,
                                            textValue: '${value[index]}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]);
            }));
  }
}
