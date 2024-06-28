import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/deleteCategory.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class DeleteCategoryService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.deleteCategory);

  Future<bool> deleteCategory(DeleteCategory deleteCategory) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "category_id" : "${deleteCategory.id}",
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