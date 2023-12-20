import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  final File image;
  const ImageViewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white)),
      body: Center(
          child: Image.file(image,
              width: screenWidth,
              height: screenHeight * .6,
              fit: BoxFit.cover)),
    );
  }
}
