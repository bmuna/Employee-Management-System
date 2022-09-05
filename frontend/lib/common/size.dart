import 'package:flutter/material.dart';

class FrameSize {
  FrameSize(BuildContext context);

  static void init({
    required context,
  }) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static const defaultPadding = 16.0;
}
