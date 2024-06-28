import 'dart:ui';
import 'package:employee/components/customText.dart';
import 'package:employee/components/customTextField.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/modules/login/loginController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class loginScreen extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {

    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/burger.jpg"),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.color)
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: deviceHeight * 0.90,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: controller.loginFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: LayoutBuilder(builder: (ctx,context){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: ' L O G I N ',
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: deviceHeight * 0.3),
                              child: CustomTextField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  controller.email = value!;
                                },
                                validator: (value) {
                                  return controller.validateEmail(value!);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "test@gmail.com",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Obx(() => CustomTextField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.isPassword.value,
                              onSaved: (value){
                                controller.password = value!;
                              },
                              validator: (value) {
                                return controller.validatePassword(value!);
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: (){
                                    controller.changePassword();
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: "Password",
                              ),
                            ),),
                            SizedBox(
                              height: 40.0,
                            ),
                            CustomElevatedButton(
                                onPressed: () {
                                  onClickLogin();
                                },
                                buttonText: "Login",
                                buttonColor: Color(0xFFBE0B0B),
                                borderRadius: BorderRadius.circular(20),
                                textColor: Colors.white,
                                height: 40.0,
                                width: 100.0,
                                fontSize: 30.0,
                              ),
                          ],
                        );
                      },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
    );
  }

  void onClickLogin() async{
    EasyLoading.show(status: "loading...");

    await controller.loginOnClick();

    if(controller.loginStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.offAllNamed("/home");
    }else{
      EasyLoading.showError(
        controller.message,
        duration: Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      print("Error Here");
    }
  }
}