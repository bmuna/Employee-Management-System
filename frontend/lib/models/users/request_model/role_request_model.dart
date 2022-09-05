class RoleRequestModel {
  RoleRequestModel({
    this.role,
  });
  late final String? role;

  RoleRequestModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['role'] = role;
    return _data;
  }
}
