import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';

import '../helper/app_colors.dart';
import '../helper/route_constant.dart';
import '../model/order_model.dart';
import 'app_button.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final bool isFromMap;
  const OrderTile({super.key, required this.order, required this.isFromMap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chips
              Row(
                children: [
                  CustomChip(
                    label: order.orderType.name,
                    bgColor: order.orderType == OrderType.Pickup
                        ? AppColors.primaryColor
                        : Colors.green,
                  ),
                  SizedBox(width: 10.w),
                  CustomChip(
                    label: 'ETA 20 Mins',
                    bgColor: AppColors.blueColor,
                  )
                ],
              ),

              // Order Id
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text("ORDER ID #${order.id}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              ),
              CustomTile(leading: AppImages.location, title: order.location),
              CustomTile(leading: AppImages.person, title: order.name),
              CustomTile(
                  leading: AppImages.size,
                  title:
                      "L: ${order.size[0]} CM    W: ${order.size[1]} CM    H: ${order.size[2]} CM"),
              CustomTile(leading: AppImages.weight, title: "${order.weight} KG"),

              if (isFromMap)
                order.orderType == OrderType.DropOff
                    ? Center(
                        child: AppButton(
                          height: 50.h,
                          width: screenWidth * .8,
                          text: "DROP OFF ORDER",
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                RouteConstant.cameraScreen,
                                extra: [false,true]);
                            Navigator.pop(context);
                          },
                          isAuth: false,
                          color: Colors.green,
                        ),
                      )
                    : Center(
                        child: AppButton(
                            height: 50.h,
                            width: screenWidth * .8,
                            text: "PICKUP ORDER",
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  RouteConstant.cameraScreen,
                                  extra: [true,true]);
                              Navigator.pop(context);
                            },
                            isAuth: false),
                      )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String leading;
  final String title;
  const CustomTile({super.key, required this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(leading,scale: 4),
          SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 16.sp))
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color bgColor;
  const CustomChip({super.key, required this.label, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(label),
        labelPadding: EdgeInsets.symmetric(horizontal: 15.w),
        labelStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.sp),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: bgColor);
  }
}
