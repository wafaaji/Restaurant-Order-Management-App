import 'package:employee/model/loginModel.dart';
import 'package:employee/modules/login/loginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  late final loginFormKey;
  late TextEditingController emailController , passwordController;
  var email;
  var password;
  late RxBool isPassword;

  late LoginService service;
  var loginStatus;
  var message;

  @override
  void onInit(){
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    email = '';
    password = '';
    isPassword = true.obs;
    service = LoginService();
    loginStatus = false;
    message = '';

    super.onInit() ;
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail (String value) {
    if (!GetUtils.isEmail(value))
    {
      return 'Please provide valid Email';
    }
    return null;
  }

  String? validatePassword (String value) {
    if (value.length < 8)
    {
      return 'Password must be of 8 characters';
    }
    return null;
  }

  Future<void> loginOnClick() async{
    email = emailController.text;
    password = passwordController.text;
    Login login = Login(
      email: email,
      password: password,
    );
    print("______________login________________");
    loginStatus = await service.login(login);
    message = service.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  void changePassword (){
    isPassword.value = !isPassword.value;
    update();
  }

}