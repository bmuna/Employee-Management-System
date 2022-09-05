import 'package:employee_managment/common/user_type_enum.dart';
import 'package:employee_managment/component/main_snack_bar_sucess.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/controllers/auth/service.dart';
import 'package:employee_managment/models/auth/response_model/login_response_model.dart';
import 'package:employee_managment/models/auth/request_model/admin_login_request_model.dart';
import 'package:employee_managment/models/auth/request_model/user_login_request_model.dart';
import 'package:employee_managment/models/users/response_model/user_verify_otp_request_model.dart';
import 'package:employee_managment/router/routes_name.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;

  final authAdminFormKey = GlobalKey<FormState>();
  final authUserFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void adminLogin(BuildContext context) {
    if (authAdminFormKey.currentState!.validate()) {
      Future.delayed(const Duration(seconds: 1), () {
        loading = true;
        notifyListeners();
        AdminLoginRequestModel model = AdminLoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        );
        APIService.loginAdminEnd(model).then((result) async {
          if (result.statusCode == 201) {
            LoginResponseModel loginResponse =
                loginResponseModelFromJson(result.body);
            await LocalData.saveUserType(UserType.admin.name);
            LocalData.saveAdminToken(loginResponse.token).whenComplete(() {
              emailController.clear();
              passwordController.clear();
              loading = false;
              notifyListeners();
              Navigator.pushNamed(context, RoutesName.dashboardadmin);
            });
          } else {
            loading = false;
            notifyListeners();
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar((SnackBarWidget.MainSnackBarError(
                context, "Check your emaill/password again")));
          }
        });
      });
    }
  }

  void userLogin(BuildContext context) {
    if (authUserFormKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      UserLoginRequestModel model = UserLoginRequestModel(
        phoneNumber: phoneController.text,
      );
      APIService.checkUserExistEnd(model).then((result) {
        if (result.statusCode == 201) {
          APIService.sendOTPEnd(model).then((result) async {
            if (result.statusCode == 201) {
              LoginResponseModel loginResponse =
                  loginResponseModelFromJson(result.body);
              await LocalData.saveUserType(UserType.user.name);
              LocalData.saveUserToken(loginResponse.token).whenComplete(() {
                phoneController.clear();
                loading = false;
                notifyListeners();
                Scaffold.of(context)
                    // ignore: deprecated_member_use
                    .showSnackBar((SnackBarWidget.MainSnackBarSuccess(
                        context, "Code has been sent your phone number")))
                    .closed
                    .whenComplete(
                        () => {Navigator.pushNamed(context, RoutesName.otp)});
              });
            } else {
              loading = false;
              notifyListeners();
              // ignore: deprecated_member_use
              Scaffold.of(context).showSnackBar(
                  (SnackBarWidget.MainSnackBarError(context, "Try again")));
            }
          });
        } else if (result.statusCode == 404) {
          loading = false;
          notifyListeners();
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar((SnackBarWidget.MainSnackBarError(
              context, "User doesn't exist")));
        } else {
          loading = false;
          notifyListeners();
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
              (SnackBarWidget.MainSnackBarError(context, "try again later")));
        }
      });
    }
  }

  void otpConfirm(BuildContext context) {
    if (otpFormKey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      UserVerifyOTPRequestModel model = UserVerifyOTPRequestModel(
          phoneNumber: phoneController.text, otpCode: otpController.text);
      APIService.verifyOTPEnd(model).then((result) {
        loading = false;
        notifyListeners();
        if (result.statusCode == 201) {
          otpController.clear();
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar((SnackBarWidget.MainSnackBarSuccess(
                  context, "Successfuly logged in")))
              .closed
              .whenComplete(() =>
                  {Navigator.pushNamed(context, RoutesName.dashboarduser)});
        } else if (result.statusCode == 400) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
              (SnackBarWidget.MainSnackBarError(context, "Invalide code")));
        } else {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
              (SnackBarWidget.MainSnackBarError(context, "Try again later")));
        }
      });
    }
  }
}
