import 'dart:convert';
import 'package:employee/model/offersModel.dart';

DisplayOffers displayOffersFromJson(String str) => DisplayOffers.fromJson(json.decode(str));

String displayOffersToJson(DisplayOffers data) => json.encode(data.toJson());

class DisplayOffers {
  String message;
  List<Offers> data;

  DisplayOffers({
    required this.message,
    required this.data,
  });

  factory DisplayOffers.fromJson(Map<String, dynamic> json) => DisplayOffers(
    message: json["message"],
    data: List<Offers>.from(json["data"].map((x) => Offers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
