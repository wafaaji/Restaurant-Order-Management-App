import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/menu-meals/deleteMenuMealService.dart';
import 'package:employee/modules/menu-meals/displayMenuMealsService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuMealsController extends GetxController with SingleGetTickerProviderMixin{
  late TabController menuMealsController;

  final List<String> menuMeals = [
    "All",
    "Fast Food",
    "Appetizers",
    "Salads",
    "Soups",
    "Main Courses",
    "Pizza",
    "Sides Dishes",
    "Desserts",
  ];

  RxInt current = 0.obs;

  var message;

  //for display menu meals
  late DisplayMenuMealsService serviceDisplay;
  var menuMealsList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allMenuMeals = [];

  SecureStorage storage = SecureStorage();

  //
  List<Category> mealCategories = [];
  RxString menuMealsSubCategory = RxString('');
  //

  // for delete main meal
  late DeleteMenuMealService serviceDelete;
  var deleteMenuMealStatus;


  @override
  void onInit() {
    super.onInit();
    menuMealsController = TabController(length: mealCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayMenuMealsService();

    //
    menuMealsSubCategory.value = mealCategories.isNotEmpty ? mealCategories[0].name : '';
    fetchMealCategories();
    //

    serviceDelete = DeleteMenuMealService();
    deleteMenuMealStatus = false;

  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allMenuMeals = await serviceDisplay.displayMenuMeals(token);
    menuMealsList.value = allMenuMeals;
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    menuMealsController.dispose();
    super.onClose();
  }

  //
  void fetchMealCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      mealCategories = categoryList.where((category) => category.type == "meal").toList();

      if (mealCategories.isNotEmpty) {
        menuMealsSubCategory.value = mealCategories[0].name; // Fix this line
        menuMealsController = TabController(length: mealCategories.length + 1, vsync: this); // Move this line here
        menuMealsSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching meal categories: $e");
    }
  }
//


  Future<void> deleteMenuMealOnClick(MealsDrinks mealsDrinks) async{
    DeleteMenuMealDrink deleteMenuMealDrink = DeleteMenuMealDrink(
      id: mealsDrinks.id,
    );
    deleteMenuMealStatus = await serviceDelete.deleteMenuMeal(deleteMenuMealDrink);
    message = serviceDelete.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateMenuMealList() async {
    isLoading.value = true;
    menuMealsList.clear();

    // Fetch the new list of menu meals based on the existing categories
    var token = await storage.read("token");
    allMenuMeals = await serviceDisplay.displayMenuMeals(token);
    menuMealsList.value = allMenuMeals;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allMenuMeals = await serviceDisplay.displayMenuMeals(token);
    menuMealsList.value = allMenuMeals;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
