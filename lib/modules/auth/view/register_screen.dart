
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/intl/intl_keys.dart';
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

  Future<void> _selectDate(BuildContext context,RegisterController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: buttonFirstColor, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.blueAccent, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: buttonSecondColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: controller.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1920),
        lastDate: DateTime(2016));
    if (picked != null) controller.selectedDate = picked;
      controller.selectDate(controller.selectedDate);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<RegisterController>(

            init: RegisterController(),
            builder: (controller) {
              return controller.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xFFDF1721)),
                ),
              ): SingleChildScrollView(
                child: Column(
                  children: [
                    RegistrationTopGradient(),
                     SizedBox(height: size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Flexible(
                                  child: InputTextField(
                                    textColors: kTextColor,
                                    text: IntlKeys.user_first_name.tr,
                                    controller: controller.userFirstName,
                                    inputType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return IntlKeys.required.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: InputTextField(
                                    textColors: kTextColor,
                                    text: IntlKeys.user_last_name.tr,
                                    controller: controller
                                        .userLastName,
                                    inputType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return IntlKeys.required.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),


                            InputTextField(
                                textColors: kTextColor,
                                text: IntlKeys.email.tr,
                                controller: controller.emailController,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return IntlKeys.required.tr;
                                  }else if (!GetUtils.isEmail(value)) {
                                    return IntlKeys.correct_email.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),


                            InputTextField(
                              textColors: kTextColor,
                              text: IntlKeys.phone_number.tr,
                              controller: controller.userPhoneNumberController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return IntlKeys.required.tr;
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            InputTextField(
                                textColors: kTextColor,
                                text: IntlKeys.user_dob.tr,
                                controller: controller.userDateOfBirthController,
                                inputType: TextInputType.text,
                                icon: Icons.calendar_today,
                                onTap: (){
                                  _selectDate(context,controller);

                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return IntlKeys.required.tr;
                                  }
                                  return null;
                                }
                           ),

                            const SizedBox(height: 20),

                            Visibility(
                              visible: controller.passwordFieldVisibility,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        InputTextField(
                                          textColors: kTextColor,
                                          text: IntlKeys.password.tr,
                                          controller:
                                          controller.passwordController,
                                          inputType: TextInputType.text,
                                          isVisible: controller.isObsecure,
                                          icon: controller.isObsecure ? Icons.visibility_off : Icons.visibility,
                                          onTap: controller.showPassword,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return IntlKeys.required.tr;
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
                                          text: IntlKeys.cnf_password.tr,
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
                                              return IntlKeys.required.tr;
                                            } else if (value !=
                                                controller
                                                    .passwordController.text) {
                                              return IntlKeys.pass_not_match_try.tr;
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
                            ),

                            const SizedBox(height: 20),
                            CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue:IntlKeys.gender.tr),
                            const SizedBox(height: 10),
                            DropdownButton(
                                isExpanded: true,
                                hint: CustomizedTextWidget(color: kTextColor, fontSize: 18, textValue: "Select Gender"),
                                onChanged: (newValue) {
                                  controller.selectedDrowpdown=newValue.toString();
                                  controller.update();
                                },
                                value: controller.selectedDrowpdown,
                                items: [
                                  for (var data in controller.dropdownText)
                                    DropdownMenuItem(
                                      child: CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue: data),
                                      value: data,
                                    )
                                ]),


                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: CommonElevatedButton(
                        height: size.height * 0.05,
                        width: size.width * 1.0,
                        title: IntlKeys.register.tr,
                        onTap: controller.isChecked == true
                            ? () {
                                ApplicationUtils.showSnackBar(
                                    titleText: IntlKeys.error.tr,
                                    messageText:
                                    IntlKeys.accept_our_tc.tr);
                              }
                            : () async {
                                if (controller.formKey.currentState!.validate()) {

                                  if(controller.passwordController.text == controller.confirmPasswordController.text){

                                    await controller.registerNewUserData();


                                  }else{



                                    ApplicationUtils.showSnackBar(
                                        titleText: IntlKeys.failed.tr, messageText:IntlKeys.enter_correct_pass.tr);

                                  }


                                }
                              },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RichText(
                      text: TextSpan(
                          text: IntlKeys.already_account.tr,
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
                                text: IntlKeys.sign_in.tr,
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
