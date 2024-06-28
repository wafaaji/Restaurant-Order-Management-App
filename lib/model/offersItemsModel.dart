import 'package:employee/model/mealsDrinksModel.dart';

class OffersItem {
  MealsDrinks meal;

  OffersItem({
    required this.meal,
  });

  factory OffersItem.fromJson(Map<String, dynamic> json) => OffersItem(
    meal: MealsDrinks.fromJson(json["meal"]),
  );

  Map<String, dynamic> toJson() => {
    "meal": meal.toJson(),
  };
}