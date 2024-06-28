import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displaMainMealsDrinksModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:http/http.dart' as http;

class DisplayMainMealsService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayMeals);

  Future<List<MealsDrinks>> displayMainMeals(var token) async{
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
        var mainMeals = displayMainMealsDrinksFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var mainMealsList = jsonResponse["data"];
        print("-----------------display main Meals----------------");
        print(mainMealsList);

        //
        // Fetch meal categories using DisplayCategoryService
        var displayCategoryService = DisplayCategoryService();
        var categories = await displayCategoryService.displayCategory(token);

        var mealCategoryMap = Map<String, List<MealsDrinks>>();

        for (var meal in mainMeals.data) {
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

        return mainMeals.data;
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