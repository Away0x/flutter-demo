import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {

  final String title;
  final bool hasLeading;
  final TabBar tabbar; 
  final Widget body;
  final Color backgroundColor;

  RootPage({
    Key key,
    this.title,
    this.hasLeading = true,
    this.tabbar,
    this.body,
    this.backgroundColor = const Color(0xFF33C9FF),
  });

  AppBar _buildAppBar() {
    if (title == null) return null;

    Builder leading = Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );

    return AppBar(
      elevation: 0.0,
      backgroundColor: backgroundColor,
      leading: hasLeading ? leading : null,
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      bottom: tabbar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: body,
    );
  }
}
