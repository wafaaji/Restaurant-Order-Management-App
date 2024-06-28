import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/menu-drinks/deleteMenuDrinkService.dart';
import 'package:employee/modules/menu-drinks/displayMenuDrinksService.dart';
import 'package:employee/modules/menu-meals/deleteMenuMealService.dart';
import 'package:employee/modules/menu-meals/displayMenuMealsService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDrinksController extends GetxController with SingleGetTickerProviderMixin{
  late TabController menuDrinksController;


  RxInt current = 0.obs;

  var message;

  //for display menu meals
  late DisplayMenuDrinksService serviceDisplay;
  var menuDrinksList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allMenuDrinks = [];

  SecureStorage storage = SecureStorage();

  //
  List<Category> drinkCategories = [];
  RxString menuDrinksSubCategory = RxString('');
  //

  // for delete main meal
  late DeleteMenuDrinkService serviceDelete;
  var deleteMenuDrinkStatus;


  @override
  void onInit() {
    super.onInit();
    menuDrinksController = TabController(length: drinkCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayMenuDrinksService();

    //
    menuDrinksSubCategory.value = drinkCategories.isNotEmpty ? drinkCategories[0].name : '';
    fetchDrinkCategories();
    //

    serviceDelete = DeleteMenuDrinkService();
    deleteMenuDrinkStatus = false;

  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allMenuDrinks = await serviceDisplay.displayMenuDrinks(token);
    menuDrinksList.value = allMenuDrinks;
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    menuDrinksController.dispose();
    super.onClose();
  }

  //
  void fetchDrinkCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      drinkCategories = categoryList.where((category) => category.type == "drink").toList();

      if (drinkCategories.isNotEmpty) {
        menuDrinksSubCategory.value = drinkCategories[0].name; // Fix this line
        menuDrinksController = TabController(length: drinkCategories.length + 1, vsync: this); // Move this line here
        menuDrinksSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching drink categories: $e");
    }
  }
//


  Future<void> deleteMenuDrinkOnClick(MealsDrinks mealsDrinks) async{
    DeleteMenuMealDrink deleteMenuMealDrink = DeleteMenuMealDrink(
      id: mealsDrinks.id,
    );
    deleteMenuDrinkStatus = await serviceDelete.deleteMenuDrink(deleteMenuMealDrink);
    message = serviceDelete.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateMenuDrinkList() async {
    isLoading.value = true;
    menuDrinksList.clear();

    // Fetch the new list of menu drinks based on the existing categories
    var token = await storage.read("token");
    allMenuDrinks = await serviceDisplay.displayMenuDrinks(token);
    menuDrinksList.value = allMenuDrinks;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allMenuDrinks = await serviceDisplay.displayMenuDrinks(token);
    menuDrinksList.value = allMenuDrinks;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
