import 'dart:convert';

import 'package:employee/model/offersModel.dart';

SetUnActiveOffer setUnActiveOfferFromJson(String str) => SetUnActiveOffer.fromJson(json.decode(str));

String SetUnActiveOfferToJson(SetUnActiveOffer data) => json.encode(data.toJson());

class SetUnActiveOffer {
  String? message;
  Offers? data;
  int id;

  SetUnActiveOffer({
    this.message,
    this.data,
    required this.id,
  });

  factory SetUnActiveOffer.fromJson(Map<String, dynamic> json) => SetUnActiveOffer(
    message: json["message"],
    data: Offers.fromJson(json["data"]),
    id: json["offer_id"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": id,
  };
}

