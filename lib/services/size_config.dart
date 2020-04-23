// for colors and text style

import 'package:flutter/material.dart';

class SizeConfig {
  // for media  query data
  static MediaQueryData _mediaQueryData;
  // for store width and hieght screen sizes
  static double screenWidth;
  static double screenHeight;

  // fro store blocks horizontal and vertical sizes
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  // for store safe areas horizontal and vertical sizes
  static double safeAreaHorizontal;
  static double safeAreaVertical;
  // for store safe blocks horizontal and vertical sizes
  static double safeBlocHorizontal;
  static double safeBlocVertical;

  // for initialize MediaQueryData and  and get screen info
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlocHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlocVertical = (screenHeight - safeAreaVertical) / 100;
  }
}
