class TaskRequestModel {
  TaskRequestModel({
    this.task,
    this.roleId,
  });
  late final String? task;
  late final int? roleId;

  TaskRequestModel.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task'] = task;
    _data['role_id'] = roleId;
    return _data;
  }
}

class TaskRequestHolderModel {
  TaskRequestHolderModel({
    this.tasks,
  });

  late final List? tasks;

  TaskRequestHolderModel.fromJson(Map<String, dynamic> json) {
    tasks = json['tasks'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tasks'] = tasks;
    return _data;
  }
}
