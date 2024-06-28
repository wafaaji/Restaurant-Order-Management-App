import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/editMainMealsModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class EditMainMealService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.updateMeal);

  Future<bool> editMainMeal(EditMainMeal editMainMeal) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "meal_id" : "${editMainMeal.meal_id}",
        "category_id" : "${editMainMeal.categoryId}",
        "name" : "${editMainMeal.name}",
        "description" : "${editMainMeal.description}",
        "image" : "${editMainMeal.image}",
        "price" : "${editMainMeal.price}"
      },
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      message = "add successfully";
      return true;
    }else if (response.statusCode == 400){
      var jsonResponse = jsonDecode(response.body);
      message = "error";
      return false;
    }else{
      message = 'Server Error';
      return false;
    }

  }

}