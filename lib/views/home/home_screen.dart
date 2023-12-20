import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/helper/route_constant.dart';
import 'package:mile_prix/provider/home_provider.dart';
import 'package:mile_prix/views/home/map_view_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../helper/app_colors.dart';
import 'list_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (ctx, provider, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (v) {
          provider.onPop(context);
        },
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(AppImages.logo, scale: 6),
                            IconButton(
                                onPressed: () {
                                  GoRouter.of(context)
                                      .pushNamed(RouteConstant.settingScreen);
                                },
                                icon: Icon(Icons.settings))
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.borderGreyColor, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                            splashBorderRadius: BorderRadius.circular(10),
                            onTap: (index) {
                              provider.changeIndex(index);
                              provider.tapOnTabBar(index, context);
                            },
                            dividerHeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor),
                            tabs: const [
                              Tab(
                                text: "All",
                              ),
                              Tab(
                                text: "Pickup",
                              ),
                              Tab(
                                text: "Drop Off",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PersistentTabView(
                      context,
                      navBarStyle: NavBarStyle.style3,
                      confineInSafeArea: true,
                      screens: const [
                        MapViewScreen(),
                        ListViewScreen(),
                      ],
                      items: [
                        PersistentBottomNavBarItem(
                          icon: Image.asset(AppImages.activeMap, scale: 4),
                          inactiveIcon: Image.asset(AppImages.map, scale: 4),
                          title: "Map View",
                          activeColorPrimary: AppColors.primaryColor,
                          inactiveColorPrimary: Colors.grey,
                        ),
                        PersistentBottomNavBarItem(
                          icon: Image.asset(AppImages.activeList, scale: 4),
                          inactiveIcon: Image.asset(AppImages.list, scale: 4),
                          title: "List View",
                          activeColorPrimary: AppColors.primaryColor,
                          inactiveColorPrimary: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
