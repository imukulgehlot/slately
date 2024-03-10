import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // The Picture
          CustomNetworkImage(
            image: widget.pictureURL,
            height: Get.height,
            width: Get.width,
            fitType: BoxFit.cover,
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
                        onTap: () {
                          // Two Close Dialog
                          Get.back();

                          AsyncWallpaper.setWallpaper(
                              url: widget.pictureURL,
                              toastDetails: ToastDetails(
                                  message: AppString.wallpaperSetSuccessfully),
                              errorToastDetails: ToastDetails(
                                  message:
                                      AppString.whoopsSomethingWasNotRight),
                              goToHome: true,
                              wallpaperLocation: AsyncWallpaper.HOME_SCREEN);
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
                              url: widget.pictureURL,
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
                              url: widget.pictureURL,
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
