
import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Gradient gradient;

  const CommonElevatedButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.borderRadius,
    this.width,
    this.height,
    this.gradient = const LinearGradient(colors: [Color(0xFFF01828),Color(0xFFEF3B85)]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(20);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(title,style: TextStyle(fontSize: 20),),
      ),
    );
  }
}