import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employee_managment/common/responsive.dart';
import 'package:employee_managment/views/main/components/side_menu_user.dart';
import 'package:employee_managment/controllers/widget/menu_controller.dart';
import 'package:employee_managment/views/user_dashboard/home.dart';

class MainScreenUser extends StatefulWidget {
  final String? page;

  const MainScreenUser({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<MainScreenUser> createState() => _MainScreenUserState();
}

class _MainScreenUserState extends State<MainScreenUser>
    with SingleTickerProviderStateMixin {
  int active = 0;
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this, initialIndex: 0)
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
      drawer: const SideMenuUser(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenuUser(
                  tabController: tabController,
                ),
              ),
            Expanded(
                flex: 5,
                child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[Home()],
                ))
          ],
        ),
      ),
    );
  }
}
