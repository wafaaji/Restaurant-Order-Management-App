// To parse this JSON data, do
//
//     final restoreRemovedMealDrink = restoreRemovedMealDrinkFromJson(jsonString);

import 'dart:convert';

import 'package:employee/model/mealsDrinksModel.dart';

RestoreRemovedMealDrink restoreRemovedMealDrinkFromJson(String str) => RestoreRemovedMealDrink.fromJson(json.decode(str));

String restoreRemovedMealDrinkToJson(RestoreRemovedMealDrink data) => json.encode(data.toJson());

class RestoreRemovedMealDrink {
  int? id;
  String? message;
  MealsDrinks? data;

  RestoreRemovedMealDrink({
    this.id,
    this.message,
    this.data,
  });

  factory RestoreRemovedMealDrink.fromJson(Map<String, dynamic> json) => RestoreRemovedMealDrink(
    message: json["message"],
    data: MealsDrinks.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "meal-id": id,
  };
}

