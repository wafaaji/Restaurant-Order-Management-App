import 'dart:convert';
import 'package:employee/model/mealsDrinksModel.dart';

AddMainMealDrink addMainMealDrinkFromJson(String str) => AddMainMealDrink.fromJson(json.decode(str));

String addMainMealDrinkToJson(AddMainMealDrink data) => json.encode(data.toJson());

class AddMainMealDrink {
  String? name;
  String? description;
  String? image;
  String? price;
  int? categoryId;
  MealsDrinks? data;

  AddMainMealDrink({
    this.name,
    this.description,
    this.image,
    this.price,
    this.categoryId,
    this.data,
  });

  factory AddMainMealDrink.fromJson(Map<String, dynamic> json) => AddMainMealDrink(
    data: MealsDrinks.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "image": image,
    "category_id": categoryId,
    "price": price,
  };
}
