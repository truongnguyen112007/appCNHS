// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.data,
    this.success,
    this.message,
  });

  List<Datum>? data;
  bool? success;
  String? message;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.authorId,
    this.authorType,
  });

  int? id;
  String? name;
  dynamic? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? authorId;
  String? authorType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    authorId: json["author_id"],
    authorType: json["author_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "author_id": authorId,
    "author_type": authorType,
  };
}
