import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMainMealDrinkModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/main-meals/deleteMainMealService.dart';
import 'package:employee/modules/main-meals/displayMainMealsService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMealsController extends GetxController with SingleGetTickerProviderMixin{
  late TabController mainMealsController;

  RxInt current = 0.obs;

  var message;

  //
  List<Category> mealCategories = [];
  RxString mainMealsSubCategory = RxString('');
  //

  //for display main meals
  late DisplayMainMealsService serviceDisplay;
  var mainMealsList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allMainMeals = [];

  // for delete main meal
  late DeleteMainMealService serviceDelete;
  var deleteMainMealStatus;

  SecureStorage storage = SecureStorage();


  @override
  void onInit() {
    super.onInit();
    mainMealsController = TabController(length: mealCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayMainMealsService();

    //
    mainMealsSubCategory.value = mealCategories.isNotEmpty ? mealCategories[0].name : '';
    fetchMealCategories();
    //
    serviceDelete = DeleteMainMealService();
    deleteMainMealStatus = false;
  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allMainMeals = await serviceDisplay.displayMainMeals(token);
    mainMealsList.value = allMainMeals;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    mainMealsController.dispose();
    super.onClose();
  }

  //
  void fetchMealCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      mealCategories = categoryList.where((category) => category.type == "meal").toList();

      if (mealCategories.isNotEmpty) {
        mainMealsSubCategory.value = mealCategories[0].name; // Fix this line
        mainMealsController = TabController(length: mealCategories.length + 1, vsync: this); // Move this line here
        mainMealsSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching meal categories: $e");
    }
  }
//

  Future<void> deleteMainMealOnClick(MealsDrinks mealsDrinks) async{
    DeleteMainMealDrink deleteMainMealDrink = DeleteMainMealDrink(
      id: mealsDrinks.id,
    );
    deleteMainMealStatus = await serviceDelete.deleteMainMeal(deleteMainMealDrink);
    message = serviceDelete.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateMainMealList() async {
    isLoading.value = true;
    mainMealsList.clear();

    // Fetch the new list of main meals based on the existing categories
    var token = await storage.read("token");
    allMainMeals = await serviceDisplay.displayMainMeals(token);
    mainMealsList.value = allMainMeals;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allMainMeals = await serviceDisplay.displayMainMeals(token);
    mainMealsList.value = allMainMeals;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }


}
