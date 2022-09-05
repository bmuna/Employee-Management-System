import 'dart:convert';

UsersResponseModel usersResponseModelFromJson(String str) =>
    UsersResponseModel.fromJson(json.decode(str));

String usersResponseModelToJson(UsersResponseModel data) =>
    json.encode(data.toJson());

class UsersResponseModel {
  UsersResponseModel({
    required this.users,
  });

  List<User> users;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      UsersResponseModel(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int roleId;
  String fullName;
  String email;
  String phoneNumber;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleId": roleId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "user_type": userType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
