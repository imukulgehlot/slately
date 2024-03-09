import 'package:flutter/material.dart';

import '../basic_features.dart';
import '../utils/custom_text_style.dart';

class RoundedRectangleButton extends ElevatedButton {
  RoundedRectangleButton.textButton({
    super.key,
    required final String text,
    final TextAlign? textAlign,
    final double? miniWidth,
    final double? height,
    final TextStyle? textStyle,
    final double? elevation,
    final double? cornerRadius,
    final Color? btnBgColor,
    final Color? borderColor,
    final EdgeInsetsGeometry? padding,
    required final VoidCallback onPressed,
  })  : assert(
          text.isNotEmpty,
          "Text must not be null",
        ),
        super(
            child: Text(
              text,
              style: textStyle ?? CustomTextStyle.instance.semiBold18,
              textAlign: textAlign,
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize:
                  Size(miniWidth ?? double.infinity, height ?? Dimensions.h60),
              padding: padding,
              // fixedSize:
              // Size(miniWidth ?? double.infinity, height ?? Dimensions.h40),
              backgroundColor: btnBgColor ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(cornerRadius ?? Dimensions.r10),
                  side: BorderSide(color: borderColor ?? Colors.transparent)),
            ));

  RoundedRectangleButton.iconTextButton({
    super.key,
    required final String text,
    required final Widget icon,
    final double? miniWidth,
    final double? height,
    final TextStyle? textStyle,
    final double? elevation,
    final double? cornerRadius,
    final Color? btnBgColor,
    final Color? borderColor,
    required final VoidCallback onPressed,
  })  : assert(
          text.isNotEmpty,
          "Text must not be null",
        ),
        super(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: icon),
                Text(
                  text,
                  style: textStyle ?? CustomTextStyle.instance.semiBold18,
                ),
              ],
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize:
                  Size(miniWidth ?? double.infinity, height ?? Dimensions.h60),
              // fixedSize:
              // Size(miniWidth ?? double.infinity, height ?? Dimensions.h40),
              backgroundColor: btnBgColor ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(cornerRadius ?? Dimensions.r10),
                  side: BorderSide(color: borderColor ?? Colors.transparent)),
            ));
}

class MyButton extends StatelessWidget {
  final double? miniWidth;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  final String? title;
  final bool? loading;
  final double? cornerRadius;
  final Color? btnBgColor;
  final Function()? onPressed;

  const MyButton(
      {super.key,
      this.miniWidth,
      this.height,
      this.elevation,
      this.cornerRadius,
      required this.title,
      this.btnBgColor,
      this.textStyle,
      required this.onPressed,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(miniWidth ?? double.infinity, height ?? Dimensions.h50),
        backgroundColor: btnBgColor ?? ColorConst.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? Dimensions.r10),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(title!,
            style: textStyle ?? fontStyleSemiBold15.apply(color: Colors.white)),
      ),
    );
  }
}

class MyOutLineButton extends StatelessWidget {
  final double? miniWidth;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  final String? title;
  final bool? loading;
  final double? cornerRadius;
  final Color? btnBgColor;
  final Color? borderColor;
  final Function onPressed;

  const MyOutLineButton(
      {Key? key,
      this.miniWidth,
      this.height,
      this.borderColor,
      this.elevation,
      this.cornerRadius,
      required this.title,
      this.btnBgColor,
      this.textStyle,
      required this.onPressed,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: btnBgColor ?? ColorConst.whiteColor,
        fixedSize: Size(miniWidth ?? double.infinity, height ?? Dimensions.h50),
        side: BorderSide(
          width: 1.0,
          color: borderColor ?? ColorConst.textFieldBorderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? Dimensions.r10),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Center(
        child: Text(title!, style: textStyle ?? fontStyleSemiBold15),
      ),
    );
  }
}
