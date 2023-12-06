import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:for_two/modules/statistics/model/statistics_data.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/constants.dart';
import 'package:for_two/utils/ext.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatisticsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  late bool isShowingMainData;



  String formatDate(DateTime dateTime) => DateFormat('dd MMM').format(dateTime);

  bool isLoading = false;
  bool badgeStatus = true;
  var tabIndex = 0;
  final AuthService _auth = AuthService();

  final Prefrence mPrefrence = Prefrence();

  late StatisticsData? _userWishListData;
  StatisticsData? get userWishlist => _userWishListData;


  final List<Result> userStatisticsData = [];
  List<Result> get record => userStatisticsData;

  final List<FlSpot> flSportsData = [];
  final List<FlSpot> flSportsDataUser = [];
  final List<FlSpot> flSportsDataPartner = [];

  var selectedDrowpdown ='';
  List dropdownText = ['January', 'February','March','April','May','June','July','August','September','October','November','December'];

  late List<String> datesStats=[];



  viewStatisticData(String userDetail)  async {
    isLoading = true;
    userStatisticsData.clear();
    _userWishListData = await _auth.userStatisticsData(userId: userDetail);
    if (_userWishListData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");

      userStatisticsData.assignAll(_userWishListData!.result);

      double? statisticsPoints=0;
      int userStatisticsPoints=0;
      int partnerStatisticsPoints=0;
      flSportsData.clear();
      flSportsDataUser.clear();
      flSportsDataPartner.clear();
      flSportsData.add(FlSpot(0 ,0));
      flSportsDataUser.add(FlSpot(0 ,0));
      flSportsDataPartner.add(FlSpot(0 ,0));
      for(int i=0;i<_userWishListData!.result.length;i++){

        statisticsPoints=_userWishListData!.result[i].averageScore;
        userStatisticsPoints=_userWishListData!.result[i].userScore ?? 0;
        partnerStatisticsPoints=_userWishListData!.result[i].partnerScore ?? 0;
     //   flSportsData.add(FlSpot(0 ,0));

        String resultDate=getMonthName(_userWishListData!.result[i].resultDate);


        print(resultDate);

        if(selectedDrowpdown == resultDate){


          flSportsData.add(FlSpot(double.parse((i+1).toString()) ,statisticsPoints!));
          flSportsDataUser.add(FlSpot(double.parse((i+1).toString()) ,double.parse(userStatisticsPoints.toString())));
          flSportsDataPartner.add(FlSpot(double.parse((i+1).toString()) ,double.parse(partnerStatisticsPoints.toString())));

        }else{

          flSportsData.clear();
          flSportsDataUser.clear();
          flSportsDataPartner.clear();


        }


      }


      print("userStatisticsData");
      print(flSportsData);
    } else {

    }
    update();

  }


    String statisticDate(DateTime? date)  {
    final f = new DateFormat('dd,MMM,yyyy');
    return f.format(date!);

  }

  String getMonthName(DateTime? date)  {
    final f = new DateFormat('MMMM');
    return f.format(date!);

  }

  findDates() {
    var now = DateTime.now();
    var firstOfMonth = DateTime(now.year, now.month, 1);
    var firstMonday = firstOfMonth.addCalendarDays((7 - (firstOfMonth.weekday - DateTime.friday)) % 7);
    var currentMonday= firstMonday;
    datesStats.clear();
    while (currentMonday.month == now.month) {
      var nextMonday = currentMonday.addCalendarDays(7);
    //  var nextSunday = nextMonday.addCalendarDays(-1);
      print('${formatDate(currentMonday)}');

      datesStats.add(formatDate(currentMonday));
      currentMonday = nextMonday;


    //  datesStats.add(currentMonday);

      print(datesStats);

    }
  }


  String statisticGraphDate(DateTime? date)  {
    final f = new DateFormat('dd,MMM');
    return f.format(date!);

  }


/*  shareOnFacebook() async {
    String? result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://play.google.com/store/apps/details?id=com.fundrivegames.mega.ramp.ultimate.cars.stunts.impossibletracks&hl=en-IN",
        quote: "captions");
    print("Rahul");
    print(result);
    print("Rahul");
  }*/







  @override
  Future<void> onInit() async {

    tabController = TabController(vsync: this, length: 2);
    isShowingMainData = true;
    findDates();
    String? userID = await mPrefrence.getUserId();

    selectedDrowpdown=DateFormat('MMMM').format(DateTime.now());

    if(userID.isNotEmpty){

      viewStatisticData(userID);


    }else{


    }



    super.onInit();





  }


}