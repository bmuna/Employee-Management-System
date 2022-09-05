class UserVerifyOTPRequestModel {
  UserVerifyOTPRequestModel({this.phoneNumber, this.otpCode});
  late final String? phoneNumber;
  late final String? otpCode;

  UserVerifyOTPRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone_number'] = phoneNumber;
    _data['otp_code'] = otpCode;

    return _data;
  }
}
