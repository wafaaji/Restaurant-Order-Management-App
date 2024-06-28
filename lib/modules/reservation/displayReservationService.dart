import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/displayCategoryModel.dart';
import 'package:employee/model/displayOrdersModel.dart';
import 'package:employee/model/displayReservationModel.dart';
import 'package:employee/model/ordersIteamsModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/reservationModel.dart';
import 'package:http/http.dart' as http;

class DisplayReservationService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayReservation);

  Future<List<Reservation>> displayReservation(var token) async{
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
        var reservation = displayReservationFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var reservationsList = jsonResponse["data"];
        print("-----------------display reservation----------------");
        print(reservationsList);

        // Convert orderList to a List<Orders>
        List<Reservation> reservationList = List<Reservation>.from(reservationsList.map((item) => Reservation.fromJson(item)));

        return reservationList;
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