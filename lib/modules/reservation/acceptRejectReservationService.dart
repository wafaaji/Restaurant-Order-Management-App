import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/acceptRejectOrderModel.dart';
import 'package:employee/model/acceptRejectReservationModel.dart';
import 'package:employee/model/deleteMainMealDrinkModel.dart';
import 'package:employee/model/deleteMenuMealDrink.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class AcceptRejectReservationService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.acceptRejectReservation);

  Future<bool> acceptRejectReservation(AcceptRejectReservation acceptRejectReservation) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "reversation_id" : "${acceptRejectReservation.id}",
        "status" : "${acceptRejectReservation.status}",
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