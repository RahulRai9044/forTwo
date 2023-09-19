
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:for_two/modules/auth/controller/register_controller.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/auth/widget/registration_top_gradient.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/app_utils.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';

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
                child: Column(
                  children: [
                    RegistrationTopGradient(),
                    SizedBox(height: size.height * 0.04),

                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            InputTextField(
                                textColors: kTextColor,
                                text: 'Full Name',
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
                                textColors: kTextColor,
                                text: 'Email',
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
                              textColors: kTextColor,
                              text: "Phone Number",
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
                                        textColors: kTextColor,
                                        text: "Country",
                                        controller:
                                            controller.passwordController,
                                        inputType: TextInputType.text,
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
                                        textColors: kTextColor,
                                        text: "City",
                                        controller: controller
                                            .confirmPasswordController,
                                        inputType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required*';
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

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      InputTextField(
                                        textColors: kTextColor,
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
                                        textColors: kTextColor,
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

                            const SizedBox(height: 20),
                            CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: 'Gender'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: controller.id,
                                      onChanged: (val) {

                                        controller.radioButtonItem = 'female';
                                          controller.id = 1;
                                        controller.update();
                                      },
                                    ),

                                    CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: 'Female'),

                                  ],
                                ),


                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: controller.id,
                                      onChanged: (val) {
                                          controller.radioButtonItem = 'male';
                                          controller.id = 2;
                                          controller.update();
                                      },
                                    ),

                                    CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: 'Male'),
                                  ],
                                ),


                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: controller.id,
                                      onChanged: (val) {

                                          controller.radioButtonItem = 'other';
                                          controller.id = 3;
                                          controller.update();

                                      },
                                    ),
                                    CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: 'Other'),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: controller.id,
                                      onChanged: (val) {

                                        controller.radioButtonItem = 'pnots';
                                        controller.id = 3;
                                        controller.update();

                                      },

                                    ),

                                    CustomizedTextWidget(color: kTextColor ?? Colors.grey.shade700, fontSize: 18, textValue: 'Prefer not to say'),
                                  ],
                                ),


                              ],
                            ),


                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.1),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 1.0,
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
              );
            }),
      ),
    );
  }
}
