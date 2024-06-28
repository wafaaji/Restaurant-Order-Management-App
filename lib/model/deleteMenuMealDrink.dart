import 'dart:convert';

import 'package:employee/model/mealsDrinksModel.dart';

DeleteMenuMealDrink deleteMenuMealDrinkFromJson(String str) => DeleteMenuMealDrink.fromJson(json.decode(str));

String deleteMenuMealDrinkToJson(DeleteMenuMealDrink data) => json.encode(data.toJson());

class DeleteMenuMealDrink {
  int? id;
  String? message;
  MealsDrinks? data;

  DeleteMenuMealDrink({
    this.id,
    this.message,
    this.data,
  });

  factory DeleteMenuMealDrink.fromJson(Map<String, dynamic> json) => DeleteMenuMealDrink(
    message: json["message"],
    data: MealsDrinks.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "meal-id" : id,
  };
}
