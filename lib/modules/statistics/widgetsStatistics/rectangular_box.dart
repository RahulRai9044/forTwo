
import 'package:flutter/material.dart';

class CommonRectangularBox extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  const CommonRectangularBox({
    Key? key,
    this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
     height: 30,
        width: 50,
        decoration: BoxDecoration(
           gradient: const LinearGradient(colors: [Color(0xFFF575AA),Color(0xFFEF3B85)]),
            borderRadius: BorderRadius.all(Radius.circular(2))
        ),
    );
  }
}