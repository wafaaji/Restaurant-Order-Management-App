// To parse this JSON data, do
//
//     final displayRemovedMealsDrinks = displayRemovedMealsDrinksFromJson(jsonString);

import 'dart:convert';

import 'package:employee/model/mealsDrinksModel.dart';

DisplayRemovedMealsDrinks displayRemovedMealsDrinksFromJson(String str) => DisplayRemovedMealsDrinks.fromJson(json.decode(str));

String displayRemovedMealsDrinksToJson(DisplayRemovedMealsDrinks data) => json.encode(data.toJson());

class DisplayRemovedMealsDrinks {
  String message;
  List<MealsDrinks> data;

  DisplayRemovedMealsDrinks({
    required this.message,
    required this.data,
  });

  factory DisplayRemovedMealsDrinks.fromJson(Map<String, dynamic> json) => DisplayRemovedMealsDrinks(
    message: json["message"],
    data: List<MealsDrinks>.from(json["data"].map((x) => MealsDrinks.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
