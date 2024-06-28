class Reservation {
  int id;
  int status;
  int done;
  int restaurantId;
  int userId;
  int tabelId;
  dynamic createdAt;
  DateTime? updatedAt;

  Reservation({
    required this.id,
    required this.status,
    required this.done,
    required this.restaurantId,
    required this.userId,
    required this.tabelId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    id: json["id"],
    status: json["status"],
    done: json["done"],
    restaurantId: json["restaurant_id"],
    userId: json["user_id"],
    tabelId: json["tabel_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "done": done,
    "restaurant_id": restaurantId,
    "user_id": userId,
    "tabel_id": tabelId,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}