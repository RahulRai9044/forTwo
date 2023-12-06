import 'package:flutter/cupertino.dart';

class CustomizedTextWidget extends StatelessWidget {
  const CustomizedTextWidget({
    Key? key,
    required this.color,
    required this.fontSize,
    required this.textValue,
     this.fontWeight,
     this.textAlignment,
     this.overflow,
     this.fontFamily,
    this.maxline
  }) : super(key: key);
  final Color color;
  final double fontSize;
  final String textValue;
  final FontWeight? fontWeight;
  final TextAlign? textAlignment;
  final TextOverflow? overflow;
  final String? fontFamily;
  final int? maxline;

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(color: color,fontWeight:fontWeight,fontFamily:fontFamily, fontSize: fontSize).copyWith(color: color),
      textAlign: textAlignment,
      maxLines: maxline,
      overflow: overflow,
    );
  }
}