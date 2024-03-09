import 'package:flutter/material.dart';

import '../basic_features.dart';

class MyErrorWidget extends StatelessWidget {
  final String? message;
  final Function? onPress;

  const MyErrorWidget({super.key, this.message, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message!,
            textAlign: TextAlign.center,
            style: fontStyleRegular14.apply(color: ColorConst.dialogRedColor)),
      ),
    );
  }
}

class MyEmptyWidget extends StatelessWidget {
  final String? message;
  final Function? onPress;

  const MyEmptyWidget({super.key, this.message, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message!,
            textAlign: TextAlign.center,
            style: fontStyleRegular14.apply(color: ColorConst.textColor)),
      ),
    );
  }
}
