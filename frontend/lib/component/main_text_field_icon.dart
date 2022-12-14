import 'package:flutter/material.dart';

import 'package:employee_managment/common/theme.dart';

class MainTextField extends StatelessWidget {
  const MainTextField(
      {Key? key,
      required this.hintText,
      this.icon,
      this.textEditingController,
      this.validatorText,
      this.invalidText,
      required this.prefixIconExist,
      this.sizedBox = 32,
      this.minLines = 1,
      this.maxLines = 1,
      this.obscureText = false,
      })
      : super(key: key);

  final String hintText;
  final IconData? icon;
  final TextEditingController? textEditingController;
  final String? validatorText;
  final String? invalidText;
  final bool prefixIconExist;
  final double? sizedBox;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizedBox,
        ),
        TextFormField(
          obscureText: obscureText!,
          autofocus: false,
          controller: textEditingController,
          validator: (val) => val!.isEmpty
              ? validatorText
              : !val.contains('@') || !val.contains('.')
                  ? invalidText
                  : null,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: kIconColor,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kSecondaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
