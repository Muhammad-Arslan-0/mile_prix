import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/helper/route_constant.dart';
import '../../widget/app_button.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

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
                Image.asset(AppImages.success,scale: 4),
                Text(
                  "Login Successful",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "You are successfully logged in to your account.",
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
