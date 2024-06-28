import 'dart:convert';

import 'package:employee/model/categoryModel.dart';

DeleteCategory DeleteCategoryFromJson(String str) => DeleteCategory.fromJson(json.decode(str));

String DeleteCategoryToJson(DeleteCategory data) => json.encode(data.toJson());

class DeleteCategory {
  int? id;
  String? message;

  DeleteCategory({
    this.id,
    this.message,
  });

  factory DeleteCategory.fromJson(Map<String, dynamic> json) => DeleteCategory(
    message: json["message"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "category_id" : id,
  };
}

