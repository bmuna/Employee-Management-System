import 'package:employee_managment/common/theme.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  // ignore: non_constant_identifier_names
  static SnackBar MainSnackBarSuccess(BuildContext context, String message) {
    return SnackBar(
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 10,
          left: MediaQuery.of(context).size.width - 300),
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            fontFamily: "Poppins"),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static SnackBar MainSnackBarError(BuildContext context, String message) {
    return SnackBar(
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      backgroundColor: kSecondaryColor,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 10,
          left: MediaQuery.of(context).size.width - 300),
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            fontFamily: "Poppins"),
      ),
    );
  }
}
