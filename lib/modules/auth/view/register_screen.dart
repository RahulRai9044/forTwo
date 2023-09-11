
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/controller/register_controller.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<RegisterController>(
            init: RegisterController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: size.height * 0.04),

                      Image.asset(
                        "assets/images/app_icon.png",
                        height: size.height * 0.15,
                        width: size.width * 0.4,
                      ),

                      SizedBox(height: size.height * 0.02),

                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Register Me !!",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   "Please fill all the required details to get register into the App",
                      //   style: Theme.of(context).textTheme.bodyText2,
                      // ),
                      const SizedBox(height: 20.0),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            InputTextField(
                                textColors: kBlackColor,
                                text: 'Name*',
                                controller: controller.userNameController,
                                inputType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required*';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),


                            InputTextField(
                                textColors: kBlackColor,
                                text: 'Phone Number *',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                controller: controller.userPhoneNumberController,
                                inputType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required*';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),


                            InputTextField(
                              textColors: kBlackColor,
                              text: "Email*",
                              controller: controller.emailController,
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required*';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Enter correct email address';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InputTextField(
                                        textColors: kBlackColor,
                                        text: "Password*",
                                        controller:
                                            controller.passwordController,
                                        inputType: TextInputType.text,
                                        isVisible: controller.isObsecure,
                                        icon: controller.isObsecure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        onTap: controller.showPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required*';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InputTextField(
                                        textColors: kBlackColor,
                                        text: "Confirm Password*",
                                        controller: controller
                                            .confirmPasswordController,
                                        inputType: TextInputType.text,
                                        isVisible: controller.isObsecureCNF,
                                        icon: controller.isObsecureCNF
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        onTap: controller.showPasswordCNF,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required*';
                                          } else if (value !=
                                              controller
                                                  .passwordController.text) {
                                            return "Password did not match.Try Again";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: kPrimaryColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: BorderSide(color: kPrimaryColor!, width: 2),
                              checkColor: Colors.white,
                              value: controller.isChecked,
                              onChanged: controller.toggleCheckBox,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "I agree to terms and conditions and",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontSize: 12,
                                            color: kBlackColor?.withOpacity(0.8)),
                                    children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {

                                          launchUrl(Uri.parse('https://app.houstonepilepsy.com/privacy-policy'), mode: LaunchMode.platformDefault);

                                        },
                                      text: "Privacy Policy",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontSize: 14,
                                              color: kPrimaryColor))
                                ]))
                          ],
                        ),
                      ),


                      SizedBox(height: size.height * 0.1),


                      CommonElevatedButton(
                        title: 'Register',
                        onTap: controller.isChecked == true
                            ? () {
                                ApplicationUtils.showSnackBar(
                                    titleText: 'Error',
                                    messageText:
                                        'Please accept our terms and Privacy Policy to continue.');
                              }
                            : () async {
                                if (controller.formKey.currentState!.validate()) {

                                  if(controller.passwordController.text == controller.confirmPasswordController.text){

                                    EasyLoading.show(status: 'Registration started..');
                                    await controller.registerUsingEmailPassword(name:controller.userNameController.text,email: controller.emailController.text,password: controller.passwordController.text,userPhoneNumber: controller.userPhoneNumberController.text);
                                    EasyLoading.dismiss();

                                  }else{



                                    ApplicationUtils.showSnackBar(
                                        titleText: "Failed", messageText: 'Please enter correct password');

                                  }


                                }
                              },
                      ),
                      const SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: kBlackColor),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.off(() => const LoginScreen());
                                    },
                                  text: " Sign In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 15, color: kPrimaryColor))
                            ]),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
