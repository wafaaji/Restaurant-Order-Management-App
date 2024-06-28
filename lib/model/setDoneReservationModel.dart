import 'dart:convert';

import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/reservationModel.dart';

SetReservation setReservationFromJson(String str) => SetReservation.fromJson(json.decode(str));

String setReservationToJson(SetReservation data) => json.encode(data.toJson());

class SetReservation {
  int? id;
  String? message;
  Reservation? data;

  SetReservation({
    this.id,
    this.message,
    this.data,
  });

  factory SetReservation.fromJson(Map<String, dynamic> json) => SetReservation(
    message: json["message"],
    data: Reservation.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "reversation_id": id,
  };
}
