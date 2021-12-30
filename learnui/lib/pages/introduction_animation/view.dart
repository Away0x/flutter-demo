import 'package:flutter/material.dart';

class IntroductionAnimationPage extends StatelessWidget {
  const IntroductionAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('IntroductionAnimationPage'),
        ),
      ),
    );
  }
}
