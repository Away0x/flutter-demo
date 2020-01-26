import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  final bool isEnable;
  final double width;
  final void Function(String value) onSubmit;

  SearchBar({
    Key key,
    this.onSubmit,
    this.isEnable = true,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 32,
      child: TextField(
        enabled: isEnable,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.search),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(19.5),
          ),
        ),
        onSubmitted: onSubmit,
      ),
    );
  }
}