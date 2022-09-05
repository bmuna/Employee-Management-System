import 'dart:convert';
import 'package:employee_managment/config.dart';
import 'package:employee_managment/models/auth/request_model/admin_login_request_model.dart';
import 'package:employee_managment/models/auth/request_model/user_login_request_model.dart';
import 'package:employee_managment/models/users/response_model/user_verify_otp_request_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<http.Response> loginAdminEnd(
      AdminLoginRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Uri url =
        Uri.http(Config.hostURL, Config.basePathURL + Config.adminLoginPath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return response;
  }

  static Future<http.Response> checkUserExistEnd(
      UserLoginRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Uri url = Uri.http(
        Config.hostURL, Config.basePathURL + Config.checkUserExistPath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    return response;
  }

  static Future<http.Response> sendOTPEnd(UserLoginRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Uri url = Uri.http(Config.hostURL, Config.basePathURL + Config.sendOTPPath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    return response;
  }

  static Future<http.Response> verifyOTPEnd(
      UserVerifyOTPRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Uri url =
        Uri.http(Config.hostURL, Config.basePathURL + Config.verifyOTPPath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return response;
  }
}
