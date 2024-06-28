import 'dart:convert';

import 'package:employee/model/ordersModel.dart';

AcceptRejectOrder acceptRejectOrderFromJson(String str) => AcceptRejectOrder.fromJson(json.decode(str));

String acceptRejectOrderToJson(AcceptRejectOrder data) => json.encode(data.toJson());

class AcceptRejectOrder {
  int? id;
  int? status;
  String? message;
  Orders? data;

  AcceptRejectOrder({
    this.id,
    this.status,
    this.message,
    this.data,
  });

  factory AcceptRejectOrder.fromJson(Map<String, dynamic> json) => AcceptRejectOrder(
    message: json["message"],
    data: Orders.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": id,
    "status": status,
  };
}
