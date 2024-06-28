import 'dart:convert';

import 'package:employee/model/mealsDrinksModel.dart';

DisplayMainMealsDrinks displayMainMealsDrinksFromJson(String str) => DisplayMainMealsDrinks.fromJson(json.decode(str));

String displayMainMealsDrinksToJson(DisplayMainMealsDrinks data) => json.encode(data.toJson());

class DisplayMainMealsDrinks {
  String message;
  List<MealsDrinks> data;

  DisplayMainMealsDrinks({
    required this.message,
    required this.data,
  });

  factory DisplayMainMealsDrinks.fromJson(Map<String, dynamic> json) => DisplayMainMealsDrinks(
    message: json["message"],
    data: List<MealsDrinks>.from(json["data"].map((x) => MealsDrinks.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
