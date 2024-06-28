import 'dart:convert';

Login LoginFromJson(String str) => Login.fromJson(json.decode(str));

String LoginToJson(Login data) => json.encode(data.toJson());

class Login {
  String? email;
  String? password;
  String? message;
  Data? data;
  String? role;
  String? token;

  Login({
    this.email,
    this.password,
    this.message,
    this.data,
    this.role,
    this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["message"] ?? '',
    data: Data.fromJson(json["data"] ?? {}),
    role: json["Role"] ?? '',
    token: json["token"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

class Data {
  int id;
  String name;
  String email;
  int phone;
  dynamic emailVerifiedAt;
  String location;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    location: json["location"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "location": location,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
