import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../helper/app_colors.dart';
import '../../helper/app_images.dart';
import '../../helper/route_constant.dart';
import '../../provider/confirm_order_provider.dart';
import '../../widget/app_button.dart';
import '../../widget/custom_switch_button.dart';

class ConfirmDropOffOrder extends StatelessWidget {
  const ConfirmDropOffOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: Icon(Icons.navigate_before)),
        title: Text("Back"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Consumer<ConfirmOrderProvider>(
              builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RouteConstant.cameraScreen,
                            extra: [false, false]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: AppColors.primaryColor,
                          radius: Radius.circular(12),
                          strokeWidth: 2,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.file_upload_outlined,
                                    color: AppColors.primaryColor),
                                Text(
                                  "UPLOAD\nPHOTOS",
                                  style:
                                      TextStyle(color: AppColors.primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ...provider.dropOffOrdersImages
                        .map((image) => Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).pushNamed(
                                          RouteConstant.imageViewScreen,
                                          extra: image);
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )),
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        provider.removeImageFromList(
                                            false, image);
                                      },
                                      child: Image.asset(
                                        AppImages.cancel,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                              ],
                            ))
                        .toList(),
                  ]),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Is the package intact?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSwitchButton(
                              isYes: true,
                            isTrue: provider.isPackageIntact,
                              onTap: () {
                                if (!provider.isPackageIntact) {
                                  provider.changePackageIntact(true);
                                }
                              }),
                          CustomSwitchButton(
                              isYes: false,
                              isTrue: !provider.isPackageIntact,
                              onTap: () {
                                if (provider.isPackageIntact) {
                                  provider.changePackageIntact(false);
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Does is fit the description?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSwitchButton(
                              isYes: true,
                              isTrue: provider.isFitDesc,
                              onTap: () {
                                if (!provider.isFitDesc) {
                                  provider.changeFitDesc(true);
                                }
                              }),
                          CustomSwitchButton(
                              isYes: false,
                              isTrue: !provider.isFitDesc,
                              onTap: () {
                                if (provider.isFitDesc) {
                                  provider.changeFitDesc(false);
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Your Comments",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Comments"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                AppButton(
                    height: 50.h,
                    width: screenWidth,
                    text: "SUBMIT",
                    isAuth: false,
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(RouteConstant.completeOrderScreen);
                      Provider.of<ConfirmOrderProvider>(context, listen: false)
                          .clearAllImages(false);
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
