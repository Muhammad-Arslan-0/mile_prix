import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:mile_prix/views/auth/login_success_screen.dart';
import 'package:mile_prix/views/camera/camera_view.dart';
import 'package:mile_prix/views/home/home_screen.dart';
import 'package:mile_prix/views/order/complete_order_screen.dart';
import 'package:mile_prix/views/order/confirm_dropoff_order.dart';
import 'package:mile_prix/views/order/confirm_pickup_order.dart';
import 'package:mile_prix/views/order/image_view_screen.dart';
import 'package:mile_prix/views/setting/setting_screen.dart';
import '../helper/route_constant.dart';
import '../views/auth/login_screen.dart';
import '../views/splash_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
        path: "/",
        name: RouteConstant.splashScreen,
        builder: (context, state) {
          return SplashScreen();
        }),
    GoRoute(
        path: "/login",
        name: RouteConstant.loginScreen,
        builder: (context, state) {
          return LoginScreen();
        }),
    GoRoute(
        path: "/successLogin",
        name: RouteConstant.successLoginScreen,
        builder: (context, state) {
          return LoginSuccessScreen();
        }),
    GoRoute(
        path: "/home",
        name: RouteConstant.homeScreen,
        builder: (context, state) {
          return HomeScreen();
        }),
    GoRoute(
        path: "/setting",
        name: RouteConstant.settingScreen,
        builder: (context, state) {
          return SettingScreen();
        }),
    GoRoute(
        path: "/camera",
        name: RouteConstant.cameraScreen,
        builder: (context, state) {
          final data = state.extra as List<bool>;
          bool isPickup = data[0];
          bool isFromMap = data[1];
          return CameraView(isPickup: isPickup, isFromMap: isFromMap);
        }),
    GoRoute(
        path: "/confirmPick",
        name: RouteConstant.confirmPickUpOrder,
        builder: (context, state) {
          return ConfirmPickUpOrder();
        }),
    GoRoute(
        path: "/confirmDrop",
        name: RouteConstant.confirmDropOffOrder,
        builder: (context, state) {
          return ConfirmDropOffOrder();
        }),
    GoRoute(
        path: "/completeOrder",
        name: RouteConstant.completeOrderScreen,
        builder: (context, state) {
          return OrderCompleteScreen();
        }),
    GoRoute(
        path: "/imageView",
        name: RouteConstant.imageViewScreen,
        builder: (context, state) {
          return ImageViewScreen(image: state.extra as File);
        }),
  ]);
}
