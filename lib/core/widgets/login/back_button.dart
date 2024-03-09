import 'package:flutter/material.dart';

import '../../basic_features.dart';

class LoginBackBtn extends StatelessWidget {
  final Function onPress;

  const LoginBackBtn({required this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          onPress();
        },
        child: Image.asset(
          ImageAsset.icBackButton,
          height: Dimensions.w46,
          width: Dimensions.w46,
        ),
      ),
    );
  }
}

class LoginCloseBtn extends StatelessWidget {
  final Function onPress;

  const LoginCloseBtn({required this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          onPress();
        },
        child: Image.asset(
          ImageAsset.icCloseBtn,
          height: Dimensions.w46,
          width: Dimensions.w46,
        ),
      ),
    );
  }
}

class PlayBtn extends StatelessWidget {
  final Function? onPress;

  const PlayBtn({this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.699999988079071,
      child: CircleAvatar(
          radius: Dimensions.r25,
          backgroundColor: ColorConst.textColor,
          child: const Icon(
            Icons.pause,
            color: Colors.white,
          )),
    );
  }
}

class PaushBtn extends StatelessWidget {
  final Function? onPress;

  const PaushBtn({this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.699999988079071,
      child: CircleAvatar(
          radius: Dimensions.r25,
          backgroundColor: ColorConst.textColor,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
          )),
    );
  }
}
