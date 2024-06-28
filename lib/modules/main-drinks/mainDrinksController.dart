import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteMainMealDrinkModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/main-drinks/deleteMainDrinkService.dart';
import 'package:employee/modules/main-drinks/displayMainDrinksService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrinksController extends GetxController with SingleGetTickerProviderMixin{
  late TabController mainDrinksController;

  RxInt current = 0.obs;

  var message;

  //
  List<Category> drinkCategories = [];
  RxString mainDrinksSubCategory = RxString('');
  //

  //for display main drinks
  late DisplayMainDrinksService serviceDisplay;
  var mainDrinksList = <MealsDrinks>[].obs;
  var isLoading = true.obs;
  late List<MealsDrinks> allMainDrinks = [];

  // for delete main drink
  late DeleteMainDrinkService serviceDelete;
  var deleteMainDrinkStatus;

  SecureStorage storage = SecureStorage();


  @override
  void onInit() {
    super.onInit();
    mainDrinksController = TabController(length: drinkCategories.length, vsync: this);
    message = '';
    serviceDisplay = DisplayMainDrinksService();

    //
    mainDrinksSubCategory.value = drinkCategories.isNotEmpty ? drinkCategories[0].name : '';
    fetchDrinkCategories();
    //
    serviceDelete = DeleteMainDrinkService();
    deleteMainDrinkStatus = false;
  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allMainDrinks = await serviceDisplay.displayMainDrinks(token);
    mainDrinksList.value = allMainDrinks;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    mainDrinksController.dispose();
    super.onClose();
  }

  //
  void fetchDrinkCategories() async {
    var token = await storage.read("token");
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      drinkCategories = categoryList.where((category) => category.type == "drink").toList();

      if (drinkCategories.isNotEmpty) {
        mainDrinksSubCategory.value = drinkCategories[0].name;
        mainDrinksController = TabController(length: drinkCategories.length + 1, vsync: this); // Move this line here
        mainDrinksSubCategory.value = "All";
      }
    } catch (e) {
      print("Error fetching drink categories: $e");
    }
  }
//

  Future<void> deleteMainDrinkOnClick(MealsDrinks mealsDrinks) async{
    DeleteMainMealDrink deleteMainMealDrink = DeleteMainMealDrink(
      id: mealsDrinks.id,
    );
    deleteMainDrinkStatus = await serviceDelete.deleteMainDrink(deleteMainMealDrink);
    message = serviceDelete.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateMainDrinkList() async {
    isLoading.value = true;
    mainDrinksList.clear();

    // Fetch the new list of main drinks based on the existing categories
    var token = await storage.read("token");
    allMainDrinks = await serviceDisplay.displayMainDrinks(token);
    mainDrinksList.value = allMainDrinks;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allMainDrinks = await serviceDisplay.displayMainDrinks(token);
    mainDrinksList.value = allMainDrinks;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }


}
