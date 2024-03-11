import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slately/core/utils/logger_util.dart';
import 'package:slately/core/widgets/custom_image.dart';

import '../../core/basic_features.dart';

class ViewWallpaper extends StatefulWidget {
  final String pictureURL;

  const ViewWallpaper({super.key, required this.pictureURL});

  @override
  State<ViewWallpaper> createState() => _ViewWallpaperState();
}

class _ViewWallpaperState extends State<ViewWallpaper> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // The Picture
          Hero(
            tag: widget.pictureURL,
            child: CustomNetworkImage(
              image: widget.pictureURL.replaceFirst('http://', 'https://'),
              height: Get.height,
              width: Get.width,
              fitType: BoxFit.cover,
            ),
          ),

          // Back Button
          Positioned(
            left: Dimensions.w15,
            top: kToolbarHeight - Dimensions.h10,
            child: CustomAssetImage(
              image: ImageAsset.icBackButton,
              onTap: Get.back,
              width: Dimensions.w35,
              height: Dimensions.w35,
            ),
          ),

          // Set As Wallpaper
          Positioned(
            bottom: kToolbarHeight,
            child: ElevatedButton(
                onPressed: () {
                  AppUtils.showCustomDialog(
                    title: AppString.setAsWallPaper,
                    myWidget: Column(children: [
                      // Home Screen
                      ListTile(
                        leading: const Icon(Icons.home_outlined,
                            color: ColorConst.primaryColor),
                        title: const Text(
                          AppString.homeScreen,
                        ),
                        onTap: () async {
                          // Two Close Dialog
                          Get.back();
                          // Platform messages may fail, so we use a try/catch PlatformException.
                          try {
                           logger.i("URL ${widget.pictureURL}");
                             await AsyncWallpaper.setWallpaper(
                              url: widget.pictureURL.replaceFirst('http://', 'https://'),
                              wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                              goToHome: true,
                              toastDetails: ToastDetails.success(),
                              errorToastDetails: ToastDetails.error(),
                            )
                                ? 'Wallpaper set'
                                : 'Failed to get wallpaper.';
                          } on PlatformException {
                            logger.e('Failed to get wallpaper.');
                          }
                        },
                      ),

                      // Lock Screen
                      ListTile(
                        leading: const Icon(Icons.lock_open_outlined,
                            color: ColorConst.primaryColor),
                        title: const Text(AppString.lockScreen),
                        onTap: () {
                          // Two Close Dialog
                          Get.back();

                          AsyncWallpaper.setWallpaper(
                              url: widget.pictureURL.replaceFirst('http://', 'https://'),
                              goToHome: true,
                              toastDetails: ToastDetails(
                                  message: AppString.wallpaperSetSuccessfully),
                              errorToastDetails: ToastDetails(
                                  message:
                                      AppString.whoopsSomethingWasNotRight),
                              wallpaperLocation: AsyncWallpaper.LOCK_SCREEN);
                        },
                      ),

                      // Both Screen
                      ListTile(
                        leading: const Icon(Icons.bolt,
                            color: ColorConst.primaryColor),
                        title: const Text(AppString.setBoth),
                        onTap: () {
                          // Two Close Dialog
                          Get.back();

                          AsyncWallpaper.setWallpaper(
                              url: widget.pictureURL.replaceFirst('http://', 'https://'),
                              toastDetails: ToastDetails(
                                  message: AppString.wallpaperSetSuccessfully),
                              errorToastDetails: ToastDetails(
                                  message:
                                      AppString.whoopsSomethingWasNotRight),
                              goToHome: true,
                              wallpaperLocation: AsyncWallpaper.BOTH_SCREENS);
                        },
                      )
                    ]),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryLightColor),
                child: Text(AppString.setAsWallPaper,
                    style: fontStyleBold12.copyWith(
                        color: ColorConst.whiteColor))),
          )
        ],
      ),
    );
  }
}
