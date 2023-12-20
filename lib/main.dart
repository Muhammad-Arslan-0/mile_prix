import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mile_prix/helper/app_colors.dart';
import 'package:mile_prix/provider/auth_provider.dart';
import 'package:mile_prix/provider/confirm_order_provider.dart';
import 'package:mile_prix/provider/home_provider.dart';
import 'package:mile_prix/provider/map_provider.dart';
import 'package:mile_prix/route/app_router.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await ScreenProtector.protectDataLeakageOn();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => MapProvider()),
          ChangeNotifierProvider(create: (_) => ConfirmOrderProvider()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'MilePrix',
                theme: ThemeData(scaffoldBackgroundColor: AppColors.bgColor),
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationProvider:
                    AppRouter.router.routeInformationProvider,
                routeInformationParser: AppRouter.router.routeInformationParser,
              );
            }),
      ),
    );
  }
}
