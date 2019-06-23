import 'package:flutter/material.dart';

class BlackHousePage extends StatefulWidget {
  @override
  _BlackHousePageState createState() => _BlackHousePageState();
}

class _BlackHousePageState extends State<BlackHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态小黑屋'),
      ),
    );
  }
}