import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_image.dart';
import '../constants/color_const.dart';
import '../constants/dimensions.dart';

enum DotPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

class Carousel extends StatefulWidget {
  //All the images on this Carousel.
  final List images;

  //All the images on this Carousel.
  // final defaultImage;

  //The transition animation timing curve. Default is [Curves.ease]
  final Curve animationCurve;

  //The transition animation duration. Default is 300ms.
  final Duration animationDuration;

  // The base size of the dots. Default is 8.0
  final double dotSize;

  // The increase in the size of the selected dot. Default is 2.0
  final double dotIncreaseSize;

  // The distance between the center of each dot. Default is 25.0
  final double dotSpacing;

  // The Color of each dot. Default is Colors.white
  final Color dotColor;

  // The background Color of the dots. Default is [Colors.grey[800].withOpacity(0.5)]
  final Color dotBgColor;

  // The Color of each increased dot. Default is Colors.white
  final Color dotIncreasedColor;

  // Enable or Disable the indicator (dots). Default is true
  final bool showIndicator;

  //Padding Size of the background Indicator. Default is 20.0
  final double indicatorBgPadding;

  //How to show the images in the box. Default is cover
  final BoxFit boxFit;

  //Enable/Disable radius Border for the images. Default is false
  final bool borderRadius;

  //Border Radius of the images. Default is [Radius.circular(8.0)]
  final Radius radius;

  //Indicator position. Default bottomCenter
  final DotPosition dotPosition;

  //Move the Indicator Horizontally relative to the dot position
  final double dotHorizontalPadding;

  //Move the Indicator Vertically relative to the dot position
  final double dotVerticalPadding;

  //Move the Indicator From the Bottom
  final double moveIndicatorFromBottom;

  //Remove the radius bottom from the indicator background. Default false
  final bool noRadiusForIndicator;

  //Enable/Disable Image Overlay Shadow. Default false
  final bool overlayShadow;

  //Choose the color of the overlay Shadow color. Default Colors.grey[800]
  final Color overlayShadowColors;

  //Choose the size of the Overlay Shadow, from 0.0 to 1.0. Default 0.5
  final double overlayShadowSize;

  //Enable/Disable the auto play of the slider. Default true
  final bool autoplay;

  //Duration of the Auto play slider by seconds. Default 3 seconds
  final Duration autoplayDuration;

  //On image tap event, passes current image index as an argument
  final void Function(int) onImageTap;

  //On image change event, passes previous image index and current image index as arguments
  final void Function(int, int) onImageChange;

