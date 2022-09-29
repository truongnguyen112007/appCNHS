import 'dart:convert';

List<PostDetailModel> postModelFromJson(List<dynamic> str) =>
    List<PostDetailModel>.from(str.map((x) => PostDetailModel.fromJson(x)));

String postModelToJson(List<PostDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostDetailModel {
  List<Data>? data;
  bool? success;
  String? message;

  PostDetailModel({this.data, this.success, this.message});

  PostDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  Null? description;
  String? content;
  String? status;
  int? authorId;
  int? isFeatured;
  Null? image;
  int? views;
  Null? formatType;
  String? createdAt;
  String? updatedAt;
  int? typeId;
  Author? author;
  // List<Null>? tag;
  List<Category>? category;
  Null? type;

  Data(
      {this.id,
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
        this.author,
        // this.tag,
        this.category,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    content = json['content'];
    status = json['status'];
    authorId = json['author_id'];
    isFeatured = json['is_featured'];
    image = json['image'];
    views = json['views'];
    formatType = json['format_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    /*if (json['tag'] != null) {
      tag = <Null>[];
      json['tag'].forEach((v) {
        tag!.add(new Null.fromJson(v));
      });
    }*/
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content;
    data['status'] = this.status;
    data['author_id'] = this.authorId;
    data['is_featured'] = this.isFeatured;
    data['image'] = this.image;
    data['views'] = this.views;
    data['format_type'] = this.formatType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    /*if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v!.toJson()).toList();
    }*/
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Author {
  int? id;
  String? email;
  Null? emailVerifiedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  int? superUser;
  int? manageSupers;
  String? permissions;
  String? lastLogin;
  Null? phone;

  Author(
      {this.id,
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
        this.phone});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    superUser = json['super_user'];
    manageSupers = json['manage_supers'];
    permissions = json['permissions'];
    lastLogin = json['last_login'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['super_user'] = this.superUser;
    data['manage_supers'] = this.manageSupers;
    data['permissions'] = this.permissions;
    data['last_login'] = this.lastLogin;
    data['phone'] = this.phone;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? parentId;
  String? description;
  String? status;
  int? authorId;
  String? authorType;
  Null? icon;
  int? order;
  int? isFeatured;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
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
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    status = json['status'];
    authorId = json['author_id'];
    authorType = json['author_type'];
    icon = json['icon'];
    order = json['order'];
    isFeatured = json['is_featured'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['author_id'] = this.authorId;
    data['author_type'] = this.authorType;
    data['icon'] = this.icon;
    data['order'] = this.order;
    data['is_featured'] = this.isFeatured;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}