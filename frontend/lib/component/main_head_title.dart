import 'package:employee_managment/common/theme.dart';
import 'package:flutter/material.dart';

class MainHeadTitle extends StatelessWidget {
  const MainHeadTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: kPrimaryBlackColor,
            fontFamily: 'Poppins',
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
        ),
      ],
    );
  }
}
