import 'dart:convert';
import 'package:employee/model/mealsDrinksModel.dart';

DisplayMenuMealsDrinks displayMenuMealsDrinksFromJson(String str) => DisplayMenuMealsDrinks.fromJson(json.decode(str));

String displayMenuMealsDrinksToJson(DisplayMenuMealsDrinks data) => json.encode(data.toJson());

class DisplayMenuMealsDrinks {
  String message;
  List<MealsDrinks> data;

  DisplayMenuMealsDrinks({
    required this.message,
    required this.data,
  });

  factory DisplayMenuMealsDrinks.fromJson(Map<String, dynamic> json) => DisplayMenuMealsDrinks(
    message: json["message"],
    data: List<MealsDrinks>.from(json["data"].map((x) => MealsDrinks.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
