import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class LogoutService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.logout);

  Future<bool> logout(var token) async{
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
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse["message"];
        SecureStorage storage = SecureStorage();
        await storage.delete("token");
        return true;
      } else {
        message = 'Server Error';
        return false;
      }
    } catch (e) {
      // Handle the exception here (e.g., print error message)
      print("Exception during logout request: $e");
      message = 'An error occurred';
      return false;
    }

  }

}