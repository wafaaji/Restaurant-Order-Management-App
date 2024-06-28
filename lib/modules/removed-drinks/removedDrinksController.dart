import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/model/restoreRemovedMealDrinkModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/menu-meals/deleteMenuMealService.dart';
import 'package:employee/modules/menu-meals/displayMenuMealsService.dart';
import 'package:employee/modules/removed-drinks/displayRemovedDrinksService.dart';
import 'package:employee/modules/removed-drinks/restoreRemovedDrinkService.dart';
import 'package:employee/modules/removed-meals/displayRemovedMealsService.dart';
import 'package:employee/modules/removed-meals/restoreRemovedMealService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemovedDrinksController extends GetxController with SingleGetTickerProviderMixin{
  late TabController removedDrinksController;

  RxInt current = 0.obs;

  var message;

  //for display removed drinks
  late DisplayRemovedDrinksService serviceDisplay;
  var removedDrinksList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allRemovedDrinks = [];

  SecureStorage storage = SecureStorage();

  //
  List<Category> drinkCategories = [];
  RxString removedDrinksSubCategory = RxString('');
  //

  // for restore removed meal
  late RestoreRemovedDrinkService serviceRestore;
  var restoreRemovedDrinkStatus;


  @override
  void onInit() {
    super.onInit();
    removedDrinksController = TabController(length: drinkCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayRemovedDrinksService();

    //
    removedDrinksSubCategory.value = drinkCategories.isNotEmpty ? drinkCategories[0].name : '';
    fetchDrinkCategories();
    //

    serviceRestore = RestoreRemovedDrinkService();
    restoreRemovedDrinkStatus = false;

  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allRemovedDrinks = await serviceDisplay.displayRemovedDrinks(token);
    removedDrinksList.value = allRemovedDrinks;
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    removedDrinksController.dispose();
    super.onClose();
  }

  //
  void fetchDrinkCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      drinkCategories = categoryList.where((category) => category.type == "drink").toList();

      if (drinkCategories.isNotEmpty) {
        removedDrinksSubCategory.value = drinkCategories[0].name; // Fix this line
        removedDrinksController = TabController(length: drinkCategories.length + 1, vsync: this); // Move this line here
        removedDrinksSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching drink categories: $e");
    }
  }
//


  Future<void> restoreRemovedDrinkOnClick(MealsDrinks mealsDrinks) async{
    RestoreRemovedMealDrink restoreRemovedMealDrink = RestoreRemovedMealDrink(
      id: mealsDrinks.id,
    );
    restoreRemovedDrinkStatus = await serviceRestore.restoreRemovedDrink(restoreRemovedMealDrink);
    message = serviceRestore.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateRemovedDrinkList() async {
    isLoading.value = true;
    removedDrinksList.clear();

    // Fetch the new list of menu meals based on the existing categories
    var token = await storage.read("token");
    allRemovedDrinks = await serviceDisplay.displayRemovedDrinks(token);
    removedDrinksList.value = allRemovedDrinks;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allRemovedDrinks = await serviceDisplay.displayRemovedDrinks(token);
    removedDrinksList.value = allRemovedDrinks;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
