import 'package:flutter/material.dart';

import '../constants/color_const.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get textFieldColor => brightness == Brightness.light
      ? const Color(0xfff9f9f9)
      : const Color(0xff202020);

  Color get textColor => brightness == Brightness.light
      ? const Color(0xff000103)
      : ColorConst.whiteColor;

  Color get iconColor =>
      brightness == Brightness.light ? const Color(0xff707070) : Colors.white;

  Color get hintTextColor =>
      brightness == Brightness.light ? const Color(0xff707070) : Colors.white54;

  Color get likeButtonBorderColor => brightness == Brightness.light
      ? ColorConst.likeButtonBorderColor
      : Colors.grey.shade900;

  Color get buttonGrey => brightness == Brightness.light
      ? ColorConst.signInModeButtonColor
      : ColorConst.backgroundColorDark;
}
