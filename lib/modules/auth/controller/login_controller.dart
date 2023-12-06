
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:for_two/modules/auth/model/error_model.dart';
import 'package:for_two/modules/auth/model/register.dart';
import 'package:for_two/modules/auth/model/send_otp.dart';
import 'package:for_two/modules/auth/view/otp_screen.dart';
import 'package:for_two/modules/auth/view/register_screen.dart';
import 'package:for_two/modules/dashboard/view/dashboard_screen.dart';
import 'package:for_two/prefrenceData/app_prefrence.dart';
import 'package:for_two/services/auth_service.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController with StateMixin {
  String _platformVersion = 'Unknown';
  final AuthService _auth = AuthService();
  final Prefrence _prefs = Prefrence();
  AuthUserModel? _registerUser;
  AuthUserModel? get register => _registerUser;
  SendOtpModel? _sendOtp;
  SendOtpModel? get sendotp => _sendOtp;

  ErrorModel? _checkUserVerification;
  ErrorModel? get userVarification => _checkUserVerification;

  bool isLoading = false;

  bool isObsecure = true;
  String? token;
  String? userData;
  String? userID;


  TextEditingController otpTextController=TextEditingController();


  late TextEditingController emailController, passwordController;
  late GlobalKey<FormState> loginFormKey;

  showPassword() {
    isObsecure = !isObsecure;
    update();
  }


  userLoginWithPasswordAndEmail() async {
  //  String fcmToken = await _prefs.getFCMToken();

    try {
      isLoading = true;
      _registerUser = await _auth.userLogin(
        userEmail: emailController.text,
        userPassword: passwordController.text,
        userRole: 'user', socialLoginId:"", userLoginType:"normal", socialType: "",
      );

      if (_registerUser?.status == AppConstants.StatusSuccess) {
        isLoading = false;
        token = _registerUser?.token;
        userID = _registerUser?.user.id;
        print(userID);
        await Prefrence.setUserID(userID);
        await Prefrence.setToken(token);
        await Prefrence.setUserEmail(_registerUser?.user.email);
        await Prefrence.setUserWishLimit(_registerUser!.user.wishes_plan_limit);
        await ApplicationUtils.showSnackBar(titleText: _registerUser?.statusCode, messageText: _registerUser?.msg);
        sendOtpForRegistration();
      } else if(_registerUser?.status == AppConstants.StatusFailed){

        ApplicationUtils.showSnackBar(titleText: _registerUser?.status, messageText: _registerUser?.msg);
         isLoading = false;

      }else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
       isLoading = false;
    }

    update();

  }

  userSocialLogin(String socialLoginId,String userLoginType,String socialType) async {
    //  String fcmToken = await _prefs.getFCMToken();
    try {
      isLoading = true;
      _registerUser = await _auth.userLogin(
        userEmail: emailController.text,
        userPassword: socialLoginId,
        userRole: 'user', socialLoginId: socialLoginId, userLoginType:userLoginType, socialType: socialType,
      );

      if (_registerUser?.status == AppConstants.StatusSuccess) {
        isLoading = false;
        token = _registerUser?.token;
        userID = _registerUser?.user.id;
        print(userID);
        await Prefrence.setUserID(userID);
        await Prefrence.setToken(token);
        await Prefrence.setUserEmail(_registerUser?.user.email);
        await Prefrence.setUserWishLimit(_registerUser!.user.wishes_plan_limit);
        await ApplicationUtils.showSnackBar(titleText: _registerUser?.statusCode, messageText: _registerUser?.msg);

        Get.offAll(() =>  DashboardScreen());


      } else if(_registerUser?.status == AppConstants.StatusFailed){

        ApplicationUtils.showSnackBar(titleText: _registerUser?.status, messageText: _registerUser?.msg);
        isLoading = false;

      }else{

        isLoading = false;

      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();

  }

  sendOtpForRegistration() async {
    try {
      isLoading = true;
      _sendOtp = await _auth.sendOtpForVerifyEmail(
        userEmail: emailController.text,
      );
      debugPrint("register ${_sendOtp?.msg}");
      debugPrint("register ${_sendOtp?.statusCode}");
      if (_sendOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        await ApplicationUtils.showSnackBar(titleText: _sendOtp?.status, messageText: _sendOtp?.msg);

        Get.offAll(() => const OTPScreen());

      } else {

        isLoading = false;
      }
    } catch (e) {

      debugPrint("catch Error ${e.toString()}");
      isLoading = false;
    }

    update();


  }



  verifyOtpAfterRegistration(String emailUser) async {
    try {
      isLoading = true;
      _sendOtp = await _auth.verifyOTPScreen(
        userEmail: emailUser,
        activationOtp: otpTextController.text,
      );
      debugPrint("register ${_sendOtp?.msg}");
      debugPrint("register ${_sendOtp?.statusCode}");
      if (_sendOtp?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        await ApplicationUtils.showSnackBar(
            titleText: _sendOtp?.status, messageText: _sendOtp?.msg);
        Get.offAll(() =>  DashboardScreen());
        isLoading = false;
      } else {
        ApplicationUtils.showSnackBar(
            titleText: _sendOtp?.status, messageText: _sendOtp?.msg);
        isLoading = false;
      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");

      isLoading = false;

    }
    update();

  }





  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();
    initPlatformState();


  // ifUserIsLoggedIn();

  }



  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterSocialContentShare.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.



      _platformVersion = platformVersion!;

      update();
  }


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    otpTextController.dispose();
  }


  bool _userLoginAutoValidate=false;

  TextEditingController _passwordController=TextEditingController();

  TextEditingController _userIdController =TextEditingController();

  bool _passwordVisible=false;


  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool value) {
    _passwordVisible = value;
   update();
  }

  TextEditingController get userIdController => _userIdController;

  set userIdController(TextEditingController value) {
    _userIdController = value;
    update();
  }

  TextEditingController get passwordControllers => _passwordController;

  set passwordControllers(TextEditingController value) {
    _passwordController = value;
    update();
  }

  bool get userLoginAutoValidate => _userLoginAutoValidate;
  set userLoginAutoValidate(bool value) {
    _userLoginAutoValidate = value;
    update();
  }




  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;
  bool? _checking = true;

  shareOnFacebook() async {
    String? result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://play.google.com/store/apps/details?id=com.fundrivegames.mega.ramp.ultimate.cars.stunts.impossibletracks&hl=en-IN",
        quote: "captions");
    print("Rahul");
    print(result);
    print("Rahul");
  }

  loginFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    print('Result: ${loginResult}');
    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      _userData = userInfo;
      print('ResultStatus: ${_userData}');
      print('Message: ${_userData!.values}');
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }


  ifUserIsLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

      _checking = false;

    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;

      print(_accessToken);
      print("rahulToken");
      _userData = userData;
      print(_userData);
      print("rahulData");

    } else {
      //loginFacebook();
    }
  }




  late User _user;
  final FirebaseAuth _authGoogle = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn =false;
  bool google =false;

  Future<String?> signInWithGoogle(LoginController model) async {
    //  model.state =ViewState.Busy;

    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =

    await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(

      accessToken: googleSignInAuthentication.accessToken,

      idToken: googleSignInAuthentication.idToken,

    );

    UserCredential authResult = await _authGoogle.signInWithCredential(credential);

    _user = authResult.user!;

    print(_user);
    print("Rahul");
    assert(!_user.isAnonymous);

    assert(await _user.getIdToken() != null);
    User currentUser = await _authGoogle.currentUser!;
    print(currentUser.toString());
    assert(_user.uid == currentUser.uid);

    if(_user.email!.isNotEmpty){
      checkUserExistance(_user);
    }

    //model.state =ViewState.Idle;

    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

    return _user.displayName;



  }

  checkUserExistance(User user) async {
    try {
      isLoading = true;
      _checkUserVerification = await _auth.checkUserExistance(
        userEmail: user.email ?? "",
      );
      if (_checkUserVerification?.status == AppConstants.StatusSuccess) {
        isLoading = false;

        emailController.text=user.email ?? "";

        userSocialLogin(user.uid ?? "","social","google");

        await ApplicationUtils.showSnackBar(
            titleText: _checkUserVerification?.status, messageText: _checkUserVerification?.msg);

        isLoading = false;
      } else {

        Get.offAll(() =>  RegisterScreen(),arguments: user);

        ApplicationUtils.showSnackBar(
            titleText: _checkUserVerification?.status, messageText: _checkUserVerification?.msg);
        isLoading = false;
      }
    } catch (e) {
      debugPrint("catch Error ${e.toString()}");

      isLoading = false;

    }
    update();

  }

}
