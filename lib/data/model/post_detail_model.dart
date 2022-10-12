// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'dart:convert';

PostDetailModel postDetailModelFromJson(String str) =>
    PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) =>
    json.encode(data.toJson());

class PostDetailModel {
  PostDetailModel({
    this.data,
    this.success,
    this.message,
  });

  List<Datum>? data;
  bool? success;
  String? message;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
        "success": success,
        "message": message,
      };
}

class Datum {
  Datum({
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
    this.nextId,
    this.prevId,
    this.author,
    this.category,
    this.tag,
    this.type,
  });

  int? id;
  String? name;
  dynamic? description;
  String? content;
  String? status;
  int? authorId;
  int? isFeatured;
  dynamic? image;
  int? views;
  dynamic? formatType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? typeId;
  int? nextId;
  int? prevId;
  Author? author;
  List<Category>? category;
  List<dynamic>? tag;
  Type? type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        nextId: json["next_id"],
        prevId: json["prev_id"],
        author: Author.fromJson(json["author"]),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        tag: List<dynamic>.from(json["tag"].map((x) => x)),
        type: json["type"] != null ? Type.fromJson(json["type"]) : null,
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
        "author": author?.toJson(),
        "category": category != null
            ? List<dynamic>.from(category!.map((x) => x.toJson()))
            : null,
        "tag":tag!=null? List<dynamic>.from(tag!.map((x) => x)): null,
        "type": type?.toJson(),
      };
}

class Author {
  Author({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.superUser,
    this.manageSupers,
    this.permissions,
    this.lastLogin,
    this.phone,
  });

  int? id;
  String? email;
  dynamic emailVerifiedAt;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstName;
  String? lastName;
  int? superUser;
  int? manageSupers;
  String? permissions;
  DateTime? lastLogin;
  dynamic phone;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        superUser: json["super_user"],
        manageSupers: json["manage_supers"],
        permissions: json["permissions"],
        lastLogin: DateTime.parse(json["last_login"]),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "remember_token": rememberToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "super_user": superUser,
        "manage_supers": manageSupers,
        "permissions": permissions,
        "last_login": lastLogin?.toIso8601String(),
        "phone": phone,
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

class Type {
  Type({
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
  dynamic description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? authorId;
  String? authorType;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
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
