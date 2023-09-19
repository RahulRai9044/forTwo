import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  const EmailFormField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black, // Only numbers can be entered
      style: TextStyle(color: Colors.black.withOpacity(0.8)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email can not be empty';
        } else if (!GetUtils.isEmail(value)) {
          return "Please enter a correct email address";
        }
        return null;
      },
      decoration: const InputDecoration(
        filled: false,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ),
      ),
    );
  }
}
