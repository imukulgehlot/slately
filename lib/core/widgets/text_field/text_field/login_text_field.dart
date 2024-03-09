// // import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../basic_features.dart';
//
// class LoginTextField extends StatelessWidget {
//   final List<TextInputFormatter>? inputFormatters;
//   final String? countryCode;
//   final String? isdCode;
//   final Widget? suffixIcon;
//
//   final String? title;
//   final TextEditingController? textController;
//   final Color? hintTextColor;
//   final FocusNode? focusNode;
//   final TextInputType? keyBoardType;
//
//   final ValueChanged? onChanged;
//   final ValueChanged? onFieldSubmit;
//   final FormFieldValidator? validator;
//   final String? hintText;
//   final Function getCountryCode;
//   final bool showCountryCode;
//   final bool showFlag;
//   final bool isRoundedCornor;
//   final Color? textFieldColor;
//
//   const LoginTextField(
//       {super.key,
//       this.inputFormatters,
//       this.suffixIcon,
//       this.focusNode,
//       this.isdCode,
//       this.countryCode,
//       this.title,
//       this.validator,
//       this.textController,
//       this.onFieldSubmit,
//       this.hintTextColor,
//       this.onChanged,
//       this.hintText,
//       required this.getCountryCode,
//       this.isRoundedCornor = true,
//       this.showCountryCode = true,
//       this.keyBoardType = TextInputType.phone,
//       this.showFlag = false,
//       this.textFieldColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: Dimensions.h50,
//       padding: EdgeInsets.fromLTRB(
//           showCountryCode ? Dimensions.w8 : Dimensions.w16,
//           0,
//           Dimensions.h12,
//           0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(Dimensions.r8),
//             topLeft: Radius.circular(Dimensions.r8),
//             bottomRight: Radius.circular(isRoundedCornor ? Dimensions.r8 : 0),
//             bottomLeft: Radius.circular(isRoundedCornor ? Dimensions.r8 : 0)),
//         color: textFieldColor ?? ColorConst.textFieldColor,
//         border: Border.all(
//           color: ColorConst.textFieldBorderColor,
//         ),
//       ),
//       child: Row(
//         children: [
//           Visibility(
//             visible: showCountryCode,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: Dimensions.h2),
//               child: CountryCodePicker(
//                 onChanged: (e) {
//                   /*isdCode=e.dialCode;
//                   countryCode=e.code;*/
//                   // StartupService.setCountryCode(e.code!);
//                   //StartupService.setIsdCode(e.dialCode!);
//                   if (kDebugMode) {
//                     print(e.dialCode!.replaceAll("+", ""));
//                     print(e.code!.replaceAll("+", ""));
//                   }
//
//                   getCountryCode(e.code, e.dialCode);
//                 },
//                 initialSelection: countryCode ?? "+91",
//                 padding: EdgeInsets.zero,
//                 textStyle: fontStyleSemiBold14,
//                 favorite: const ['+91', 'IN'],
//                 showCountryOnly: false,
//                 dialogSize: Size(MediaQuery.of(context).size.width - 50,
//                     MediaQuery.of(context).size.height - 250),
//                 showOnlyCountryWhenClosed: false,
//                 alignLeft: false,
//                 showFlag: showFlag,
//                 flagDecoration: const BoxDecoration(shape: BoxShape.circle),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TextFormField(
//               focusNode: focusNode,
//               style: fontStyleSemiBold14,
//               textAlignVertical: TextAlignVertical.center,
//               onFieldSubmitted: onFieldSubmit,
//               controller: textController,
//               inputFormatters: inputFormatters,
//               decoration: InputDecoration(
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(Dimensions.r8),
//                   borderSide: const BorderSide(
//                     width: 0,
//                     style: BorderStyle.none,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.only(top: 15, bottom: 15),
//                 fillColor: Colors.transparent,
//                 filled: true,
//                 hintText: hintText ?? "",
//                 hintStyle:
//                     fontStyleRegular14.apply(color: ColorConst.hintColor),
//                 suffixIcon: suffixIcon,
//               ),
//               onChanged: (val) {
//                 onChanged!(val);
//               },
//               onSaved: (value) {
//                 value = textController!.text;
//               },
//               keyboardType: keyBoardType,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
