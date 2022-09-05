import 'package:flutter/material.dart';

import 'package:employee_managment/common/theme.dart';

class MainTextFieldNoIcon extends StatelessWidget {
  const MainTextFieldNoIcon({
    Key? key,
    required this.hintText,
    this.icon,
    this.textEditingController,
    this.validatorText,
    this.invalidText,
    required this.prefixIconExist,
    this.sizedBox = 32,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  final String hintText;
  final IconData? icon;
  final TextEditingController? textEditingController;
  final String? validatorText;
  final String? invalidText;
  final bool prefixIconExist;
  final double? sizedBox;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizedBox,
        ),
        TextFormField(
          autofocus: false,
          controller: textEditingController,
          validator: (val) => val!.isEmpty
              ? validatorText
              : !val.contains('@') || !val.contains('.')
                  ? invalidText
                  : null,
          decoration: InputDecoration(
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
