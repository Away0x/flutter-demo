import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 返回按钮
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('登录'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      ),
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      body: Center(child: Text('登录')),
    );
  }
}