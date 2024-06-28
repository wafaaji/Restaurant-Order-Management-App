import 'dart:convert';

import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/reservationModel.dart';

AcceptRejectReservation acceptRejectReservationFromJson(String str) => AcceptRejectReservation.fromJson(json.decode(str));

String acceptRejectReservationToJson(AcceptRejectReservation data) => json.encode(data.toJson());

class AcceptRejectReservation {
  int? id;
  int? status;
  String? message;
  Reservation? data;

  AcceptRejectReservation({
    this.id,
    this.status,
    this.message,
    this.data,
  });

  factory AcceptRejectReservation.fromJson(Map<String, dynamic> json) => AcceptRejectReservation(
    message: json["message"],
    data: Reservation.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "reversation_id": id,
    "status": status,
  };
}
