import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/component/main_button.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/component/main_text_field_icon.dart';
import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeLogin extends StatelessWidget {
  const EmployeeLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Consumer<AuthProvider>(builder: (_, authProvider, __) {
              return Form(
                key: authProvider.authUserFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MainHeadTitle(title: 'EMPLOYEE LOGIN'),
                    const SizedBox(
                      height: 32,
                    ),
                    MainTextField(
                      hintText: 'Phone number',
                      prefixIconExist: true,
                      icon: Icons.phone,
                      textEditingController: authProvider.phoneController,
                      validatorText: "Enter phone number",
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    MainButton(
                        text: 'Login',
                        onPressed: (() => authProvider.userLogin(context)),
                        isLoading: authProvider.loading),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              );
            })));
  }
}
