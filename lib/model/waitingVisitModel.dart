// To parse this JSON data, do
//
//     final waitingVisitModel = waitingVisitModelFromJson(jsonString);

import 'dart:convert';

WaitingVisitModel waitingVisitModelFromJson(String str) => WaitingVisitModel.fromJson(json.decode(str));

String waitingVisitModelToJson(WaitingVisitModel data) => json.encode(data.toJson());

class WaitingVisitModel {
  String message;
  List<Datum> data;

  WaitingVisitModel({
    required this.message,
    required this.data,
  });

  factory WaitingVisitModel.fromJson(Map<String, dynamic> json) => WaitingVisitModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int status;
  int done;
  int restaurantId;
  int userId;
  int tabelId;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    required this.id,
    required this.status,
    required this.done,
    required this.restaurantId,
    required this.userId,
    required this.tabelId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    status: json["status"],
    done: json["done"],
    restaurantId: json["restaurant_id"],
    userId: json["user_id"],
    tabelId: json["tabel_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "done": done,
    "restaurant_id": restaurantId,
    "user_id": userId,
    "tabel_id": tabelId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
