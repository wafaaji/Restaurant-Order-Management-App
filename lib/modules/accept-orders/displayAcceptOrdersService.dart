import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displayOrdersModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:http/http.dart' as http;

class DisplayAcceptOrdersService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayAcceptOrders);

  Future<List<Orders>> displayOrders(var token) async{
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
        var order = displayOrdersFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        var orderList = jsonResponse["data"];
        print("-----------------display order----------------");
        print(orderList);

        // Convert orderList to a List<Orders>
        List<Orders> ordersList = List<Orders>.from(orderList.map((item) => Orders.fromJson(item)));

        return ordersList;
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