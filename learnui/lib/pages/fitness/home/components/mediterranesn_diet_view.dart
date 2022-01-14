import 'package:flutter/material.dart';

class MediterranesnDietView extends StatelessWidget {
  const MediterranesnDietView({
    Key? key,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('MediterranesnDietView'),
    );
  }
}
