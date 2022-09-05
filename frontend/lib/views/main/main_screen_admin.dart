import 'package:employee_managment/views/admin_dashboard/employee.dart';
import 'package:employee_managment/views/admin_dashboard/home.dart';
import 'package:employee_managment/views/admin_dashboard/role.dart';
import 'package:employee_managment/views/admin_dashboard/task.dart';
import 'package:employee_managment/common/responsive.dart';
import 'package:employee_managment/controllers/widget/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu_admin.dart';

class MainScreenAdmin extends StatefulWidget {
  final String? page;

  const MainScreenAdmin({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<MainScreenAdmin> createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin>
    with SingleTickerProviderStateMixin {
  int active = 0;
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController!.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenuAdmin(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenuAdmin(
                  tabController: tabController,
                ),
              ),
            Expanded(
              flex: 5,
              child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[Home(), Employee(), Task(), Role()]),
            )
          ],
        ),
      ),
    );
  }
}
