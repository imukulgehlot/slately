import 'package:flutter/material.dart';
import 'package:slately/core/widgets/custom_image.dart';

import '../../core/basic_features.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        body: CustomScrollView(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 4),
              itemCount: 10,
              itemBuilder: (context, index) => GridTile(
                  child: CustomNetworkImage(
                image:
                    "https://res.cloudinary.com/djj6yah7c/image/upload/v1689013665/nsnqd5fvjjjyru2ikdlx.jpg",
                height: Dimensions.h50,
                fitType: BoxFit.cover,
              )),
            )
          ],
        ),
      ),
    );
  }
}
