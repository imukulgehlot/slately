import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../basic_features.dart';

class MyTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double? height;
  final Widget? suffixIcon;
  final String? title;
  final TextEditingController? textController;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final int? maxLine, maxLength;
  final TextInputType? keyBoardType;
  final bool? obscureText;
  final bool? autoFocus;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function? onTap;
  final String? hintText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? textFieldColor;
  final Color? textFieldBorderColor;

  const MyTextField(
      {super.key,
      this.readOnly = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.inputFormatters,
      this.height,
      this.focusNode,
      this.maxLine,
      this.onTap,
      this.maxLength,
      this.keyBoardType,
      this.title,
      this.obscureText = false,
      this.textController,
      this.hintTextColor,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      this.textStyle,
      this.hintTextStyle,
      this.hintText,
      this.inputType,
      this.autoFocus,
      this.prefixIcon,
      this.textFieldColor,
      this.textFieldBorderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimensions.h50,

      // padding: EdgeInsets.fromLTRB(Dimensions.w16,0, Dimensions.h12, 0),
      //padding: EdgeInsets.fromLTRB(20, 11, 12, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.r8),
        ),
        color: textFieldColor ?? ColorConst.textFieldColor,
        border: Border.all(
          color: textFieldBorderColor ?? ColorConst.textFieldBorderColor,
        ),
      ),
      child: Center(
        child: TextFormField(
          onTap: onTap != null
              ? () {
                  onTap!.call();
                }
              : () {},
          textCapitalization: textCapitalization,
          readOnly: readOnly,
          focusNode: focusNode,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          style: textStyle ??
              (readOnly
                  ? fontStyleMedium13.apply(
                      color: ColorConst.textColor.withOpacity(0.5))
                  : fontStyleSemiBold14),
          textAlignVertical: TextAlignVertical.center,
          autofocus: autoFocus ?? false,
          //  textAlign: TextAlign.center,
          maxLines: maxLine,
          controller: textController,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.r8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: EdgeInsets.only(
                left: Dimensions.w16,
                right: Dimensions.h12,),
            fillColor: Colors.transparent,
            filled: true,
            hintText: hintText ?? "",
            hintStyle: hintTextStyle ??
                fontStyleRegular14.apply(color: ColorConst.hintColor),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),

          onChanged: (val) {
            if (onChanged != null) {
              onChanged!(val);
            }
          },
          keyboardType: keyBoardType,
        ),
      ),
    );
  }
}
