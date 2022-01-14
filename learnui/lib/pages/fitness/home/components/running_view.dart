import 'package:flutter/material.dart';

class RunningView extends StatelessWidget {
  const RunningView({
    Key? key,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('RunningView'),
    );
  }
}
