
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/controller/login_controller.dart';
import 'package:for_two/modules/auth/google_sign_in/google_sign_in.dart';
import 'package:for_two/modules/auth/view/facebook_login.dart';
import 'package:for_two/modules/auth/view/forgot_password_view.dart';
import 'package:for_two/modules/auth/view/register_screen.dart';
import 'package:for_two/modules/auth/widget/email_form_field.dart';
import 'package:for_two/modules/auth/widget/password_form_field.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import '../widget/common_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Image.asset(
                      "assets/images/app_icon.png",
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                    ),
                    SizedBox(height: size.height * 0.06),
                    Form(
                      key: controller.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email*",
                          ),
                          const SizedBox(height: 10),
                          EmailFormField(
                            controller: controller.emailController,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Password*",
                          ),
                          const SizedBox(height: 10),
                          PasswordFormField(
                            controller: controller.passwordController,
                            isObsecure: controller.isObsecure,
                            onTap: controller.showPassword,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgotPasswordView());
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    CommonElevatedButton(
                      title: 'Sign In',
                      onTap: () async {
                        if (controller.loginFormKey.currentState!.validate()) {
                          EasyLoading.show(status: 'Sign In');
                          await controller.signInUserWithEmailAndPassword(email: controller.emailController.text,password: controller.passwordController.text);
                          EasyLoading.dismiss();
                        }
                      },
                    ),
                     SizedBox(height: size.height * 0.05),
                     RichText(
                      text: TextSpan(
                          text: "Don’t have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: kBlackColor),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.off(() => const RegisterScreen());
                                  },
                                text: ' Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontSize: 15, color: kPrimaryColor))
                          ]),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/icons/google_icon_img.png",
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {

                            Get.offAll(() =>  GoogleLoginScreen());

                          },
                        ),
                        SizedBox(width: size.width * 0.03),
                        IconButton(
                          icon: Image.asset(
                            "assets/icons/facebook_icon.png",
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {

                          controller.loginFacebook();

                          },
                        ),

                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
