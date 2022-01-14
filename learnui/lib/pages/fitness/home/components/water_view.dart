import 'package:flutter/material.dart';

class WaterView extends StatefulWidget {
  const WaterView({
    Key? key,
    required this.mainScreenAnimationController,
    required this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('WaterView'),
    );
  }
}
