import 'dart:convert';

ListOfRolesModel listOfRolesModelFromJson(String str) =>
    ListOfRolesModel.fromJson(json.decode(str));

String listOfRolesModelToJson(ListOfRolesModel data) =>
    json.encode(data.toJson());

class ListOfRolesModel {
  ListOfRolesModel({
    required this.result,
  });

  List<Result> result;

  factory ListOfRolesModel.fromJson(Map<String, dynamic> json) =>
      ListOfRolesModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.role,
  });

  int id;
  String role;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
      };
}
