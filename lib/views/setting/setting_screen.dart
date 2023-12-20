import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_colors.dart';
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/helper/route_constant.dart';
import 'package:mile_prix/widget/app_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitchOn = true;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: Text(
                  "Working Availability",
                  style: TextStyle(fontSize: 16.sp),
                ),
                trailing: Switch(
                  value: isSwitchOn,
                  onChanged: (v) {
                    setState(() {
                      isSwitchOn = v;
                    });
                  },
                  inactiveTrackColor: Colors.white,
                  activeTrackColor: AppColors.primaryColor,
                  inactiveThumbColor: AppColors.primaryColor,
                  trackOutlineColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        backgroundColor: Colors.white,
                        showDragHandle: true,
                        enableDrag: false,
                        dragHandleSize: Size(50, 4),
                        constraints: BoxConstraints.loose(
                            Size.fromHeight(screenHeight * .3)),
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.logout, scale: 4),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                              Text(
                                "Are you sure you want to logout now?",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AppButton(
                                    height: 50.h,
                                    width: screenWidth * .45,
                                    text: "Cancel",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    isAuth: false,
                                    isOutline: true,
                                    textColor: Colors.black,
                                    color: Colors.white,
                                  ),
                                  AppButton(
                                    height: 50.h,
                                    width: screenWidth * .45,
                                    text: "Confirm",
                                    onPressed: () {
                                      GoRouter.of(context)
                                          .goNamed(RouteConstant.loginScreen);
                                    },
                                    isAuth: false,
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        onClosing: () {},
                      );
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.logoutGrey,
                          height: 30, width: 30, fit: BoxFit.cover),
                      SizedBox(width: 10.w),
                      Text("Log out", style: TextStyle(fontSize: 16.sp))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
