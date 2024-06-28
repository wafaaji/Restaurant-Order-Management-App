import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/editCategoryModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class EditCategoryService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.editCategory);

  Future<bool> editCategory(EditCategory editCategory) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "category_id" : "${editCategory.id}",
        "name" : "${editCategory.name}",
        "type" : "${editCategory.type}",
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
      message = jsonResponse["message"];
      return false;
    }else{
      message = 'Server Error';
      return false;
    }

  }

}