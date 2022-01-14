import 'package:flutter/material.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({
    Key? key,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('WorkoutView'),
    );
  }
}
