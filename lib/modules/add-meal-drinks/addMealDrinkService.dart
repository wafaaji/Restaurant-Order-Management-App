import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/addMainMealDrinkModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class AddMealDrinkService {

  var message;
  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.addMeal);


  Future<bool> serviceAddMealDrink(AddMainMealDrink addMealsDrinks , http.MultipartFile imageFile) async {
    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    // Add fields and the image MultipartFile to the request
    request.fields['name'] = addMealsDrinks.name!;
    request.fields['description'] = addMealsDrinks.description!;
    request.fields['category_id'] = addMealsDrinks.categoryId.toString();
    request.fields['price'] = addMealsDrinks.price!;
    request.files.add(imageFile); // Add the image as a MultipartFile

    var response = await request.send();

    // print(response.statusCode);
    // var responseBody = await response.stream.bytesToString();
    // print(responseBody);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(await response.stream.bytesToString());
      message = "add successfully";
      return true;
    } else if (response.statusCode == 400) {
      var jsonResponse = jsonDecode(await response.stream.bytesToString());
      message = jsonResponse["message"];
      return false;
    } else {
      message = 'Server Error';
      return false;
    }
  }
}
