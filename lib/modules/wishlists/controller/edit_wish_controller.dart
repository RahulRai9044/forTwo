
import 'package:flutter/material.dart';
import 'package:for_two/modules/wishlists/controller/wish_list_controller.dart';
import 'package:for_two/modules/wishlists/model/my_wishlist_data.dart';
import 'package:for_two/modules/wishlists/model/wish_list_add.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditWishListController extends GetxController  {
  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();

  late TextEditingController wishTitleController;
  late TextEditingController addWishDateController;
  late TextEditingController wishDescriptionController;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  late GlobalKey<FormState> addNewMeetingFormKey;

  AddWishListData? _addWishListData;
  AddWishListData? get addWishList => _addWishListData;

  bool isLoading = false;

  int selectedCard=-1;
  late String _selectedPointIndexData;

   late String _wishId;

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
    final f = new DateFormat('MM/dd/yyyy');
    addWishDateController.text = f.format(selectedDate);
    update();
  }




  List pointsListData = [
    {
      "points": "100",
    },
    {
      "points": "150",
    },
    {
      "points": "200",
    },
    {
      "points": "250",
    },
    {
      "points": "300",
    },
  ];



  @override
  void onInit() {
    super.onInit();

    wishTitleController = TextEditingController();

    addWishDateController = TextEditingController();
    wishDescriptionController = TextEditingController();

    addNewMeetingFormKey = GlobalKey<FormState>();

    var data = Get.arguments;

    Datum datum=data;

    if(datum.id.isNotEmpty){

      wishTitleController.text=datum.title;
      addWishDateController.text=datum.fulfillDate.toString();
      wishDescriptionController.text=datum.description;
      _wishId=datum.id;
      int index = pointsListData.indexWhere((item) => item.containsValue(datum.points.toString()));

      selectPoints(index);

    }


    print(datum.title);
    print("Rahul");
  }

  @override
  void dispose() {
    super.dispose();

    wishTitleController.dispose();
    addWishDateController.dispose();
    wishDescriptionController.dispose();

  }

  updateWishListDetails() async {

    String userID= await _prefs.getUserId();
    String partnerID= await _prefs.getPartnerId();
    try {
      isLoading = true;
      _addWishListData = await _auth.updateUserWishDetails(
        wishId: _wishId,
        wishTitle: wishTitleController.text,
        wishListDescription: wishDescriptionController.text,
        wishStatus: "fulfilled",
      );

      if (_addWishListData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        WishListController controller = Get.find<WishListController>();
        controller.viewAllWishListData(userID);
        controller.viewPartnerWishListData(userID);

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



  void selectPoints(int indx) {

    selectedCard=indx;
    _selectedPointIndexData=pointsListData[indx]['points'];
    print(_selectedPointIndexData);

    update();

  }

    updateWish() async {
      Get.back();
      String userID= await _prefs.getUserId();
      String partnerID= await _prefs.getPartnerId();
      try {
        isLoading = true;
        _addWishListData = await _auth.updatePartnerWishData(
          wishId: _wishId, fullfillUserId: userID,
        );

        if (_addWishListData?.status == AppConstants.StatusSuccess) {
          isLoading = false;

          WishListController controller = Get.find<WishListController>();
        //  controller.viewAllWishListData(userID);
          controller.viewPartnerWishListData(userID);

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
    String partnerID= await _prefs.getPartnerId();
    try {
      isLoading = true;
      _addWishListData = await _auth.deleteUserWishData(
        wishId: _wishId,
      );

      if (_addWishListData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        WishListController controller = Get.find<WishListController>();
        controller.viewAllWishListData(userID);
        controller.viewPartnerWishListData(userID);

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

}
