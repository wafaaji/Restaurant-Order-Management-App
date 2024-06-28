import 'dart:convert';

import 'package:employee/model/tablesModel.dart';

OpenCloseTable openCloseTableFromJson(String str) => OpenCloseTable.fromJson(json.decode(str));

String openCloseTableToJson(OpenCloseTable data) => json.encode(data.toJson());

class OpenCloseTable {
  int? id;
  int? status;
  String? message;
  Tables? data;

  OpenCloseTable({
    this.id,
    this.status,
    this.message,
    this.data,
  });

  factory OpenCloseTable.fromJson(Map<String, dynamic> json) => OpenCloseTable(
    message: json["message"],
    data: Tables.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "table_id": id,
    "status": status,
  };
}
