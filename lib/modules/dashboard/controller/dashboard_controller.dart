

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:for_two/modules/calanderPage/view/wish_event_tab_calander.dart';
import 'package:for_two/modules/dashboard/model/user_partner_data_model.dart';
import 'package:for_two/modules/dashboard/view/home_page.dart';
import 'package:for_two/modules/statistics/view/statistics_tab_view.dart';
import 'package:for_two/modules/wishlists/view/wish_lists.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/constants.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DashboardController extends GetxController{

  bool isLoading=false;
  bool badgeStatus=true;
  var tabIndex = 0;
  final Prefrence _mPrefrence = Prefrence();
  final AuthService _auth = AuthService();

  bool connectPartnerButton=true;

  double percent = 50.0;

  String userName='';
   String partnerName='';

  Map<String, dynamic>? paymentIntent;

  UserPartnerModel? _userPartnerDetailsData;
  UserPartnerModel? get userWishlist => _userPartnerDetailsData;



  void changeTabIndex(int index) {
    tabIndex = index;
    if (index == 0) {
      Get.delete<DashboardController>();
      Get.put(DashboardController());
    } else if (index == 1) {
      Get.delete<DashboardController>();
      Get.put(DashboardController());
    } else if (index == 2) {
      // Get.delete<ContactController>();
      // Get.put(ContactController());
    } else {
      // Get.delete<AccountController>();
      // Get.put(AccountController());
    }
    update();
  }




  @override
  void onReady() {


  }

  @override
  Future<void> onInit() async {
    super.onInit();

    String userId= await _mPrefrence.getUserId();
    String partnerId= await _mPrefrence.getPartnerId();
    if(userId.isNotEmpty){

      userAndPartnerDataModel(userId);


    }


  }


  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'INR');


      print(paymentIntent!.entries);

      var gpay =  PaymentSheetGooglePay(merchantCountryCode: "GB",
          currencyCode: "GBP",
          testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'ForTwoSouls',allowsDelayedPaymentMethods: true,googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }


/*  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }*/

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {

        //Clear paymentIntent variable after successful payment
        paymentIntent = null;

      })
          .onError((error, stackTrace) {
        throw Exception(error);
      });
    }
    on StripeException catch (e) {
      print('Error is:---> $e');
    }
    catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('/payment-sheet');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'a': 'a',
      }),
    );
    final body = json.decode(response.body);
    if (body['error'] != null) {
      throw Exception(body['error']);
    }
    return body;
  }


  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await _createTestPaymentSheet();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          style: ThemeMode.dark,
        ),
      );
      // setState(() {
      //   _ready = true;
      // });
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      rethrow;
    }
  }


  userAndPartnerDataModel(String userDetail)  async {
    isLoading = true;
    _userPartnerDetailsData = await _auth.getUserAndPartnerData(userID: userDetail);
    if (_userPartnerDetailsData?.status == AppConstants.StatusSuccess) {
      isLoading = false;
      print("Rahul");

      print(_userPartnerDetailsData!.status);
      print(_userPartnerDetailsData!.result?.user?.firstName ?? "");


      if(_userPartnerDetailsData!.result?.partner != null){

        await Prefrence.setPartnerUserID(_userPartnerDetailsData!.result?.partner?.id);

        print(_mPrefrence.getPartnerId());


        print(_userPartnerDetailsData!.result?.partner?.firstName ?? "");

        userName=_userPartnerDetailsData!.result?.user?.firstName ?? "";

        partnerName=_userPartnerDetailsData!.result?.partner?.firstName ?? '';


        connectPartnerButton=false;

      }



    } else {

      isLoading = false;
    }

    isLoading = false;
    update();

  }


  Widget getPage(int index) {
    switch (index) {
      case 0:
        return  HomePage();
      case 1:
        return  WishListScreen();
      case 2:
        return  CalanderWishEventTab();
      default:
        return  StatisticTabView();
    }
  }



  Path buildHeartPath() {
    Path path = Path();
     double width = size.width/2;
    double height = size.height/4.5;
    // Starting point
    path.moveTo(width / 2, height / 5);

    // Upper left path
    path.cubicTo(5 * width / 14, 0, 0, height / 15, width / 28, 2 * height / 5);

    // Lower left path
    path.cubicTo(width / 14, 2 * height / 3, 3 * width / 7, 5 * height / 5, width / 2, height);

    // Lower right path
    path.cubicTo(4 * width / 7, 5 * height / 5, 13 * width / 14, 2 * height / 3, 27 * width / 28, 2 * height / 5);

    // Upper right path
    path.cubicTo(width, height / 15, 9 * width / 14, 0, width / 2, height / 5);


    return path;
  }

}