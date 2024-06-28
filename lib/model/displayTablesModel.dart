import 'dart:convert';
import 'package:employee/model/tablesModel.dart';

DisplayTables displayTablesFromJson(String str) => DisplayTables.fromJson(json.decode(str));

String displayTablesToJson(DisplayTables data) => json.encode(data.toJson());

class DisplayTables {
  String message;
  List<Tables> data;

  DisplayTables({
    required this.message,
    required this.data,
  });

  factory DisplayTables.fromJson(Map<String, dynamic> json) => DisplayTables(
    message: json["message"],
    data: List<Tables>.from(json["data"].map((x) => Tables.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
