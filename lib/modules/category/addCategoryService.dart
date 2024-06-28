import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/addCategoryModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class AddCategoryService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.addCategory);

  Future<bool> addCategory(AddCategory addCategory) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "name" : "${addCategory.name}",
        "type" : "${addCategory.type}",
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
      message = jsonResponse["name"];
      return false;
    }else{
      message = 'Server Error';
      return false;
    }

  }

}