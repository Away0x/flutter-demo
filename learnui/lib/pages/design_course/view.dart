import 'package:flutter/material.dart';

class DesignCoursePage extends StatelessWidget {
  const DesignCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('DesignCoursePage'),
        ),
      ),
    );
  }
}
