class EmployeeAddRequestModel {
  EmployeeAddRequestModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.roleId,
  });
  late final String? fullName;
  late final String? email;
  late final String? phoneNumber;
  late final int? roleId;

  EmployeeAddRequestModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['full_name'] = fullName;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['role_id'] = roleId;

    return _data;
  }
}
