import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/menu-drinks/displayMenuDrinksService.dart';
import 'package:employee/modules/menu-meals/displayMenuMealsService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMealsDrinksController extends GetxController with SingleGetTickerProviderMixin {

  late TabController tabController;

  var isLoading = true.obs;

  var selectedItemCount = 0.obs;

//to get the meal drink list from server
  List<MealsDrinks> mealList = [];
  List<MealsDrinks> drinkList = [];

// //To Store selected meal and drink IDs
//   Map<int, bool> selectedMealIds = {};
//   Map<int, bool> selectedDrinkIds = {};

  var selectedMealIds = <String>[].obs;
  var selectedDrinkIds = <String>[].obs;

  SecureStorage storage = SecureStorage();


  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);

    mealList = <MealsDrinks>[].obs;
    drinkList = <MealsDrinks>[].obs;

//
    fetchMealList();
    fetchDrinkList();
//

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }

  void fetchMealList() async {
    var token = await storage.read("token");
    try {
      List<MealsDrinks> meals = await DisplayMenuMealsService()
          .displayMenuMeals(token);
      mealList.assignAll(meals);
      isLoading.value = false; // Set loading to false after fetching
    } catch (e) {
      print("Error fetching meal categories: $e");
      isLoading.value = false;
    }
  }

  void fetchDrinkList() async {
    var token = await storage.read("token");
    try {
      List<MealsDrinks> drinks = await DisplayMenuDrinksService()
          .displayMenuDrinks(token);
      drinkList.assignAll(drinks);
      isLoading.value = false; // Set loading to false after fetching
    } catch (e) {
      print("Error fetching drink categories: $e");
      isLoading.value = false; // Set loading to false in case of error
    }
  }

  // void toggleMealSelection(MealsDrinks meal) {
  //   if (selectedMealIds.containsKey(meal.id)) {
  //     selectedMealIds[meal.id] = !selectedMealIds[meal.id]!;
  //     if (selectedMealIds[meal.id]!) {
  //       selectedItemCount.value++;
  //     }
  //   } else {
  //     selectedMealIds[meal.id] = true;
  //     selectedItemCount.value++;
  //   }
  // }
  //
  // void toggleDrinkSelection(MealsDrinks drink) {
  //   if (selectedDrinkIds.containsKey(drink.id)) {
  //     selectedDrinkIds[drink.id] = !selectedDrinkIds[drink.id]!;
  //     if (selectedDrinkIds[drink.id]!) {
  //       selectedItemCount.value++; // Increase the count if selected
  //
  //     }
  //   } else {
  //     selectedDrinkIds[drink.id] = true;
  //     selectedItemCount.value++;
  //   }
  // }

  void toggleMealSelection(MealsDrinks meal) {
    selectedMealIds.add(meal.id.toString());
    selectedItemCount.value = selectedMealIds.length + selectedDrinkIds.length;
  }

  void toggleDrinkSelection(MealsDrinks drink) {
    selectedDrinkIds.add(drink.id.toString());
    selectedItemCount.value = selectedMealIds.length + selectedDrinkIds.length;
  }

  //
  // void updateSelectedItemCount() {
  //   selectedItemCount.value = selectedMealIds.values
  //       .where((selected) => selected)
  //       .length +
  //       selectedDrinkIds.values
  //           .where((selected) => selected)
  //           .length;
  // }

// Get selected meal IDs

//   void updateSelectedItemCount() {
//     selectedItemCount.value = selectedMealIds.values
//         .where((selected) => selected)
//         .length +
//         selectedDrinkIds.values
//             .where((selected) => selected)
//             .length;
//   }
//
//   List<int> getSelectedMealIds() {
//     return selectedMealIds.entries.where((entry) => entry.value).map((
//         entry) => entry.key).toList();
//   }
//
// // Get selected drink IDs
//   List<int> getSelectedDrinkIds() {
//     return selectedDrinkIds.entries.where((entry) => entry.value).map((
//         entry) => entry.key).toList();
//   }

  void updateSelectedItemCount() {
    selectedItemCount.value = selectedMealIds.length + selectedDrinkIds.length;
  }

  List<String> getSelectedMealIds() {
    return selectedMealIds;
  }

    List<String> getSelectedDrinkIds() {
    return selectedDrinkIds;
  }


}