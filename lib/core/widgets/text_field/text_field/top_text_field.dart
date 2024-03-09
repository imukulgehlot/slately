import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../basic_features.dart';

class TopTextField extends StatelessWidget {
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
  final ValueChanged? onChanged;
  final ValueChanged? onFieldSubmit;
  final FormFieldValidator? validator;
  final String? hintText;

  const TopTextField(
      {super.key,
      this.inputFormatters,
      this.textCapitalization = TextCapitalization.sentences,
      this.height,
      this.focusNode,
      this.maxLine,
      this.maxLength,
      this.keyBoardType,
      this.title,
      this.validator,
      this.obscureText = false,
      this.textController,
      this.onFieldSubmit,
      this.hintTextColor,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      this.hintText,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimensions.h50,
      padding: EdgeInsets.fromLTRB(Dimensions.w16, 0, Dimensions.h12, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.r8),
          topLeft: Radius.circular(Dimensions.r8),
        ),
        color: ColorConst.textFieldColor,
        border: Border.all(
          color: ColorConst.textFieldBorderColor,
        ),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText!,
          focusNode: focusNode,
          textCapitalization: textCapitalization,

          style: fontStyleSemiBold14,
          textAlignVertical: TextAlignVertical.center,

          //  textAlign: TextAlign.center,
          maxLines: maxLine ?? 1,
          onFieldSubmitted: onFieldSubmit,
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
            contentPadding: const EdgeInsets.only(top: 15, bottom: 15),
            fillColor: Colors.transparent,
            filled: true,
            hintText: hintText ?? "",
            hintStyle: fontStyleRegular14.apply(color: ColorConst.hintColor),
            suffixIcon: suffixIcon,
          ),

          onChanged: (val) {
            onChanged!(val);
          },
          onSaved: (value) {
            value = textController!.text;
          },

          keyboardType: keyBoardType,
        ),
      ),
    );
  }
}
