import 'package:for_two/modules/auth/controller/forgot_password_controller.dart';
import 'package:for_two/modules/auth/controller/reset_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}
