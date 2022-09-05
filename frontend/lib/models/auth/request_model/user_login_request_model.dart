class UserLoginRequestModel {
  UserLoginRequestModel({
    required this.phoneNumber,
  });
  late final String phoneNumber;

  UserLoginRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone_number'] = phoneNumber;
    return _data;
  }
}
