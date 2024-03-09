import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_image.dart';
import '../constants/color_const.dart';
import '../constants/dimensions.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final String image;
  final  BoxFit? fitType;
  final bool showAppLogo;

  const CustomNetworkImage(
      {super.key, required this.height,
      this.width,
      required this.image,
      this.fitType,
      this.showAppLogo = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: CachedNetworkImage(
            fit: fitType ?? BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                  radius: 10,
                )),
            errorWidget: (context, url, error) => Container(
                  color: ColorConst.greyColor,
                  child: showAppLogo
                      ? Padding(
                          padding: EdgeInsets.all(Dimensions.w20),
                          child: Image.asset(
                            ImageAsset.icDrawerIcon,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.r35,
                              vertical: Dimensions.r33),
                          child: Image.asset(
                            ImageAsset.icDrawerIcon,
                            fit: BoxFit.fill,
                          ),
                        ),
                )));
  }
}

class MyNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final String image;
  final BoxFit? fitType;

  const MyNetworkImage(
      {super.key, required this.height, this.width, required this.image, this.fitType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: CachedNetworkImage(
            fit: fitType ?? BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                  radius: 10,
                )),
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
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                radius: 10,
              )),
          errorWidget: (context, url, error) => CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(ImageAsset.icAppLogo))),
    );
  }
}

class MyRoundCornerNetworkImage extends StatelessWidget {
  final double height;
  final  double? width;
  final double radius;
  final String image;

  const MyRoundCornerNetworkImage({
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
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConst.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    )));
          },
          /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                radius: 10,
              )),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(ImageAsset.icAppLogo))),
    );
  }
}

class MyRoundCornerAssetImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final Color? imageColor;
  final String image;

  const MyRoundCornerAssetImage({
    Key? key,
    required this.height,
    this.width,
    this.imageColor,
    this.radius = 10,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          height: height,
          width: width,
          color: imageColor,
        ));
  }
}

class CustomSvgAssetImage extends StatelessWidget {
  final double? height;
  final double? width;
  final Function? onTap;
  final String image;
  final Color? color;

  const CustomSvgAssetImage({
    Key? key,
    this.height,
    this.width,
    this.onTap,
    this.color,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: SvgPicture.asset(
        image,
        color: color,
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
    );
  }
}

class CustomAssetImage extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? imageColor;
  final Function? onTap;
  final String image;

  const CustomAssetImage({
    Key? key,
    this.height,
    this.width,
    this.imageColor,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: height,
        width: width,
        color: imageColor,
      ),
    );
  }
}

class CustomRoundCornerNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final String image;

  const CustomRoundCornerNetworkImage({
    Key? key,
    this.height,
    this.width,
    this.radius = 10,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConst.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    )));
          },
          /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                color: ColorConst.primaryColor,
                radius: 10,
              )),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(ImageAsset.icReadedNotification))),
    );
  }
}
