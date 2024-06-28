import 'package:employee/modules/splash/splashController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class splashScreen extends StatelessWidget {

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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // colors: [Color(0xFFBE0B0B),Color(0xFFD9D9D9)]
              colors: [Color(0xFFD9D9D9),Color(0xFFD9D9D9)]
          ),
        ),
        alignment: Alignment.center,
        child: GetBuilder<SplashController>(
            init: SplashController(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250.0,
                  width: 250.0,
                  child: Lottie.asset(
                    "assets/splash1.json",
                  ),
                ),
                Text(
                  ' F A T  C H E F ',
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Color(0xFFBE0B0B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                    height: 20.0
                ),
                Text(
                  ' Employee Application ',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Color(0xFFBE0B0B),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
