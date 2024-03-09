import 'package:flutter/material.dart';

class CustomRichTextWidget extends RichText {
  CustomRichTextWidget.getDualText(
      {super.key,
      required String firstText,
      required String secondText,
      required TextStyle firstTextStyle,
      required TextStyle secondTextStyle})
      : super(
          text: TextSpan(
            text: firstText,
            style: firstTextStyle,
            children: <TextSpan>[
              TextSpan(text: secondText, style: secondTextStyle),
            ],
          ),
        );
}
