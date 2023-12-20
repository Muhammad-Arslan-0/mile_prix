import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFiled extends StatefulWidget {
  final String headText;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const AppTextFiled(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.headText,
      this.isPassword = false,
      this.validator});

  @override
  State<AppTextFiled> createState() => _AppTextFiledState();
}

class _AppTextFiledState extends State<AppTextFiled> {
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.headText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: isSecure && widget.isPassword,
          autofocus: false,
          validator: widget.validator,
          decoration: InputDecoration(

              hintText: widget.hintText,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isSecure = !isSecure;
                        });
                      },
                      child: Icon(isSecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    )
                  : null,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ],
    );
  }
}
