import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displayMenuMealsDrinksModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:http/http.dart' as http;

class DisplayMenuMealsService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayMenuMeal);

  Future<List<MealsDrinks>> displayMenuMeals(var token) async{
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        //take json and make it var
        var menuMeals = displayMenuMealsDrinksFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var menuMealsList = jsonResponse["data"];
        print("-----------------display main Meals----------------");
        print(menuMealsList);

        //
        // Fetch meal categories using DisplayCategoryService
        var displayCategoryService = DisplayCategoryService();
        var categories = await displayCategoryService.displayCategory(token);

        var mealCategoryMap = Map<String, List<MealsDrinks>>();

        for (var meal in menuMeals.data) {
          for (var category in categories) {
            if (category.id == meal.categoryId) {
              var categoryName = category.name;
              mealCategoryMap.putIfAbsent(categoryName, () => []);
              mealCategoryMap[categoryName]!.add(meal);
              break; // Stop looping through categories once a match is found
            }
          }
        }

        // Print each list separately
        mealCategoryMap.forEach((category, mealsList) {
          print("Category: $category");
          mealsList.forEach((meal) {
            print("Meal Name: ${meal.name}");
            print("Category: $category");
            print("Image: ${meal.image}"); // Assuming 'image' is the image URL
            print("Price: ${meal.price}");
            print("Description: ${meal.description}");
            print("Rate: ${meal.rate}");
            print("");
          });
        });
        //

        return menuMeals.data;
      } else {
        message = 'Server Error';
        return [];
      }
    } catch (e) {
      print("Exception during logout request: $e");
      message = 'An error occurred';
      return [];
    }

  }


}