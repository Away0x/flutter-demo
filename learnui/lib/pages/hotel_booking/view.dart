import 'package:flutter/material.dart';

class HotelBookingPage extends StatelessWidget {
  const HotelBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('HotelBookingPage'),
        ),
      ),
    );
  }
}
