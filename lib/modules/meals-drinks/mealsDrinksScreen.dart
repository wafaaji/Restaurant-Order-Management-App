import 'package:employee/components/customIconButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/modules/main-drinks/mainDrinksScreen.dart';
import 'package:employee/modules/main-meals/mainMealsScreen.dart';
import 'package:employee/modules/meals-drinks/mealsDrinksController.dart';
import 'package:employee/modules/menu-drinks/menuDrinksScreen.dart';
import 'package:employee/modules/menu-meals/menuMealsScreen.dart';
import 'package:employee/modules/removed-drinks/removedDrinksScreen.dart';
import 'package:employee/modules/removed-meals/removedMealsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class mealsDrinksScreen extends GetView<MealsDrinksController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBE0B0B),
        leading: CustomIconButton(
          icon: Icons.arrow_back_outlined,
          color: Colors.white,
          size: 25.0,
          onPressed: () {
            Get.toNamed("/home");
          },
        ),
        title: CustomText(
          text: "Meals/Drinks",
          fontSize: 25.0,
          color: Colors.white,
        ),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelStyle: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
            controller: controller.mealsDrinksController,
          tabs: controller.myTabs,
        ),
      ),
      body: Column(
        children: [
          Expanded(
                child: TabBarView(
                  controller: controller.mealsDrinksController,
                  children: [
                    mainMealsScreen(),
                    mainDrinksScreen(),
                    menuMealsScreen(),
                    menuDrinksScreen(),
                    removedMealsScreen(),
                    removedDrinksScreen(),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}