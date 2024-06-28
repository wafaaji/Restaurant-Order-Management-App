import 'dart:convert';

import 'package:employee/model/categoryModel.dart';

AddCategory AddCategoryFromJson(String str) => AddCategory.fromJson(json.decode(str));

String AddCategoryToJson(AddCategory data) => json.encode(data.toJson());

class AddCategory {
  String? name;
  String? type;
  String? message;
  Category? data;

  AddCategory({
    this.name,
    this.type,
    this.message,
    this.data,
  });

  factory AddCategory.fromJson(Map<String, dynamic> json) => AddCategory(
    message: json["message"] ?? '',
    data: Category.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
  };
}

