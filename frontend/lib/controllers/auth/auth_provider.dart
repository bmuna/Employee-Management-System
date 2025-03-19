import 'package:employee_managment/common/user_type_enum.dart';
import 'package:employee_managment/controllers/auth/local/local_persist_data.dart';
import 'package:employee_managment/controllers/auth/service.dart';
import 'package:employee_managment/models/auth/response_model/admin_login_response_model.dart';
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

  UserLoginResponseModel? loginResponse;

  void adminLogin(BuildContext context) {
    if (authAdminFormKey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {
        AdminLoginRequestModel model = AdminLoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        );

        APIService.loginAdminEnd(model).then((result) async {
          if (result.statusCode == 201) {
            print('result: ${result.body}');
            AdminLoginResponseModel loginResponse = adminLoginResponseModelFromJson(result.body);

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Check your email/password again"),
                backgroundColor: Colors.red,
              ),
            );
          }
        }).catchError((error) {
          loading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("An error occurred. Please try again."),
              backgroundColor: Colors.red,
            ),
          );
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
              loading = false;
              notifyListeners();

              // Guard against context being unmounted
              if (!context.mounted) return;

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                      content: Text("Code has been sent to your phone number"),
                      backgroundColor: Colors.green,
                    ),
                  )
                  .closed
                  .whenComplete(() {
                if (context.mounted) {
                  Navigator.pushNamed(context, RoutesName.otp);
                }
              });
            } else {
              loading = false;
              notifyListeners();

              // Guard against context being unmounted
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Try again"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
        } else if (result.statusCode == 404) {
          loading = false;
          notifyListeners();

          // Guard against context being unmounted
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User doesn't exist"),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          loading = false;
          notifyListeners();

          // Guard against context being unmounted
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Try again later"),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  void otpConfirm(BuildContext context) {
    if (otpFormKey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      UserVerifyOTPRequestModel model = UserVerifyOTPRequestModel(
        phoneNumber: phoneController.text,
        otpCode: otpController.text,
      );

      APIService.verifyOTPEnd(model).then((result) async {
        loading = false;
        notifyListeners();

        if (result.statusCode == 201) {
          loginResponse = userLoginResponseModelFromJson(result.body);
          await LocalData.saveUserType(UserType.user.name);
          await LocalData.saveUserToken(loginResponse!.token);

          LocalData.saveUserRoleId(loginResponse!.users[0].roleId).whenComplete(() {
            print('code2: ${loginResponse!.users[0].roleId}');
            phoneController.clear();
            otpController.clear();

            // Guard against context being unmounted
            if (!context.mounted) return;

            ScaffoldMessenger.of(context)
                .showSnackBar(
                  const SnackBar(
                    content: Text("Successfully logged in"),
                    backgroundColor: Colors.green,
                  ),
                )
                .closed
                .whenComplete(() {
              if (context.mounted) {
                Navigator.pushNamed(context, RoutesName.dashboarduser);
              }
            });
          });
        } else if (result.statusCode == 400) {
          // Guard against context being unmounted
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid code"),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Guard against context being unmounted
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Try again later"),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }
}
