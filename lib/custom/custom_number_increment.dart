import 'package:flutter/material.dart';
import 'package:slately/core/basic_features.dart';

class NumberIncrementAnimation extends StatefulWidget {
  final int targetNumber; // The number you want to animate to
  final TextStyle? textStyle;
  const NumberIncrementAnimation({super.key, required this.targetNumber,  this.textStyle});

  @override
  NumberIncrementAnimationState createState() =>
      NumberIncrementAnimationState();
}

class NumberIncrementAnimationState extends State<NumberIncrementAnimation>
    with SingleTickerProviderStateMixin {
  int currentNumber = 0;

  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // Use an easing curve (e.g., Curves.easeOut)
    );

    _animation = IntTween(begin: currentNumber, end: widget.targetNumber)
        .animate(curvedAnimation);

    _animation.addListener(() {
      setState(() {
        currentNumber = _animation.value;
      });
    });

    // Start the animation when the widget is initialized
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currentNumber',
      style: widget.textStyle ??  fontStyleSemiBold28.apply(color: ColorConst.primaryColor),
    );
  }
}
