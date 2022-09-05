import 'dart:convert';

UsersWithRoleModel usersWithRoleModelFromJson(String str) =>
    UsersWithRoleModel.fromJson(json.decode(str));

String usersWithRoleModelToJson(UsersWithRoleModel data) =>
    json.encode(data.toJson());

class UsersWithRoleModel {
  UsersWithRoleModel({
    required this.result,
  });

  List<Result> result;

  factory UsersWithRoleModel.fromJson(Map<String, dynamic> json) =>
      UsersWithRoleModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  int roleId;
  String fullName;
  String email;
  String phoneNumber;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;
  String role;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        roleId: json["role_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "user_type": userType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "role": role,
      };
}
