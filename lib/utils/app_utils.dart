import 'package:flutter/material.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:get/get.dart';

class ApplicationUtils {
  static showSnackBar(
      {required String? titleText, required String? messageText}) {
    return Get.snackbar('', '',
        messageText: Text(
          messageText!,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        titleText: Text(
          titleText!,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: kPrimaryColor?.withOpacity(0.3),
        borderRadius: 8,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.white,
        padding: const EdgeInsets.all(12));
  }
}
