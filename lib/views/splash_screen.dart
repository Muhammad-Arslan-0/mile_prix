import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/helper/route_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      GoRouter.of(context).goNamed(RouteConstant.loginScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppImages.clouds),
            Image.asset(AppImages.logo, scale: 3),
            Image.asset(AppImages.truck),
          ],
        ),
      ),
    );
  }
}
