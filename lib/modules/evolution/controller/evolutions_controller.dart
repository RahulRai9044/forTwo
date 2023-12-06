import 'package:flutter/material.dart';
import 'package:for_two/modules/evolution/models/evaluations_model.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EvolutionsController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  late bool isShowingMainData;
  late bool isExpanded=false;
   bool isLoading=false;

  late TextEditingController feedbackController;
  late TextEditingController evaluationGoodAreasController;
  late TextEditingController improvementAreaController;

  late TextEditingController partnerFeedbackController;
  late TextEditingController PartnerEvaluationGoodAreasController;
  late TextEditingController partnerImprovementAreaController;


  final AuthService _auth = AuthService();
  final Prefrence _mPrefrence = Prefrence();

  RxList _evolutionList = [].obs;
  RxList get evolutionList => _evolutionList;

  Partner? _getLatestEvaluation;
  Partner? get latestEvaluationsData => _getLatestEvaluation;

  bool showAddEvaluationsButton=false;



  Partner? _getPartnerLatestEvaluation;
  Partner? get latestPatnerEvaluationsData => _getPartnerLatestEvaluation;


  late EvaluationsListData? _getEvaluationsData;
  EvaluationsListData? get evaluationsData => _getEvaluationsData;

  var now = new DateTime.now();
  var formattedDate;
  var currentDate;

  @override
  Future<void> onInit() async {
    tabController = TabController(vsync: this, length: 2);
    isShowingMainData = true;

    feedbackController = TextEditingController();
    evaluationGoodAreasController = TextEditingController();
    improvementAreaController = TextEditingController();


    partnerFeedbackController = TextEditingController();
    PartnerEvaluationGoodAreasController = TextEditingController();
    partnerImprovementAreaController = TextEditingController();



    var friday=5;

    DateTime todayEvaluation = DateTime.now();
    currentDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(todayEvaluation);
    while(now.weekday!=friday)
    {
      now=now.add(new Duration(days: 1));

      formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(now);

    }

    print('Recent friday $formattedDate');

    print('Recent friday $currentDate');


    String? userID = await _mPrefrence.getUserId();
    if(userID.isNotEmpty){

      getEvaluationsList(userID);

    }else{


    }


    super.onInit();
  }

  String evaluationDate(DateTime evaluationDates){

    String evaluationDate= DateFormat("yyyy-MM-dd").format(evaluationDates);

    return evaluationDate;

  }

  String evaluationTime(DateTime evaluationDates){

    String evaluationDate= DateFormat("hh:mm a").format(evaluationDates);

    return evaluationDate;

  }

  changeExpansionFlutter(){

    if(isExpanded){
      isExpanded=false;

    }else{
      isExpanded=true;

    }


  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }


  getEvaluationsList(String userDetail)  async {
    isLoading = true;
    _getEvaluationsData = await _auth.userEvolutionsListData(userId: userDetail);
    if (_getEvaluationsData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");
      print(_getEvaluationsData!.result!);
     evolutionList.clear();
     evolutionList.addAll(_getEvaluationsData!.result!.user!.toList(growable: true));
      _getLatestEvaluation=null;
      if(_getEvaluationsData!.result!.user!.length  > 0) {
        _getLatestEvaluation = _getEvaluationsData!.result!.user![_getEvaluationsData!.result!.user!.length-1];

        if(_getLatestEvaluation!.evaluationDate != null){
          print("daysBetween");
          print(_getLatestEvaluation!.evaluationDate!);
          print(now);
          int daysBtn= daysBetween(_getLatestEvaluation!.evaluationDate!, now);
          print(daysBtn);
          if(daysBtn >= 7){

            showAddEvaluationsButton=true;


          }else{

            showAddEvaluationsButton=false;

          }

        }
      }
    if(_getLatestEvaluation?.id != null){

      feedbackController.text=_getLatestEvaluation?.feedback ?? "";
      evaluationGoodAreasController.text=_getLatestEvaluation?.goodAreas ?? "";
      improvementAreaController.text=_getLatestEvaluation?.improvementAreas ?? "";

    }

     // _getEvaluationsData=null;
    if(_getEvaluationsData!.result!.partner!.isNotEmpty){
      _getPartnerLatestEvaluation=_getEvaluationsData!.result!.partner![_getEvaluationsData!.result!.partner!.length-1];

    }
    if(_getPartnerLatestEvaluation?.id != null){

      partnerFeedbackController.text=_getPartnerLatestEvaluation?.feedback ?? "";
      PartnerEvaluationGoodAreasController.text=_getPartnerLatestEvaluation?.goodAreas ?? "";
      partnerImprovementAreaController.text=_getPartnerLatestEvaluation?.improvementAreas ?? "";

    }
      print(_getPartnerLatestEvaluation?.id);
    print(_getLatestEvaluation?.id);

    } else {



    }
    isLoading=false;
    update();

   }
  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
    evaluationGoodAreasController.dispose();
    improvementAreaController.dispose();


    partnerFeedbackController.dispose();
    PartnerEvaluationGoodAreasController.dispose();
    partnerImprovementAreaController.dispose();

  }


}