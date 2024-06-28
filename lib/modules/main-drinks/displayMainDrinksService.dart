import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displaMainMealsDrinksModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:http/http.dart' as http;

class DisplayMainDrinksService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayDrinks);

  Future<List<MealsDrinks>> displayMainDrinks(var token) async{
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
        var mealsDrinks = displayMainMealsDrinksFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var mainDrinksList = jsonResponse["data"];
        print("-----------------display main Drinks----------------");
        print(mainDrinksList);

        //
        // Fetch drink categories using DisplayCategoryService
        var displayCategoryService = DisplayCategoryService();
        var categories = await displayCategoryService.displayCategory(token);

        var drinkCategoryMap = Map<String, List<MealsDrinks>>();

        for (var drink in mealsDrinks.data) {
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
            print("Drink Name: ${drink.name}");
            print("Category: $category");
            print("Image: ${drink.image}"); // Assuming 'image' is the image URL
            print("Price: ${drink.price}");
            print("Description: ${drink.description}");
            print("Rate: ${drink.rate}");
            print("");
          });
        });
        //

        return mealsDrinks.data;
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