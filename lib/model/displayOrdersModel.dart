import 'dart:convert';

import 'package:employee/model/ordersModel.dart';

DisplayOrders displayOrdersFromJson(String str) => DisplayOrders.fromJson(json.decode(str));

String displayOrdersToJson(DisplayOrders data) => json.encode(data.toJson());

class DisplayOrders {
  String message;
  List<Orders> data;

  DisplayOrders({
    required this.message,
    required this.data,
  });

  factory DisplayOrders.fromJson(Map<String, dynamic> json) => DisplayOrders(
    message: json["message"],
    data: List<Orders>.from(json["data"].map((x) => Orders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
