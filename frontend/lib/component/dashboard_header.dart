import 'package:employee_managment/common/responsive.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        if (!Responsive.isMobile(context))
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 18,
              color: kPrimaryBlackColor,
              fontFamily: 'Poppins',
            ),
          ),
      ],
    );
  }
}
