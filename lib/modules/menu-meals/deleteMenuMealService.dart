import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/deleteMainMealDrinkModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class DeleteMenuMealService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.dropMenu);

  Future<bool> deleteMenuMeal(DeleteMenuMealDrink deleteMenuMealDrink) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "meal_id" : "${deleteMenuMealDrink.id}",
      },
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse["message"];
      return true;
    }else if (response.statusCode == 400){
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse["meal_id"];
      return false;
    }else{
      message = 'Server Error';
      return false;
    }

  }

}