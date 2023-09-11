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
      style: TextStyle(color: Colors.black.withOpacity(0.8)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password can not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE2F5F6),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObsecure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
