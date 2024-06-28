import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/addOffersModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class AddOffersService {

  var message;
  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.addOffer);


  Future<bool> addOffers(AddOffers addOffers) async {

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "new_price" : "${addOffers.newPrice}",
        "description" : "${addOffers.description}",
        "expirate_date" : "${addOffers.expirateDate}",
        "meale_ids" : "${addOffers.mealeIds}",
      },
    );

    print(response.statusCode);
    print(response.body);


    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse["message"];
      return true;
    } else if (response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse["message"];
      return false;
    } else {
      message = 'Server Error';
      return false;
    }
  }
}
