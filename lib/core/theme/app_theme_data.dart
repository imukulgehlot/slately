import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slately/core/basic_features.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ColorConst.primaryColor,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: ColorConst.primaryColor),
    cardColor: const Color(0xfff9f9f9),
    scaffoldBackgroundColor: Colors.white,
    // textTheme: TextTheme(bodyMedium: fontStyleMedium16),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: ColorConst.whiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: Colors.white,
      indicatorColor: ColorConst.primaryColor.withOpacity(0.5),
      backgroundColor: const Color(0xfffefae0),
      labelTextStyle:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return fontStyleSemiBold12.apply(
              color: ColorConst.backgroundColorDark);
        } else {
          return fontStyleRegular12.apply(color: Colors.grey.shade800);
        }
      }),
      iconTheme: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: ColorConst.backgroundColorDark);
        } else {
          return IconThemeData(color: Colors.grey.shade800);
        }
      }),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: ColorConst.signInModeButtonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side:
            const BorderSide(color: ColorConst.signInModeButtonColor, width: 0),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xff4ECB71),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: ColorConst.primaryColor,
    ),
    scaffoldBackgroundColor: ColorConst.backgroundColorDark,
    cardColor: const Color(0xff202020),
    hintColor: ColorConst.hintColor,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: ColorConst.blackColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return fontStyleSemiBold12.apply(
              color: ColorConst.backgroundColorDark);
        } else {
          return fontStyleRegular12.apply(color: ColorConst.whiteColor);
        }
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: const Color(0xff202020),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side: const BorderSide(color: Colors.transparent, width: 0),
      ),
    ),
  );
}
