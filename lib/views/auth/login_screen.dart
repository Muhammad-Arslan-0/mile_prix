import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/helper/fields_validation.dart';
import 'package:mile_prix/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/route_constant.dart';
import '../../widget/app_button.dart';
import '../../widget/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * .08,
            left: screenWidth * .05,
            right: screenWidth * .05),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.logo, scale: 6),
                SizedBox(height: 15.h),
                Text(
                  "Welcome, Driver",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                Text(
                  "Login with Email.",
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(height: 20.h),
                AppTextFiled(
                    hintText: "Email",
                    controller: provider.emailController,
                    validator: (v) => FieldsValidation.emailFieldValidation(
                        provider.emailController.text),
                    headText: "Email"),
                SizedBox(height: 10.h),
                AppTextFiled(
                  hintText: "Password",
                  controller: provider.passwordController,
                  headText: "Password",
                  validator: (v) => FieldsValidation.emptyFieldValidation(
                      provider.passwordController.text),
                  isPassword: true,
                ),
                SizedBox(height: 20.h),
                AppButton(
                    height: 50.h,
                    width: screenWidth * .9,
                    text: "LOGIN",
                    onPressed: () {
                      if (provider.formKey.currentState!.validate()) {
                        provider.emailController.clear();
                        provider.passwordController.clear();
                        GoRouter.of(context)
                            .goNamed(RouteConstant.successLoginScreen);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
