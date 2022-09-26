// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

List<FeedModel> feedModelFromJson(List<dynamic> str) => List<FeedModel>.from(str.map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class FeedModel {
  FeedModel({
    this.id,
    this.name,
    this.description,
    this.content,
    this.status,
    this.authorId,
    this.isFeatured,
    this.image,
    this.views,
    this.formatType,
    this.createdAt,
    this.updatedAt,
    this.typeId,
    this.category,
  });

  int? id;
  String? name;
  dynamic description;
  String? content;
  String? status;
  int? authorId;
  int? isFeatured;
  dynamic image;
  int? views;
  dynamic? formatType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? typeId;
  List<Category>? category;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    content: json["content"],
    status: json["status"],
    authorId: json["author_id"],
    isFeatured: json["is_featured"],
    image: json["image"],
    views: json["views"],
    formatType: json["format_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    typeId: json["type_id"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "content": content,
    "status": status,
    "author_id": authorId,
    "is_featured": isFeatured,
    "image": image,
    "views": views,
    "format_type": formatType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "type_id": typeId,
    "category":category!=null? List<dynamic>.from(category!.map((x) => x.toJson())): null,
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.parentId,
    this.description,
    this.status,
    this.authorId,
    this.authorType,
    this.icon,
    this.order,
    this.isFeatured,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? parentId;
  String? description;
  String? status;
  int? authorId;
  String? authorType;
  dynamic icon;
  int? order;
  int? isFeatured;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    description: json["description"],
    status: json["status"],
    authorId: json["author_id"],
    authorType: json["author_type"],
    icon: json["icon"],
    order: json["order"],
    isFeatured: json["is_featured"],
    isDefault: json["is_default"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "description": description,
    "status": status,
    "author_id": authorId,
    "author_type": authorType,
    "icon": icon,
    "order": order,
    "is_featured": isFeatured,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
