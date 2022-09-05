import 'dart:convert';
import 'package:employee_managment/config.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/models/users/request_model/employee_add_request_model.dart';
import 'package:employee_managment/models/users/request_model/role_request_model.dart';
import 'package:employee_managment/models/users/request_model/task_request_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<http.Response> getUsersDataEnd() async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    print('tokennn: $tokenAdmin');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };

    Uri url = Uri.http(Config.hostURL, Config.basePathURL + Config.getUserPath);
    var response = await client.get(url, headers: requestHeaders);
    print('response:drd ${response.body}');
    return response;
  }

  static Future<http.Response> getUsersWithRoleEnd() async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };

    Uri url = Uri.http(
        Config.hostURL, Config.basePathURL + Config.getUserWithRolePath);
    var response = await client.get(url, headers: requestHeaders);
    print('response:role ${response.body}');

    return response;
  }

  static Future<http.Response> getlistOfRoleEnd() async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };

    Uri url = Uri.http(
        Config.hostURL, Config.basePathURL + Config.getlistOfRolesPath);
    var response = await client.get(url, headers: requestHeaders);
    return response;
  }

  static Future<bool> addEmployeeEnd(EmployeeAddRequestModel model) async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };

    Uri url =
        Uri.http(Config.hostURL, Config.basePathURL + Config.addEmployeePath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addTaskEnd(TaskRequestHolderModel model) async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };
    Uri url = Uri.http(Config.hostURL, Config.basePathURL + Config.addTaskPath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addRoleEnd(RoleRequestModel model) async {
    String? tokenAdmin = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAdmin'
    };
    Uri url = Uri.http(Config.hostURL, Config.basePathURL + Config.addRolePath);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> getUserTaskListEnd() async {
    String? tokenUser = await LocalData.retrieveAdminToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenUser'
    };

    Uri url =
        Uri.http(Config.hostURL, Config.basePathURL + Config.getTaskListPath);
    var response = await client.get(url, headers: requestHeaders);
    return response;
  }

  static Future<http.Response> getRestaurantOrderListEnd() async {
    Uri url =
        Uri.http(Config.restaurantOrderURL, Config.restaurantOrderListPath);
    var response = await client.get(url);
    return response;
  }
}
