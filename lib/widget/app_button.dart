import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_colors.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final bool isAuth;
  final bool isOutline;
  final Color color;
  final Color textColor;
  final Function() onPressed;

  const AppButton(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.onPressed,
      this.color = AppColors.primaryColor,
      this.isAuth = true,
      this.textColor = Colors.white,
      this.isOutline = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                side:
                    isOutline ? BorderSide(color: Colors.grey, width: 2) : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isAuth ? 100 : 10))),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            )));
  }
}
