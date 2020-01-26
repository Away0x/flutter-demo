import 'package:flutter/material.dart';

class SearchWord extends StatelessWidget {

  final String word;

  SearchWord({
    Key key,
    this.word
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0x1f000000),
          borderRadius: BorderRadius.circular(4)
      ),
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Text(
        this.word,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white
        ),
      ),
    );
  }

}