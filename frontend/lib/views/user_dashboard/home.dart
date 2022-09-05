import 'package:employee_managment/views/user_dashboard/components/restaurant_order_list.dart';
import 'package:employee_managment/views/user_dashboard/components/task_list.dart';
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
                        const RestaurantOrderList(),
                        if (Responsive.isMobile(context))
                          const SizedBox(height: 16),
                        if (Responsive.isMobile(context)) const TaskList(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context)) const SizedBox(width: 16),
                  if (!Responsive.isMobile(context))
                    const Expanded(
                      flex: 3,
                      child: TaskList(),
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
