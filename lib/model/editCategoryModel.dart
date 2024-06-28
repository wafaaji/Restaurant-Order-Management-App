import 'dart:convert';

import 'package:employee/model/categoryModel.dart';

EditCategory EditCategoryFromJson(String str) => EditCategory.fromJson(json.decode(str));

String EditCategoryToJson(EditCategory data) => json.encode(data.toJson());

class EditCategory {
  int? id;
  String? name;
  String? type;
  String? message;
  Category? data;

  EditCategory({
    this.id,
    this.name,
    this.type,
    this.message,
    this.data
  });

  factory EditCategory.fromJson(Map<String, dynamic> json) => EditCategory(
    message: json["message"] ?? '',
    data: Category.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "category_id" : id,
    "name": name,
    "type": type,
  };
}

