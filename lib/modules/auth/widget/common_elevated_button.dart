
import 'package:flutter/material.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:for_two/utils/size.dart';

class CommonElevatedButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CommonElevatedButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        fixedSize: Size(size.width, 50),
        textStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: kWhiteColor,
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
      ),
    );
  }
}
