import 'package:flutter/material.dart';

class FitnessPage extends StatelessWidget {
  const FitnessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('FitnessPage'),
        ),
      ),
    );
  }
}
