import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/route_constant.dart';
import 'package:mile_prix/main.dart';
import 'package:mile_prix/provider/confirm_order_provider.dart';
import 'package:mile_prix/widget/app_button.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  final bool isPickup;
  final bool isFromMap;
  const CameraView(
      {super.key, required this.isPickup, required this.isFromMap});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController controller;
  bool isCameraPause = false;
  File? imageFile;
  bool isFront = false;

  @override
  void initState() {
    super.initState();
    cameraInitialization(0);
  }

  cameraInitialization(int lensDirection) {
    controller =
        CameraController(cameras[lensDirection], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isFront = lensDirection == 0 ? false : true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: CameraPreview(controller)),
          isCameraPause
              ? Positioned(
                  bottom: 10.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                          height: 50.h,
                          width: screenWidth * .4,
                          text: "Retake",
                          isOutline: true,
                          isAuth: false,
                          color: Colors.grey.withOpacity(.5),
                          onPressed: () {
                            controller.resumePreview().then((value) {
                              setState(() {
                                isCameraPause = false;
                              });
                            });
                          }),
                      AppButton(
                          height: 50.h,
                          width: screenWidth * .4,
                          text: "Add",
                          isAuth: false,
                          onPressed: () {
                            if (widget.isPickup) {
                              Provider.of<ConfirmOrderProvider>(context,
                                      listen: false)
                                  .pickUpOrdersImages
                                  .add(imageFile!);
                              if (widget.isFromMap) {
                                GoRouter.of(context).pushReplacementNamed(
                                    RouteConstant.confirmPickUpOrder);
                              } else {
                                GoRouter.of(context).pop();
                              }
                            } else {
                              Provider.of<ConfirmOrderProvider>(context,
                                      listen: false)
                                  .dropOffOrdersImages
                                  .add(imageFile!);

                              if (widget.isFromMap) {
                                GoRouter.of(context).pushReplacementNamed(
                                    RouteConstant.confirmDropOffOrder);
                              } else {
                                GoRouter.of(context).pop();
                              }
                            }
                          }),
                    ],
                  ),
                )
              : Positioned(
                  bottom: 0,
                  child: Container(
                    height: screenHeight * .2,
                    width: screenWidth,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Photo",
                                style: TextStyle(color: Colors.amber),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  controller.takePicture().then((value) {
                                    controller.pausePreview();
                                    setState(() {
                                      isCameraPause = true;
                                      imageFile = File(value.path);
                                    });
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                        IconButton(
                          onPressed: () {
                            if (!isFront) {
                              cameraInitialization(1);
                            } else {
                              cameraInitialization(0);
                            }
                          },
                          icon: Icon(
                              isFront
                                  ? Icons.flip_camera_ios
                                  : Icons.flip_camera_ios_outlined,
                              color: Colors.white,
                              size: 40),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
