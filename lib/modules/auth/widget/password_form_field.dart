import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObsecure;
  final Function() onTap;
  const PasswordFormField({
    super.key,
    required this.controller,
    required this.isObsecure,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecure,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black, // Only numbers can be entered
      style: TextStyle(color: Colors.black.withOpacity(0.8),),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password can not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: false,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5), // adjust as you need
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ),
        errorBorder:UnderlineInputBorder(
          borderSide: BorderSide(color:Color(0xFFDBDBDB)),
        ) ,
        suffixIconConstraints: BoxConstraints(
          minWidth: 2,
          minHeight: 2,
        ),
        suffix: Padding(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            icon: Icon(
              isObsecure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
