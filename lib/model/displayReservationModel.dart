import 'dart:convert';

import 'package:employee/model/reservationModel.dart';

DisplayReservation displayReservationFromJson(String str) => DisplayReservation.fromJson(json.decode(str));

String displayReservationToJson(DisplayReservation data) => json.encode(data.toJson());

class DisplayReservation {
  String message;
  List<Reservation> data;

  DisplayReservation({
    required this.message,
    required this.data,
  });

  factory DisplayReservation.fromJson(Map<String, dynamic> json) => DisplayReservation(
    message: json["message"],
    data: List<Reservation>.from(json["data"].map((x) => Reservation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

