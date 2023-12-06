
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/evolution/controller/evolutions_controller.dart';
import 'package:for_two/modules/evolution/models/evaluations_model.dart';
import 'package:for_two/modules/wishlists/model/wish_list_add.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class EditEvaluationController extends GetxController {
  late TextEditingController feedbackController;
  late TextEditingController evaluationGoodAreasController;
  late TextEditingController improvementAreaController;
  late GlobalKey<FormState> formKey;

  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();

  AddWishListData? _addWishListData;
  AddWishListData? get addWishList => _addWishListData;


  Partner? _getSelectedEvaluation;
  Partner? get selectedEvaluationsData => _getSelectedEvaluation;


  bool isLoading = false;

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int currentValue = 5;

  int currentValueTwo = 5;

  CollectionReference mUserFirebaseInstance = FirebaseFirestore.instance.collection('userData');

  var now = new DateTime.now();
  var formattedDate;
  var currentDate;
  var _evaluationId;


  changeEvolutionsNumberOne(int currentValues) {
    currentValue = currentValues;
    update();
  }

  changeEvolutionsNumberTwo(int currentValues) {
    currentValueTwo = currentValues;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    feedbackController = TextEditingController();
    evaluationGoodAreasController = TextEditingController();
    improvementAreaController = TextEditingController();


    if(Get.arguments != null){

      _getSelectedEvaluation=Get.arguments;

      if(_getSelectedEvaluation?.id != null){

        _evaluationId=_getSelectedEvaluation?.id;

      }

      if(_getSelectedEvaluation?.id != null){

        _evaluationId=_getSelectedEvaluation?.id;

      }
      if(_getSelectedEvaluation?.id != null){

        _evaluationId=_getSelectedEvaluation?.id;

      }

      if(_getSelectedEvaluation?.feedback != null){

        feedbackController.text=_getSelectedEvaluation?.feedback ?? "";

      }

      if(_getSelectedEvaluation?.goodAreas != null){

        evaluationGoodAreasController.text=_getSelectedEvaluation?.goodAreas ?? "";

      }

      if(_getSelectedEvaluation?.improvementAreas != null){

        improvementAreaController.text=_getSelectedEvaluation?.improvementAreas ?? "";

      }

      if(_getSelectedEvaluation?.score != null){

        double firstNumber=_getSelectedEvaluation!.score! / 10;
        currentValue=firstNumber.toInt();

        double secondNumber=_getSelectedEvaluation!.score! % 10;
        currentValueTwo=secondNumber.toInt();



      }

    }

    var friday=5;

    DateTime todayEvaluation = DateTime.now();
    currentDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(todayEvaluation);
    while(now.weekday!=friday)
    {
      now=now.subtract(new Duration(days: 1));

      formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(now);

    }

    print('Recent monday $formattedDate');

    print('Recent monday $currentDate');


    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
    evaluationGoodAreasController.dispose();
    improvementAreaController.dispose();
  }


  updateEvaluationData() async {
    String? userID = await _prefs.getUserId();
    try {
      isLoading = true;
      _addWishListData = await _auth.editEvaluationsData(
        evaluationId: _evaluationId ?? "",
        evaluatedUserId: userID,
        evaluationsFeedback: feedbackController.text,
        evaluationStatus: "submitted",
        evaluationPoint: currentValue*10 + currentValueTwo,
        evaluationGoodAreas: evaluationGoodAreasController.text,
        evaluationImprovementAreas: improvementAreaController.text,
        evaluationDate: currentDate,
        evaluationDueDate: formattedDate,
      );

      if (_addWishListData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        EvolutionsController controller = Get.find<EvolutionsController>();
        controller.getEvaluationsList(userID);


        Get.back();

        ApplicationUtils.showSnackBar(titleText: _addWishListData?.statusCode, messageText: _addWishListData?.msg);
        debugPrint("catch Error ${_addWishListData?.status}");


      } else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();

  }

  deleteWish() async {
    Get.back();
    String userID= await _prefs.getUserId();
    try {
      isLoading = true;
      _addWishListData = await _auth.deleteUserEvaluationData(
        evaluationId: _evaluationId,
      );

      if (_addWishListData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        EvolutionsController controller = Get.find<EvolutionsController>();
        controller.getEvaluationsList(userID);

        Get.back();



      } else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();

  }

}
