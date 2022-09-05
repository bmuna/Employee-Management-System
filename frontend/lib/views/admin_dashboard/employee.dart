import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/component/main_head_title.dart';
import 'package:employee_managment/component/main_text_field_no_icon.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/component/main_button.dart';
import 'package:provider/provider.dart';
import '../../component/main_text_field_icon.dart';
import '../../models/users/list_of_role_mode.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).lisOfRoles();
  }

  @override
  void dispose() {
    super.dispose();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fullNameController.dispose();
    userProvider.emailController.dispose();
    userProvider.phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FrameSize.init(context: context);
    return Consumer<UserProvider>(builder: (_, userProvider, __) {
      return Scaffold(
          body: Center(
        child: userProvider.loading
            ? const LoadingWidget()
            : Card(
                elevation: 3,
                child: Container(
                    height: FrameSize.screenHeight *
                        (FrameSize.screenHeight > 770
                            ? 0.5
                            : FrameSize.screenHeight > 670
                                ? 0.7
                                : 0.8),
                    width: 500,
                    color: Colors.white,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Form(
                                key: userProvider.employeeFormKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const MainHeadTitle(
                                          title: 'ADD EMPLOYEE'),
                                      Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MainTextFieldNoIcon(
                                                hintText: 'Full Name',
                                                icon: Icons.mail,
                                                textEditingController:
                                                    userProvider
                                                        .fullNameController,
                                                validatorText:
                                                    "Enter full name",
                                                prefixIconExist: false,
                                                sizedBox: 25,
                                              ),
                                            ),
                                            const SizedBox(width: 25),
                                            Expanded(
                                              child: MainTextFieldNoIcon(
                                                hintText: 'Email',
                                                icon: Icons.mail,
                                                textEditingController:
                                                    userProvider
                                                        .emailController,
                                                validatorText:
                                                    "Enter email address",
                                                invalidText: "Invalid email",
                                                prefixIconExist: false,
                                                sizedBox: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        MainTextFieldNoIcon(
                                          hintText: 'Phone Number',
                                          icon: Icons.lock,
                                          textEditingController: userProvider
                                              .phoneNumberController,
                                          validatorText: "Enter phone number",
                                          prefixIconExist: false,
                                          sizedBox: 25,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        DropdownButtonFormField<String>(
                                          value: userProvider.dropdownValue,
                                          hint: const Text("Role"),
                                          onChanged: (var newValue) {
                                            setState(() {
                                              userProvider.dropdownValue =
                                                  newValue!;
                                            });
                                          },
                                          validator: (var value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Enter role';
                                            }
                                          },
                                          items: userProvider
                                              .listOfRoleRes!.result
                                              .map((Result value) {
                                            String role =
                                                MainUtils.convertToTitleCase(
                                                    value.role);
                                            userProvider.roleId = value.id;
                                            return DropdownMenuItem<String>(
                                              value: role,
                                              child: Text(role),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 64,
                                        )
                                      ]),
                                      MainButton(
                                          text: 'submit',
                                          onPressed: (() => userProvider
                                              .addEmployee(context)),
                                          isLoading: userProvider.loading),
                                      const SizedBox(
                                        height: 64,
                                      )
                                    ])))))),
      ));
    });
  }
}
