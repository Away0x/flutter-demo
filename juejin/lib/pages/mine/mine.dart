import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MinePage extends StatelessWidget {

  final BorderSide _borderSize = BorderSide(width: 1, color: Color.fromRGBO(215, 217, 220, 1));
  final Color _boxColor = Colors.white;
  final double _iconSize = 26;

  _buildLoginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(color: _boxColor, border: Border(top: _borderSize, bottom: _borderSize)),
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person, color: Colors.white)),
        title: Text('登录/注册'),
        trailing: Icon(Icons.keyboard_arrow_right),
        enabled: true, // 列表项允许交互
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }

  _buildItem(Icon icon, String title, [Function onTap]) {
    return Container(
      decoration: BoxDecoration(color: _boxColor, border: Border(bottom: _borderSize)),
      child: ListTile(
        leading: icon,
        title: Text(title),
        enabled: true,
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('我', style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      body: ListView(
        children: <Widget>[
          _buildLoginButton(context),
          _buildItem(Icon(Icons.notifications, color: Colors.blue, size: _iconSize), '消息中心'),
          _buildItem(Icon(Icons.favorite, color: Colors.green, size: _iconSize), '我喜欢的'),
          _buildItem(Icon(Icons.collections, color: Colors.blue, size: _iconSize), '收藏集'),
          _buildItem(Icon(Icons.shop, color: Colors.orange, size: _iconSize), '已购'),
          _buildItem(Icon(Icons.fingerprint, color: Colors.green, size: _iconSize), '赞过的沸点'),
          _buildItem(Icon(Icons.remove_red_eye, size: _iconSize), '阅读过的文章'),
          _buildItem(Icon(Icons.local_offer, size: _iconSize), '标签管理'),
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: _boxColor, border: Border(top: _borderSize, bottom: _borderSize)),
            child: ListTile(
              leading: Icon(Icons.feedback, size: _iconSize),
              title: Text('意见反馈'),
              enabled: true,
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(color: _boxColor, border: Border(bottom: _borderSize)),
            child: ListTile(
              leading: Icon(Icons.settings, size: _iconSize),
              title: Text('设置'),
              enabled: true,
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ),
        ],
      ),
    );
  }
}