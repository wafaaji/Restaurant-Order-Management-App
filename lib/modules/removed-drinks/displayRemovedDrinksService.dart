import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displayMenuMealsDrinksModel.dart';
import 'package:employee/model/displayRemovedMealsDrinksModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:http/http.dart' as http;

class DisplayRemovedDrinksService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayRemovedDrink);

  Future<List<MealsDrinks>> displayRemovedDrinks(var token) async{
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
        var removedDrinks = displayRemovedMealsDrinksFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var removedDrinksList = jsonResponse["data"];
        print("-----------------display removed Drink----------------");
        print(removedDrinksList);

        //
        // Fetch drink categories using DisplayCategoryService
        var displayCategoryService = DisplayCategoryService();
        var categories = await displayCategoryService.displayCategory(token);

        var drinkCategoryMap = Map<String, List<MealsDrinks>>();

        for (var drink in removedDrinks.data) {
          for (var category in categories) {
            if (category.id == drink.categoryId) {
              var categoryName = category.name;
              drinkCategoryMap.putIfAbsent(categoryName, () => []);
              drinkCategoryMap[categoryName]!.add(drink);
              break; // Stop looping through categories once a match is found
            }
          }
        }

        // Print each list separately
        drinkCategoryMap.forEach((category, drinksList) {
          print("Category: $category");
          drinksList.forEach((drink) {
            print("Meal Name: ${drink.name}");
            print("Category: $category");
            print("Image: ${drink.image}"); // Assuming 'image' is the image URL
            print("Price: ${drink.price}");
            print("Description: ${drink.description}");
            print("Rate: ${drink.rate}");
            print("");
          });
        });
        //

        return removedDrinks.data;
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