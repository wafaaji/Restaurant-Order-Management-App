import 'dart:convert';

DeleteMainMealDrink deleteMainMealDrinkFromJson(String str) => DeleteMainMealDrink.fromJson(json.decode(str));

String deleteMainMealDrinkToJson(DeleteMainMealDrink data) => json.encode(data.toJson());

class DeleteMainMealDrink {
  int? id;
  String? message;

  DeleteMainMealDrink({
    this.id,
    this.message,
  });

  factory DeleteMainMealDrink.fromJson(Map<String, dynamic> json) => DeleteMainMealDrink(
    message: json["message"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "meal_id" : id,
  };
}

