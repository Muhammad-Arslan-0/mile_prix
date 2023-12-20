import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mile_prix/helper/app_colors.dart';
import 'package:mile_prix/helper/app_images.dart';

class CustomSwitchButton extends StatelessWidget {
  final bool isTrue;
  final bool isYes;
  final Function() onTap;
  const CustomSwitchButton(
      {super.key,
      required this.isTrue,
      required this.onTap,
      required this.isYes});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * .4,
        height: 50.h,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isTrue ? AppColors.primaryColor : Colors.grey,
                width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isYes ? "Yes" : "No",
              style: TextStyle(color: isTrue ? AppColors.primaryColor : null),
            ),
            isTrue
                ? Image.asset(isYes ? AppImages.success : AppImages.cancel,
                    scale: 3)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
