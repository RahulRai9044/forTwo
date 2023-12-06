

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/wishlists/model/my_wishlist_data.dart';
import 'package:for_two/modules/wishlists/view/add_new_wish.dart';
import 'package:for_two/modules/wishlists/view/my_wishlist.dart';
import 'package:for_two/modules/wishlists/model/wish_list_add.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';


class WishListController extends GetxController  with GetSingleTickerProviderStateMixin {
  bool isLoading = false;
  bool badgeStatus = true;
  var tabIndex = 0;
  final AuthService _auth = AuthService();

  final Prefrence mPrefrence = Prefrence();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TabController tabController;
  late ConfettiController topController;

   late WishListDataModel? _userWishListData;
  WishListDataModel? get userWishlist => _userWishListData;

  late WishListDataModel? _userPartnerWishListData;
  WishListDataModel? get userPartnerWishlist => _userPartnerWishListData;

  RxList userWishList = [].obs;
  RxList get record => userWishList;

  final List<Datum> partnerWishListData = [];
  List<Datum> get partnerData => partnerWishListData;

  AddWishListData? _addWishListData;
  AddWishListData? get addWishList => _addWishListData;





   viewAllWishListData(String userDetail)  async {
    isLoading = true;
    _userWishListData = await _auth.userWishListData(userId: userDetail);
    if (_userWishListData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");
      userWishList.clear();
      userWishList.assignAll(_userWishListData!.data);

    } else {

    }
    update();

  }

  shareOnFacebook() async {
    String? result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://play.google.com/store/apps/details?id=com.fundrivegames.mega.ramp.ultimate.cars.stunts.impossibletracks&hl=en-IN",
        quote: "captions");
    print("Rahul");
    print(result);
    print("Rahul");
  }

  updateWishCompleted(String _wishId) async {
    Get.back();
    String userID= await mPrefrence.getUserId();
    try {
      isLoading = true;
      _addWishListData = await _auth.updateFullfilledWishData(
        wishId: _wishId, userId: userID,
      );

      if (_addWishListData?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        WishListController controller = Get.find<WishListController>();
        controller.viewAllWishListData(userID);
        // controller.viewPartnerWishListData(userID);




        Get.back();

        ApplicationUtils.showSnackBar(titleText: _addWishListData?.statusCode, messageText: _addWishListData?.msg);
        debugPrint("catch Error ${_addWishListData?.status}");

        ApplicationUtils.shareFacebookConfirmationDialogue();
      } else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();

  }




  viewPartnerWishListData(String userDetail)  async {
    isLoading = true;
    _userPartnerWishListData = await _auth.userPartnerWishListData(userPartnerId: userDetail);
    if (_userPartnerWishListData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");
      partnerData.clear();
      partnerData.assignAll(_userPartnerWishListData!.data);

    } else {

    }
    update();

  }


  @override
  Future<void> onInit() async {

    tabController = TabController(vsync: this, length: 2);
    topController = ConfettiController(duration: const Duration(seconds: 10));
    topController.play();

    String? userID = await mPrefrence.getUserId();
    if(userID.isNotEmpty){

      viewAllWishListData(userID);
      viewPartnerWishListData(userID);


    }else{


    }


    super.onInit();
  }

  Future<void> addNewWish() async {

    int? userWishLimit = await mPrefrence.getUserWishLimit();
    print(userWishLimit);
    print("userWishList.length");
    print(userWishList.length);
     if(userWishLimit > userWishList.length){

       Get.to(() => const AddNewWish());

     }else{


       ApplicationUtils.showDialogueNoLimitWishAdd(titleText: "Not have enough wish !", messageText: "You don't have enough wish to add. Please ask your partner to check status fulfill of your wish");


     }


  }




}
