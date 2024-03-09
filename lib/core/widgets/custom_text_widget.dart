import 'package:flutter/material.dart';

import '../utils/custom_text_style.dart';

class CustomTextWidget extends Text {
// @override
  final TextAlign? textAlignment;

  CustomTextWidget.bold25(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(
          text,
          textAlign: textAlignment,
          style: CustomTextStyle.instance.bold25.apply(
            color: color,
          ),
        );

  CustomTextWidget.semiBold18(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.semiBold18.apply(color: color));

  CustomTextWidget.semiBold15(
      {super.key,
      required String text,
      Color? color,
      this.textAlignment,
      int? maxLines,
      TextOverflow? overflow})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.semiBold15.apply(
              color: color,
            ),
            maxLines: maxLines,
            overflow: overflow);

  CustomTextWidget.semiBold16(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.semiBold16.apply(color: color));

  CustomTextWidget.medium14(
      {super.key,
      required String text,
      Color? color,
      this.textAlignment,
      int? maxLines,
      TextOverflow? overflow})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.medium14.apply(color: color),
            maxLines: maxLines,
            overflow: overflow);

  CustomTextWidget.medium15(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.medium15.apply(color: color));

  CustomTextWidget.medium16(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.medium16.apply(color: color));

  CustomTextWidget.medium18(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.medium18.apply(color: color));

  CustomTextWidget.medium12(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.medium12.apply(color: color));

  CustomTextWidget.regular10(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.regular10.apply(color: color));

  CustomTextWidget.regular12(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.regular12.apply(color: color));

  CustomTextWidget.regular14(
      {super.key, required String text, Color? color, this.textAlignment})
      : super(text,
            textAlign: textAlignment,
            style: CustomTextStyle.instance.regular14.apply(color: color));
}
