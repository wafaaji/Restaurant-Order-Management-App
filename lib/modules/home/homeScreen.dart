import 'dart:ui';
import 'package:employee/components/customAppBar.dart';
import 'package:employee/components/customIconButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/modules/home/homeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class homeScreen extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBE0B0B),
        leading: CustomIconButton(
          icon: Icons.login_outlined,
          color: Colors.white,
          size: 30.0,
          onPressed: () {
            onClickLogout();
          },
        ),
        title: CustomText(
          text: 'Home',
          fontSize: 25.0,
          color: Colors.white,
        ),
      ),
      body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // colors: [Color(0xFFBE0B0B), Color(0xFFD9D9D9), Color(0xFFBE0B0B)]
                      colors: [Colors.grey, Color(0xFFD9D9D9), Colors.grey]
                  ),
                ),
                child: Obx(() {
                  final int currentPage = controller.currentPage.value;
                  print(currentPage);
                  return Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: VerticalCardPager(
                      onPageChanged: (double? page) {
                        if (page != null) {
                          controller.changePage(page.round());
                        }
                      },
                      onSelectedItem: controller.selectCard,
                      titles: controller.titles,
                      images: controller.images,
                      textStyle: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.90),
                        fontStyle: FontStyle.italic,
                      ),
                      initialPage: 3,
                      align: ALIGN.CENTER,
                    ),
                  );
                }),
              ),
    );
  }

  void onClickLogout() async{
    EasyLoading.show(status: "loading...");

    await controller.logoutOnClick();

    if(controller.logoutStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.offAllNamed("/splash");
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
