import 'package:employee/model/offersItemsModel.dart';

class Offers {
  int id;
  String description;
  dynamic image;
  int? rustaurantId;
  int newPrice;
  int oldPrice;
  int state;
  DateTime expirateDate;
  dynamic createdAt;
  dynamic updatedAt;
  List<OffersItem> offerItem;

  Offers({
    required this.id,
    required this.description,
    this.image,
    this.rustaurantId,
    required this.newPrice,
    required this.oldPrice,
    required this.state,
    required this.expirateDate,
    this.createdAt,
    this.updatedAt,
    required this.offerItem,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
    id: json["id"],
    description: json["description"],
    image: json["image"],
    rustaurantId: json["rustaurant_id"],
    newPrice: json["new_price"],
    oldPrice: json["old_price"],
    state: json["state"],
    expirateDate: DateTime.parse(json["expirate_date"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    offerItem: List<OffersItem>.from(json["offer_item"].map((x) => OffersItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "image": image,
    "rustaurant_id": rustaurantId,
    "new_price": newPrice,
    "old_price": oldPrice,
    "state": state,
    "expirate_date": "${expirateDate.year.toString().padLeft(4, '0')}-${expirateDate.month.toString().padLeft(2, '0')}-${expirateDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt,
    "updated_at": updatedAt,
    "offer_item": List<dynamic>.from(offerItem.map((x) => x.toJson())),
  };
}