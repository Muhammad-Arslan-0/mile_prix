import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  GlobalKey<FormState> get formKey=>_formKey;
}