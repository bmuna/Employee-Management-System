import 'package:employee_managment/controllers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/views/auth/components/admin_login.dart';
import 'package:employee_managment/views/auth/components/employee_login.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAdmin = true;
  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return Scaffold(
      body: SizedBox(
        width: FrameSize.screenWidth,
        height: FrameSize.screenHeight,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kPrimaryBlackColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isAdmin = !isAdmin;
                            });
                          },
                          child: Text(
                            isAdmin ? "Employee" : "Admin",
                            style: const TextStyle(
                              fontSize: 18,
                              color: kPrimaryBlackColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: 30,
                          child: Divider(
                            color: kSecondaryColor,
                            thickness: 2,
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
            Padding(
                padding: EdgeInsets.all(FrameSize.screenHeight > 770
                    ? 64
                    : FrameSize.screenHeight > 670
                        ? 32
                        : 16),
                child: Center(
                  child: Card(
                      elevation: 40,
                      child: Container(
                        height: FrameSize.screenHeight *
                            (FrameSize.screenHeight > 770
                                ? 0.5
                                : FrameSize.screenHeight > 670
                                    ? 0.6
                                    : 0.7),
                        width: 400,
                        color: kPrimaryLightColor,
                        child: Consumer<AuthProvider>(
                            builder: (_, authProvider, __) {
                          return Center(
                            child: isAdmin
                                ? const AdminLogin()
                                : const EmployeeLogin(),
                          );
                        }),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
