import 'package:flutter/material.dart';

import '../basic_features.dart';

class CustomTextStyle {
  CustomTextStyle._();

  static final instance = CustomTextStyle._();

  final bold25 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
            fontSize: Dimensions.sp25,
          ) ??
      const TextStyle();
  final bold22 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
            fontSize: Dimensions.sp22,
          ) ??
      const TextStyle();

  final medium22 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp22,
          ) ??
      const TextStyle();
  final medium20 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp20,
          ) ??
      const TextStyle();
  final medium18 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp18,
          ) ??
      const TextStyle();
  final medium16 = Theme.of(Get.context!)
          .textTheme
          .headlineMedium
          ?.copyWith(fontSize: Dimensions.sp16) ??
      const TextStyle();
  final medium15 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp15,
          ) ??
      const TextStyle();
  final medium14 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp14,
          ) ??
      const TextStyle();
  final medium13 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp13,
          ) ??
      const TextStyle();
  final medium12 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp12,
          ) ??
      const TextStyle();
  final medium11 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp11,
          ) ??
      const TextStyle();
  final medium10 = Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: Dimensions.sp10,
          ) ??
      const TextStyle();

  final regular10 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp10,
          ) ??
      const TextStyle();
  final regular12 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp12,
          ) ??
      const TextStyle();
  final regular14 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp14,
          ) ??
      const TextStyle();
  final regular15 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp15,
          ) ??
      const TextStyle();
  final regular16 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp16,
          ) ??
      const TextStyle();
  final regular18 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp18,
          ) ??
      const TextStyle();
  final regular20 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp20,
          ) ??
      const TextStyle();
  final regular22 = Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: Dimensions.sp22,
          ) ??
      const TextStyle();

  final semiBold12 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp12, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold14 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp14, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold15 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp15, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold16 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp16, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold18 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp18, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold20 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp20, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
  final semiBold22 = Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
          fontSize: Dimensions.sp22, fontWeight: FontAsset.semiBold) ??
      const TextStyle();
}
