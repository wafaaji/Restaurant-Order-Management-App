import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsDrinksController extends GetxController with SingleGetTickerProviderMixin{
  late TabController mealsDrinksController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: "Main Meals",
    ),
    Tab(
      text: "Main Drinks",
    ),
    Tab(
      text: "Menu Meals",
    ),
    Tab(
      text: "Menu Drinks",
    ),
    Tab(
      text: "Removed Meals",
    ),
    Tab(
      text: "Removed Drinks",
    ),
  ];



  @override
  void onInit() {
    super.onInit();
    mealsDrinksController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose() {
    mealsDrinksController.dispose();
    super.onClose();
  }
}
