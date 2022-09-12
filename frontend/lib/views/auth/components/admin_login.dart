import 'package:employee_managment/component/main_button.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/component/main_text_field_icon.dart';
import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Consumer<AuthProvider>(
          builder: (_, authProvider, __) {
            return Form(
                key: authProvider.authAdminFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MainHeadTitle(title: 'ADMIN LOGIN'),
                      MainTextField(
                        hintText: 'Email',
                        prefixIconExist: true,
                        icon: Icons.mail,
                        textEditingController: authProvider.emailController,
                        validatorText: "Enter email address",
                        invalidText: "Invalid email",
                      ),
                      MainTextField(
                        obscureText: true,
                        hintText: 'Password',
                        prefixIconExist: true,
                        icon: Icons.lock,
                        textEditingController: authProvider.passwordController,
                        validatorText: "Enter password",
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      MainButton(
                          text: 'Login',
                          onPressed: (() => authProvider.adminLogin(context)),
                          isLoading: authProvider.loading),
                      const SizedBox(
                        height: 32,
                      ),
                    ]));
          },
        ),
      ),
    );
  }
}
