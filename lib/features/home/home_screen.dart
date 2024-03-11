import 'package:flutter/material.dart';
import 'package:slately/core/widgets/custom_image.dart';
import 'package:slately/features/admin/controllers/image_upload_controller.dart';
import 'package:slately/features/home/view_wallpaper.dart';

import '../../core/basic_features.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ImageUploadController imageUploadController =
      Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          AppUtils.showExitPopScopePopup();
        }
      },
      child: Scaffold(
        body: Obx(
          () => RefreshIndicator(
            onRefresh: (){
              imageUploadController.nextCursor = null;
               imageUploadController.getImages();
              return Future.value();
               },
            child: CustomScrollView(
              controller: imageUploadController.scrollController,
              slivers: [
                // App Bar
                SliverAppBar(
                  title: CustomSvgAssetImage(
                    image: ImageAsset.icAppLogo,
                    width: Dimensions.w120,
                  ),
                  titleSpacing: 0,
                ),

                // Wall List
                SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.w10,
                      mainAxisSpacing: Dimensions.w10,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                    ),
                    itemCount: imageUploadController.images.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Get.to(() => ViewWallpaper(
                              pictureURL: imageUploadController.images[index].secureUrl!)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.r10),
                            child: Hero(
                              tag: imageUploadController.images[index],
                              child: CustomNetworkImage(
                                height: double.infinity,
                                image: imageUploadController.images[index].secureUrl!,
                              ),
                            ),
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
