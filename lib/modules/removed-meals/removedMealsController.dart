import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/model/restoreRemovedMealDrinkModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/menu-meals/deleteMenuMealService.dart';
import 'package:employee/modules/menu-meals/displayMenuMealsService.dart';
import 'package:employee/modules/removed-meals/displayRemovedMealsService.dart';
import 'package:employee/modules/removed-meals/restoreRemovedMealService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemovedMealsController extends GetxController with SingleGetTickerProviderMixin{
  late TabController removedMealsController;

  RxInt current = 0.obs;

  var message;

  //for display menu meals
  late DisplayRemovedMealsService serviceDisplay;
  var removedMealsList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allRemovedMeals = [];

  SecureStorage storage = SecureStorage();

  //
  List<Category> mealCategories = [];
  RxString removedMealsSubCategory = RxString('');
  //

  // for restore removed meal
  late RestoreRemovedMealService serviceRestore;
  var restoreRemovedMealStatus;


  @override
  void onInit() {
    super.onInit();
    removedMealsController = TabController(length: mealCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayRemovedMealsService();

    //
    removedMealsSubCategory.value = mealCategories.isNotEmpty ? mealCategories[0].name : '';
    fetchMealCategories();
    //

    serviceRestore = RestoreRemovedMealService();
    restoreRemovedMealStatus = false;

  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allRemovedMeals = await serviceDisplay.displayRemovedMeals(token);
    removedMealsList.value = allRemovedMeals;
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    removedMealsController.dispose();
    super.onClose();
  }

  //
  void fetchMealCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      mealCategories = categoryList.where((category) => category.type == "meal").toList();

      if (mealCategories.isNotEmpty) {
        removedMealsSubCategory.value = mealCategories[0].name; // Fix this line
        removedMealsController = TabController(length: mealCategories.length + 1, vsync: this); // Move this line here
        removedMealsSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching meal categories: $e");
    }
  }
//


  Future<void> restoreRemovedMealOnClick(MealsDrinks mealsDrinks) async{
    RestoreRemovedMealDrink restoreRemovedMealDrink = RestoreRemovedMealDrink(
      id: mealsDrinks.id,
    );
    restoreRemovedMealStatus = await serviceRestore.restoreRemovedMeal(restoreRemovedMealDrink);
    message = serviceRestore.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateRemovedMealList() async {
    isLoading.value = true;
    removedMealsList.clear();

    // Fetch the new list of menu meals based on the existing categories
    var token = await storage.read("token");
    allRemovedMeals = await serviceDisplay.displayRemovedMeals(token);
    removedMealsList.value = allRemovedMeals;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allRemovedMeals = await serviceDisplay.displayRemovedMeals(token);
    removedMealsList.value = allRemovedMeals;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
