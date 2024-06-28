import 'dart:convert';

import 'package:employee/model/offersModel.dart';

AddOffers addOffersFromJson(String str) => AddOffers.fromJson(json.decode(str));

String addOffersToJson(AddOffers data) => json.encode(data.toJson());

class AddOffers {
  String? message;
  Offers? data;
  String newPrice;
  String description;
  DateTime expirateDate;
  List<String> mealeIds;

  AddOffers({
    this.message,
    this.data,
    required this.newPrice,
    required this.description,
    required this.expirateDate,
    required this.mealeIds,
  });

  factory AddOffers.fromJson(Map<String, dynamic> json) => AddOffers(
    message: json["message"],
    data: Offers.fromJson(json["data"]),
    newPrice: json["new_price"],
    description: json["description"],
    expirateDate: json["expirate_date"],
    mealeIds: json["meale_ids"],
  );

  Map<String, dynamic> toJson() => {
    "new_price": newPrice,
    "description": description,
    "expirate_date": expirateDate,
    "meale_ids": List<dynamic>.from(mealeIds!.map((x) => x)),
  };
}

