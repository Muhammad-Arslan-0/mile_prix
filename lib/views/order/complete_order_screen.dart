import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';

import '../../helper/route_constant.dart';
import '../../widget/app_button.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.success),
                Text(
                  "Order Completed",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Order successfully completed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.sp),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: screenWidth * .05,
            right: screenWidth * .05,
            child: AppButton(
                height: 50.h,
                width: screenWidth * .9,
                text: "CONTINUE",
                onPressed: () {
                  GoRouter.of(context).goNamed(RouteConstant.homeScreen);
                }),
          )
        ],
      ),
    );
  }
}
