import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';
import '../utils/shimmer_effect.dart';

class MyNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final String image;
  final BoxFit? fitType;

  const MyNetworkImage(
      {super.key,
      required this.height,
      this.width,
      required this.image,
      this.fitType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: CachedNetworkImage(
            fit: fitType ?? BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: ColorConst.shimmerBaseColor,
                  highlightColor: ColorConst.shimmerHighLightColor,
                  child: Container(
                    height: height,
                    color: ColorConst.primaryColor,
                  ),
                ),
            errorWidget: (context, url, error) => Image.asset(
                  ImageAsset.icAppLogo,
                  fit: BoxFit.fill,
                )));
  }
}

class MyCircleNetworkImage extends StatelessWidget {
  final double? radius;
  final String image;

  const MyCircleNetworkImage({
    Key? key,
    this.radius,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: CachedNetworkImage(
          fit: BoxFit.fill,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return CircleAvatar(
              radius: radius,
              backgroundImage: provider,
            );
          },
          imageUrl: image,
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: ColorConst.shimmerBaseColor,
              highlightColor: ColorConst.shimmerHighLightColor,
              child: CircleAvatar(
                radius: radius,
              )),
          errorWidget: (context, url, error) => CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(ImageAsset.icAppLogo))),
    );
  }
}

class MyRoundCornerNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final int cacheWidth;
  final String image;

  const MyRoundCornerNetworkImage({
    Key? key,
    required this.height,
    this.cacheWidth = 200,
    required this.width,
    this.radius = 8,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          memCacheWidth: cacheWidth,
          height: height,
          width: width,
          filterQuality: FilterQuality.none,
          imageUrl: image,
          placeholder: (context, url) => Shimmer.fromColors(
                baseColor: ColorConst.shimmerBaseColor,
                highlightColor: ColorConst.shimmerHighLightColor,
                child: Container(
                  height: 280,
                  color: ColorConst.primaryColor,
                ),
              ),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(ImageAsset.icAppLogo))),
    );
  }
}

class MyRoundCornerFileImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final String image;

  const MyRoundCornerFileImage({
    Key? key,
    required this.height,
    this.width,
    this.radius = 10,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorConst.greyColor, width: 0.5),
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: FileImage(File(image)),
                  fit: BoxFit.cover,
                ))));
  }
}
