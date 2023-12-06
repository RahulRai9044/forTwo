import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_two/intl/intl_keys.dart';
import 'package:for_two/modules/auth/widget/common_elevated_button.dart';
import 'package:for_two/modules/auth/widget/common_text.dart';
import 'package:for_two/modules/auth/widget/input_textfield.dart';
import 'package:for_two/modules/dashboard/controller/connect_partner_controller.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class ConnectPartnerScreen extends StatelessWidget {
  const ConnectPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
           resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:  Icon(Icons.arrow_back_ios, color: kTextColor),
              onPressed: () => Get.back(),
            ),
          ),
          body: GetBuilder<ConnectPartnerController>(
              init: ConnectPartnerController(),
              builder: (controller) {
                return controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomizedTextWidget(color: buttonFirstColor, fontSize: 25, textValue: "Connect with your Partner"),

                            const SizedBox(height: 20),

                            InputTextField(
                              textColors: kTextColor,
                              text: 'Partner Name',
                              controller: controller.partnerNameController,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return IntlKeys.required.tr;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue: 'Please enter your partner email. Your partner will receive an OTP to connect.'),

                            InputTextField(
                                controller: controller.partnerEmailController,
                                textColors: kTextColor,
                                onChange: (newValue) {
                                  controller.checkEnteredEmail(controller.partnerEmailController.text);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Required*';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return "Please enter a correct email address";
                                  }
                                  return null;
                                },
                                text: ''),
                            const SizedBox(height: 20),

                            Visibility(
                              visible: !controller.isOtpVisible,
                              child: Opacity(
                                opacity: controller.current_opacity,
                                child: CommonElevatedButton(
                                  height: size.height * 0.05,
                                  width: size.width * 1.0,
                                  title: IntlKeys.send_code.tr,
                                  onTap: () async {
                                    var isValid =
                                    controller.formKey.currentState!.validate();
                                    if (isValid) {


                                      await controller.partnerConnectSendOtp();



                                    }
                                  },
                                ),
                              ),
                            ),

                            Visibility(
                              visible: controller.isOtpVisible,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomizedTextWidget(color: kTextColor, fontSize: 15, textValue: "A 6 digit verification Code has sent on your partner email .",fontWeight: FontWeight.normal,textAlignment: TextAlign.start,),


                                  const SizedBox(height: 20),

                                  PinCodeTextField(
                                    appContext: context,
                                    length: 6,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ], // Only numbers can be entered
                                    obscureText: false,
                                    obscuringCharacter: '*',
                                    animationType: AnimationType.fade,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 50,
                                      activeFillColor: Colors.white,
                                    ),
                                    animationDuration:
                                    const Duration(milliseconds: 300),
                                    backgroundColor: Colors.white,
                                    enableActiveFill: false,
                                    errorAnimationController:
                                    controller.errorController,
                                    controller: controller.otpController,
                                    onCompleted: (value) async {
                                      controller.otpController.text = value;
                                      //  await controller.verifyOtp();
                                    },
                                    onChanged: (value) async {},
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  CommonElevatedButton(
                                    height: size.height * 0.05,
                                    width: size.width * 1.0,
                                    title: "verify Otp",
                                    onTap: () async {
                                      var isValid =
                                      controller.formKey.currentState!.validate();
                                      if (isValid) {

                                        await controller.verifyOtpRegisterPartner();



                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),




                            const SizedBox(height: 30),





                          ],
                        ),
                      ),
                    );
              }),
        ));
  }
}
