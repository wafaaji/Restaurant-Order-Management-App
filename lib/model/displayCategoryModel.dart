import 'dart:convert';
import 'package:employee/model/categoryModel.dart';

DisplayCategory displayCategoryFromJson(String str) => DisplayCategory.fromJson(json.decode(str));

String displayCategoryToJson(DisplayCategory data) => json.encode(data.toJson());

class DisplayCategory {
  String message;
  List<Category> data;

  DisplayCategory({
    required this.message,
    required this.data,
  });

  factory DisplayCategory.fromJson(Map<String, dynamic> json) => DisplayCategory(
    message: json["message"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

