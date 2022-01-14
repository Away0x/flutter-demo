import 'package:flutter/material.dart';

class MealsListView extends StatefulWidget {
  const MealsListView({
    Key? key,
    required this.mainScreenAnimationController,
    required this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('MealsListView'),
    );
  }
}