  const Carousel({
    super.key,
    required this.images,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 100),
    this.dotSize = 8.0,
    this.dotSpacing = 25.0,
    this.dotIncreaseSize = 2.0,
    this.dotColor = Colors.white,
    required this.dotBgColor,
    this.dotIncreasedColor = Colors.white,
    this.showIndicator = true,
    this.indicatorBgPadding = 20.0,
    this.boxFit = BoxFit.cover,
    this.borderRadius = false,
    required this.radius,
    this.dotPosition = DotPosition.bottomCenter,
    this.dotHorizontalPadding = 0.0,
    this.dotVerticalPadding = 0.0,
    this.moveIndicatorFromBottom = 0.0,
    this.noRadiusForIndicator = false,
    this.overlayShadow = false,
    required this.overlayShadowColors,
    this.overlayShadowSize = 0.5,
    this.autoplay = true,
    this.autoplayDuration = const Duration(seconds: 3),
    required this.onImageTap,
    required this.onImageChange,
    // this.defaultImage,
  });

  @override
  State createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  Timer? timer;
  int _currentImageIndex = 0;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    if (widget.images.isNotEmpty) {
      if (widget.autoplay) {
        timer = Timer.periodic(widget.autoplayDuration, (_) {
          if (_controller.hasClients) {
            if (_controller.page!.round() == widget.images.length - 1) {
              _controller.animateToPage(
                0,
                duration: widget.animationDuration,
                curve: widget.animationCurve,
              );
            } else {
              _controller.nextPage(
                  duration: widget.animationDuration,
                  curve: widget.animationCurve);
            }
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listImages =
        List<Widget>.generate(widget.images.length, (int index) {
      return
          /*ClipRRect(
          borderRadius: BorderRadius.only(topRight:  Radius.circular(Dimensions.r20),
            topLeft:  Radius.circular(Dimensions.r20)),
      child:Image.network(widget.images[index],fit: BoxFit.fill,));*/

          ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.r20),
                  topLeft: Radius.circular(Dimensions.r20)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.images[index],
                placeholder: (context, url) =>
                    const Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset(ImageAsset.icAppLogo),
              ));

      // Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(Dimensions.r20),
      //         topLeft: Radius.circular(
      //             Dimensions.r20) //                 <--- border radius here
      //         ),
      //     image: DecorationImage(
      //       image: NetworkImage(widget.images[index]),
      //       fit: BoxFit.fill,
      //     ),
      //   ),

      //   /* child: Image.network(imgList[index],fit: BoxFit.fill,)*/
      // );
    }).toList();

    return Stack(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Dimensions.h400,
          ),
          //constraints:  BoxConstraints.tight(Size.fromHeight(300.0)),

          child: Builder(
            builder: (_) {
              Widget pageView = PageView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                children: listImages,
                onPageChanged: (currentPage) {
                  // if (widget.onImageChange != null) {
                  widget.onImageChange(_currentImageIndex, currentPage);
                  // }

                  _currentImageIndex = currentPage;
                },
              );

              // if (widget.onImageTap == null) {
              //   return pageView;
              // }

              return GestureDetector(
                child: pageView,
                onTap: () => widget.onImageTap(_currentImageIndex),
              );
            },
          ),
        ),
        widget.showIndicator
            ? Positioned(
                top: 10,
                right: 15,
                child: SizedBox(
                  height: 30,
                  // color: Colors.orange,
                  child: Center(
                    child: DotsIndicator(
                      controller: _controller,
                      itemCount: listImages.length,
                      color: ColorConst.primaryColor,
                      increasedColor: ColorConst.whiteColor,
                      dotSize: Dimensions.w11,
                      dotSpacing: 20,
                      dotIncreaseSize: widget.dotIncreaseSize,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: widget.animationDuration,
                          curve: widget.animationCurve,
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {super.key,
      this.controller,
      this.pageIndex,
      this.itemCount,
      this.onPageSelected,
      this.color,
      this.increasedColor,
      this.dotSize,
      this.dotIncreaseSize,
      this.dotSpacing})
      : super(listenable: controller ?? ValueNotifier(pageIndex));

  // The PageController that this DotsIndicator is representing.
  final PageController? controller;

  /// If page controller is null this index will be used
  final int? pageIndex;

  // The number of items managed by the PageController
  final int? itemCount;

  // Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  // The color of the dots.
  final Color? color;

  // The color of the increased dot.
  final Color? increasedColor;

  // The base size of the dots
  final double? dotSize;

  // The increase in the size of the selected dot
  final double? dotIncreaseSize;

  // The distance between the center of each dot
  final double? dotSpacing;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      controller == null
          ? max(
              0.0,
              1.0 - (pageIndex! - index).abs(),
            )
          : max(
              0.0,
              1.0 -
                  ((controller!.page ?? controller!.initialPage) - index).abs(),
            ),
    );
    double zoom = 1.0 + (dotIncreaseSize! - 1.0) * selectedness;
    final dotColor = zoom > 1.0 ? increasedColor : color;
    return Container(
      // color: Colors.pink,
      padding: const EdgeInsets.only(right: 2, left: 2),
      width: dotSpacing!,
      child: Center(
        child: Material(
          color: dotColor,
          type: MaterialType.circle,
          child: SizedBox(
            // padding: EdgeInsets.only(right: 30),
            // color: ColorConst.pinkDarkColor,

            width: dotSize! * zoom,
            height: dotSize! * zoom,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}

//
// /// An indicator showing the currently selected page of a PageController
// class DotsIndicator extends AnimatedWidget {
//   DotsIndicator(
//       {Key? key,
//       this.controller,
//       this.itemCount,
//       this.onPageSelected,
//       this.color,
//       this.increasedColor,
//       this.dotSize,
//       this.dotIncreaseSize,
//       this.dotSpacing})
//       : super(key: key, listenable: controller!);
//
//   // The PageController that this DotsIndicator is representing.
//   final PageController? controller;
//
//   // The number of items managed by the PageController
//   final int? itemCount;
//
//   // Called when a dot is tapped
//   final ValueChanged<int>? onPageSelected;
//
//   // The color of the dots.
//   final Color? color;
//
//   // The color of the increased dot.
//   final Color? increasedColor;
//
//   // The base size of the dots
//   final double? dotSize;
//
//   // The increase in the size of the selected dot
//   final double? dotIncreaseSize;
//
//   // The distance between the center of each dot
//   final double? dotSpacing;
//
//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((controller!.page ?? controller!.initialPage) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (dotIncreaseSize!) * selectedness;
//     final dotColor = zoom > 1.0 ? increasedColor : color;
//     return Container(
//       // color: Colors.pink,
//       padding: const EdgeInsets.only(right: 8, left: 8),
//       width: dotSpacing!,
//       child: Center(
//         child: Material(
//           color: dotColor,
//           type: MaterialType.circle,
//           child: Container(
//             // padding: const EdgeInsets.only(right: 30),
//             // color: ColorConst.pinkDarkColor,
//             width: dotSize! * zoom,
//             height: dotSize! * zoom,
//             child: InkWell(
//               onTap: () => onPageSelected!(index),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List<Widget>.generate(itemCount!, _buildDot),
//     );
//   }
//
//
//
//
//
//
//
//
//
// }
