import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displayOffersModel.dart';
import 'package:employee/model/displayOrdersModel.dart';
import 'package:employee/model/offersModel.dart';
import 'package:http/http.dart' as http;

class DisplayUnActiveOffersService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayUnActiveOffers);

  Future<List<Offers>> displayUnActiveOffers(var token) async{
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
        var offers = displayOffersFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var offersList = jsonResponse["data"];
        print("-----------------display offer----------------");
        print(offersList);

        List<Offers> offerList = List<Offers>.from(offersList.map((item) => Offers.fromJson(item)));

        return offerList;
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