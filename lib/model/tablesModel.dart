class Tables {
  int id;
  int? rustaurantId;
  int tableNumber;
  int floorNumber;
  int chairsNumber;
  int? state;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tables({
    required this.id,
    this.rustaurantId,
    required this.tableNumber,
    required this.floorNumber,
    required this.chairsNumber,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  factory Tables.fromJson(Map<String, dynamic> json) => Tables(
    id: json["id"],
    rustaurantId: json["rustaurant_id"],
    tableNumber: json["table_number"],
    floorNumber: json["floor_number"],
    chairsNumber: json["chairs_number"],
    state: json["state"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rustaurant_id": rustaurantId,
    "table_number": tableNumber,
    "floor_number": floorNumber,
    "chairs_number": chairsNumber,
    "state": state,
  };
}