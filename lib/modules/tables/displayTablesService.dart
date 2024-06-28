import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/displayReservationModel.dart';
import 'package:employee/model/displayTablesModel.dart';
import 'package:employee/model/reservationModel.dart';
import 'package:employee/model/tablesModel.dart';
import 'package:http/http.dart' as http;

class DisplayTablesService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.displayTables);

  Future<List<Tables>> displayTables(var token) async{
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
        var table = displayTablesFromJson(response.body);
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse["message"];
        var tablesList = jsonResponse["data"];
        print("-----------------display tables----------------");
        print(tablesList);

        List<Tables> tableList = List<Tables>.from(tablesList.map((item) => Tables.fromJson(item)));

        return tableList;
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