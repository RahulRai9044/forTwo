import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/statistics/controller/statistics_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

class StatisticsGraph extends StatelessWidget {
  StatisticsGraph({required this.isShowingMainData});

  final bool isShowingMainData;

  StatisticsController controller = Get.find<StatisticsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
        init: StatisticsController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                        isExpanded: true,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        hint: CustomizedTextWidget(
                            color: kTextColor,
                            fontSize: 18,
                            textValue: "Select Month"),
                        onChanged: (newValue) async {
                          controller.selectedDrowpdown = newValue.toString();
                          String? userID = await controller.mPrefrence.getUserId();
                          print(newValue.toString());
                          print(controller.selectedDrowpdown);
                          controller.viewStatisticData(userID);
                          controller.update();
                        },
                        value: controller.selectedDrowpdown,
                        items: [
                          for (var data in controller.dropdownText)
                            DropdownMenuItem(
                              child: CustomizedTextWidget(
                                  color: kTextColor,
                                  fontSize: 15,
                                  textValue: data),
                              value: data,
                            )
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                  controller.flSportsData.isNotEmpty ? SizedBox(
                      height: size.height / 2,
                      child: LineChart(
                        sampleData1,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ) : Container(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/no_data_found.png",
                            height: size.height * 0.2,
                            width: size.width * 0.4,
                          ),
                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          CustomizedTextWidget(
                            color: buttonFirstColor,
                            fontSize: 15,
                            textValue:
                            'No data for this month',
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Poppins-Regular',
                          ),
                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          //SizedBox
                          //SizedBox
                        ],
                      ), //Column
                    ),
                  ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 5,
        maxY: 100,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 25:
        text = '25';
        break;
      case 50:
        text = '50';
        break;
      case 75:
        text = '75';
        break;
      case 100:
        text = '100';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 30,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = new Text("0", style: style);
        break;
      case 1:
        text = Text(controller.datesStats[0], style: style);
        break;
      case 2:
        text = Text(controller.datesStats[1], style: style);
        break;
      case 3:
        text = Text(controller.datesStats[2], style: style);
        break;
      case 4:
        text = Text(controller.datesStats[3], style: style);
        break;
      default:
        text = Text("", style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(
      show: true, drawHorizontalLine: true, drawVerticalLine: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.green.withOpacity(0.2), width: 2),
          left: BorderSide(color: Colors.green.withOpacity(0.2), width: 2),
          top: BorderSide(color: Colors.green.withOpacity(0.2), width: 2),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: controller.flSportsData,
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.pinkAccent,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: controller.flSportsDataUser,
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Colors.cyan,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: controller.flSportsDataPartner,
      );
}
