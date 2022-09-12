import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/views/admin_dashboard/components/employee_list.dart';
import 'package:employee_managment/views/admin_dashboard/components/employee_role.dart';
import 'package:flutter/material.dart';
import 'package:employee_managment/common/responsive.dart';
import 'package:employee_managment/component/dashboard_header.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String? page;

  const Home({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeData();
    super.initState();
  }

  Future<void> homeData() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.adminData();
    await userProvider.userWithRole();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        const EmployeeList(),
                        if (Responsive.isMobile(context))
                          const SizedBox(height: 16),
                        if (Responsive.isMobile(context)) const EmployeeRole(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context)) const SizedBox(width: 16),
                  if (!Responsive.isMobile(context))
                    const Expanded(
                      flex: 2,
                      child: EmployeeRole(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
