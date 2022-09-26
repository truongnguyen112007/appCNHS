// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  Data({
    this.meta,
    this.data,
  });

  Meta? meta;
  List<Datum>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class Datum {
  Datum({
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
    this.author,
    this.post,
  });

  int? id;
  String? name;
  int? parentId;
  String? description;
  String? status;
  int? authorId;
  String? authorType;
  dynamic? icon;
  int? order;
  int? isFeatured;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  Author? author;
  List<Post>? post;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        author: Author.fromJson(json["author"]),
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
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
        "author": author?.toJson(),
        "post": post!=null? List<dynamic>.from(post!.map((x) => x.toJson())): null,
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
  dynamic? phone;

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

class Post {
  Post({
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

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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
      };
}

class Meta {
  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  dynamic? nextPageUrl;
  dynamic? previousPageUrl;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        firstPage: json["first_page"],
        firstPageUrl: json["first_page_url"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        previousPageUrl: json["previous_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "first_page": firstPage,
        "first_page_url": firstPageUrl,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "previous_page_url": previousPageUrl,
      };
}
