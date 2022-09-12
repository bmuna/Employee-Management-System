import 'dart:convert';

AdminLoginResponseModel adminLoginResponseModelFromJson(String str) =>
    AdminLoginResponseModel.fromJson(json.decode(str));

String adminLoginResponseModelToJson(AdminLoginResponseModel data) =>
    json.encode(data.toJson());

class AdminLoginResponseModel {
  AdminLoginResponseModel({
    required this.code,
    required this.message,
    required this.token,
    required this.users,
  });

  int code;
  String message;
  String token;
  List<User> users;

  factory AdminLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      AdminLoginResponseModel(
        code: json["code"],
        message: json["message"],
        token: json["token"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "token": token,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic roleId;
  dynamic fullName;
  String email;
  String password;
  dynamic phoneNumber;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        fullName: json["full_name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "full_name": fullName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "user_type": userType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
