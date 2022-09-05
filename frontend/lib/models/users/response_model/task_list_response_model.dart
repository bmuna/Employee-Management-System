import 'dart:convert';

TaskListResponseModel taskListResponseModelFromJson(String str) =>
    TaskListResponseModel.fromJson(json.decode(str));

String taskListResponseModelToJson(TaskListResponseModel data) =>
    json.encode(data.toJson());

class TaskListResponseModel {
  TaskListResponseModel({
    required this.results,
  });

  List<Result> results;

  factory TaskListResponseModel.fromJson(Map<String, dynamic> json) =>
      TaskListResponseModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.task,
  });

  String task;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        task: json["task"],
      );

  Map<String, dynamic> toJson() => {
        "task": task,
      };
}
