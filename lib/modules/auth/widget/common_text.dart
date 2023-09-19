import 'package:flutter/cupertino.dart';

class CustomizedTextWidget extends StatelessWidget {
  const CustomizedTextWidget({
    Key? key,
    required this.color,
    required this.fontSize,
    required this.textValue,
     this.fontWeight
  }) : super(key: key);
  final Color color;
  final double fontSize;
  final String textValue;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(color: color,fontWeight:fontWeight,fontFamily: '', fontSize: fontSize).copyWith(color: color),
    );
  }
}