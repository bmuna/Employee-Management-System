import 'package:employee_managment/component/main_snack_bar_sucess.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/controllers/main/service.dart';
import 'package:employee_managment/models/users/request_model/employee_add_request_model.dart';
import 'package:employee_managment/models/users/list_of_role_mode.dart'
    as listofRole;
import 'package:employee_managment/models/users/response_model/restaurant_order_response_model.dart';
import 'package:employee_managment/models/users/request_model/role_request_model.dart';
import 'package:employee_managment/models/users/response_model/task_list_response_model.dart';
import 'package:employee_managment/models/users/request_model/task_request_model.dart';
import 'package:employee_managment/models/users/response_model/user_response_model.dart';
import 'package:employee_managment/models/users/user_with_role_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  bool loadingEmployeeData = true;
  bool loadingEmployeeRole = true;
  bool loadingRole = true;
  bool loadingtask = true;
  bool loadingTaskList = true;
  bool loadingRetrauntLit = true;
  listofRole.Result? dropdownResult;

  bool buttonLoading = false;
  int? roleId;
  dynamic dropdownValue;
  dynamic employeeDropDown;
  String? taskDropDown;

  final employeeFormKey = GlobalKey<FormState>();
  final taskFormKey = GlobalKey<FormState>();
  final roleFormKey = GlobalKey<FormState>();
  final dropDownEmployee = GlobalKey<FormFieldState>();
  final dropDownTask = GlobalKey<FormFieldState>();

  List<TextEditingController> taskControllers = [];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  UsersResponseModel? userResponse;
  UsersWithRoleModel? userWithRoleRes;
  listofRole.ListOfRolesModel? listOfRoleRes;
  TaskListResponseModel? taskListResponse;
  RestaurantOrderResponseModel? restaurantOrderResponse;

  Future<void> adminData() async {
    Response response = await APIService.getUsersDataEnd();
    if (response.statusCode == 201) {
      userResponse = usersResponseModelFromJson(response.body);
    } else {
      print('error');
    }
    loadingEmployeeData = false;
    notifyListeners();
  }

  Future<void> userWithRole() async {
    Response response = await APIService.getUsersWithRoleEnd();
    if (response.statusCode == 201) {
      userWithRoleRes = usersWithRoleModelFromJson(response.body);
    } else {
      print('error');
    }
    loadingEmployeeRole = false;
    notifyListeners();
  }

  Future<void> lisOfRoles() async {
    Response response = await APIService.getlistOfRoleEnd();
    if (response.statusCode == 201) {
      listOfRoleRes = listofRole.listOfRolesModelFromJson(response.body);
    } else {
      print('error');
    }
    loadingRole = false;
    loadingEmployeeData = false;
    notifyListeners();
  }

  void addEmployee(BuildContext context) {
    if (employeeFormKey.currentState!.validate()) {
      buttonLoading = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), () {
        EmployeeAddRequestModel model = EmployeeAddRequestModel(
          fullName: fullNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          roleId: roleId,
        );
        APIService.addEmployeeEnd(model).then((result) {
          if (result) {
            // ignore: deprecated_member_use

            Scaffold.of(context).showSnackBar(
                (SnackBarWidget.MainSnackBarSuccess(
                    context, "Employee successfully added")));
            buttonLoading = false;
            dropdownValue = null;
            emailController.clear();
            phoneNumberController.clear();
            fullNameController.clear();
            dropDownEmployee.currentState!.reset();
            notifyListeners();
          } else {}
        });
      });
    }
  }

  void addTask(BuildContext context) {
    List<TaskRequestModel> tasks = [];
    print('sdfsfsdf: $buttonLoading');

    if (taskFormKey.currentState!.validate()) {
      buttonLoading = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), () {
        for (TextEditingController textcontrol in taskControllers) {
          TaskRequestModel model = TaskRequestModel(
            roleId: roleId,
            task: textcontrol.text,
          );
          tasks.add(model);
        }
        TaskRequestHolderModel model = TaskRequestHolderModel(tasks: tasks);
        APIService.addTaskEnd(model).then((result) {
          dropdownResult = null;
          buttonLoading = false;
          dropDownTask.currentState!.reset();
          notifyListeners();
          for (TextEditingController textcontrol in taskControllers) {
            textcontrol.clear();
          }
          if (result) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
                (SnackBarWidget.MainSnackBarSuccess(
                    context, "Task successfully added ")));
          } else {}
        });
      });
    }
  }

  void addRole(BuildContext context) {
    if (roleFormKey.currentState!.validate()) {
      buttonLoading = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), () {
        RoleRequestModel model = RoleRequestModel(role: roleController.text);
        APIService.addRoleEnd(model).then((result) {
          roleController.clear();
          buttonLoading = false;
          notifyListeners();
          if (result) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
                (SnackBarWidget.MainSnackBarSuccess(
                    context, "Role successfully added")));
          } else {}
        });
      });
    }
  }

  Future<void> taskList() async {
    var roleId = await LocalData.retrieveRoleId();

    print('roleiiiddL $roleId');
    Response response = await APIService.getUserTaskListEnd(roleId!);
    if (response.statusCode == 201) {
      taskListResponse = taskListResponseModelFromJson(response.body);
    } else {
      print('error');
    }

    loadingTaskList = false;
    notifyListeners();
  }

  Future<void> restaurantOrderList() async {
    Response response = await APIService.getRestaurantOrderListEnd();
    if (response.statusCode == 200) {
      restaurantOrderResponse =
          restaurantOrderResponseModelFromJson(response.body);
    } else {
      print('error');
    }
    loadingRetrauntLit = false;
    notifyListeners();
  }
}
