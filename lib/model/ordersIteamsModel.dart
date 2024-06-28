import 'package:employee/model/mealsDrinksModel.dart';

class OrderItem {
  MealsDrinks meal;

  OrderItem({
    required this.meal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    meal: MealsDrinks.fromJson(json["meal"]),
  );

  Map<String, dynamic> toJson() => {
    "meal": meal.toJson(),
  };
}
