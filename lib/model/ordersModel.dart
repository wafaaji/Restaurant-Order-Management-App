import 'dart:convert';

import 'package:employee/model/ordersIteamsModel.dart';

class Orders {
  int id;
  int userId;
  int rustaurantId;
  String additionalDetails;
  int state;
  dynamic createdAt;
  dynamic updatedAt;
  int totalPrice;
  List<OrderItem> orderItem;
  List<dynamic> orderOffer;

  Orders({
    required this.id,
    required this.userId,
    required this.rustaurantId,
    required this.additionalDetails,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
    required this.orderItem,
    required this.orderOffer,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    id: json["id"],
    userId: json["user_id"],
    rustaurantId: json["rustaurant_id"],
    additionalDetails: json["additional_details"],
    state: json["state"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalPrice: json["total_price"],
    orderItem: List<OrderItem>.from(json["order_item"].map((x) => OrderItem.fromJson(x))),
    orderOffer: List<dynamic>.from(json["order_offer"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "rustaurant_id": rustaurantId,
    "additional_details": additionalDetails,
    "state": state,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "total_price": totalPrice,
    "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
    "order_offer": List<dynamic>.from(orderOffer.map((x) => x)),
  };
}