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
          ],
        ),
      ),
    );
  }
}
