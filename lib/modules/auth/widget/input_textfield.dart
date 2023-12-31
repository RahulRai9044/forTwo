import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String text;
  final Color? textColors;
  final IconData? icon;
  final TextInputType? inputType;
  final bool isVisible;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final Function()? onPressed;
  final Function(String)? onChange;

  const InputTextField({
    super.key,
    this.hintText,
    required this.controller,
    required this.validator,
    required this.text,
    required this.textColors,
    this.inputType,
    this.icon,
    this.isVisible = false,
    this.onTap,
    this.onPressed,
    this.readOnly = false,
    this.onChange,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColors,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-Regular",
          ),
        ),
        Container(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            inputFormatters: inputFormatters,
            onTap: onPressed,
            onChanged: onChange,
            controller: controller,
            keyboardType: inputType,
            obscureText: isVisible,
            readOnly: readOnly,
            style: TextStyle(fontSize: 15.0),
            validator: validator,
            decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.symmetric(vertical: 5), // adjust as you need
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:Color(0xFFDBDBDB)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:Color(0xFFDBDBDB)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:Color(0xFFDBDBDB)),
                ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),

              suffixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  icon: Icon(icon),
                  onPressed: onTap,
                ),
              ),

            ),
          ),
        ),
      ],
    );
  }
}
