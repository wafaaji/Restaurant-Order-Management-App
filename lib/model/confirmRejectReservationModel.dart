import 'dart:convert';

import 'package:employee/model/ordersModel.dart';
import 'package:employee/model/reservationModel.dart';

ConfirmRejectReservation confirmRejectReservationFromJson(String str) => ConfirmRejectReservation.fromJson(json.decode(str));

String confirmRejectReservationToJson(ConfirmRejectReservation data) => json.encode(data.toJson());

class ConfirmRejectReservation {
  int? id;
  int? status;
  String? message;
  Reservation? data;

  ConfirmRejectReservation({
    this.id,
    this.status,
    this.message,
    this.data,
  });

  factory ConfirmRejectReservation.fromJson(Map<String, dynamic> json) => ConfirmRejectReservation(
    message: json["message"],
    data: Reservation.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "reversation_id": id,
    "status": status,
  };
}
