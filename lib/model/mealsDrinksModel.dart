class MealsDrinks {
  int id;
  String name;
  String description;
  String image;
  int categoryId;
  int? rustaurantId;
  int price;
  int? menu;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? rate;
  int? numberUserRate;

  MealsDrinks({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
    this.rustaurantId,
    required this.price,
    this.menu,
    this.createdAt,
    this.updatedAt,
    this.rate,
    this.numberUserRate,
  });

  factory MealsDrinks.fromJson(Map<String, dynamic> json) => MealsDrinks(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    categoryId: json["category_id"],
    rustaurantId: json["rustaurant_id"],
    price: json["price"],
    menu: json["menu"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    rate: json["rate"],
    numberUserRate: json["numberUserRate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "category_id": categoryId,
    "price": price,
  };
}