// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
    this.isMissingUserInfo,
    this.message,
  });

  Data? data;
  bool? isMissingUserInfo;
  String? message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        isMissingUserInfo: json["isMissingUserInfo"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "isMissingUserInfo": isMissingUserInfo,
        "message": message,
      };
}

class Data {
  Data({
    this.userData,
    this.token,
  });

  UserData? userData;
  Token? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["userData"]),
        token: Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData?.toJson(),
        "token": token?.toJson(),
      };

  Data copyOf({UserData? userData, Token? userToken}) =>
      Data(userData: userData ?? this.userData, token: userToken ?? token);
}

class Token {
  Token({
    this.type,
    this.token,
  });

  String? type;
  String? token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        type: json["type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
      };
}

class UserData {
  UserData({
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
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic firstName;
  dynamic lastName;
  int? superUser;
  int? manageSupers;
  dynamic permissions;
  dynamic lastLogin;
  String? phone;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        lastLogin: json["last_login"],
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
        "last_login": lastLogin,
        "phone": phone,
      };
}
