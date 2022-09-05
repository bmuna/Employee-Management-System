import 'package:employee_managment/common/theme.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatefulWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("No data",
        style: TextStyle(
          fontSize: 15,
          color: kSubBlackColor,
          fontFamily: 'Poppins',
        ));
  }
}
