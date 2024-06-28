import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/displayCategoryModel.dart';
import 'package:http/http.dart' as http;

class DisplayCategoryService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayCategory);

  Future<List<Category>> displayCategory(var token) async{
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
        var category = displayCategoryFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var categoryList = jsonResponse["data"];
        print("-----------------display category----------------");
        print(categoryList);
        var mealCategories = categoryList
            .where((category) => category["type"] == "meal")
            .toList();

        print("-----------------display meal category----------------");
        print(mealCategories);
        var drinkCategories = categoryList
            .where((category) => category["type"] == "drink")
            .toList();

        print("-----------------display drink category----------------");
        print(drinkCategories);
        return category.data;
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