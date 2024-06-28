import 'dart:convert';

import 'package:employee/model/mealsDrinksModel.dart';

EditMainMeal editMainMealFromJson(String str) => EditMainMeal.fromJson(json.decode(str));

String editMainMealToJson(EditMainMeal data) => json.encode(data.toJson());

class EditMainMeal {
  int? meal_id;
  String? name;
  String? description;
  String? image;
  int? categoryId;
  String? price;
  MealsDrinks? data;

  EditMainMeal({
    this.meal_id,
    this.name,
    this.description,
    this.image,
    this.categoryId,
    this.price,
    this.data,
  });

  factory EditMainMeal.fromJson(Map<String, dynamic> json) => EditMainMeal(
    data: MealsDrinks.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "meal_id": meal_id,
    "name": name,
    "description": description,
    "image": image,
    "category_id": categoryId,
    "price": price,
  };
}
