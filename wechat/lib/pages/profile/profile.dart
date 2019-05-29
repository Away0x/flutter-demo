import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wechat/constants.dart';
import './part/profile_header.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  _buildSeparate() {
    return SizedBox(height: 20.0);
  }

  _buildLineButton(String imgPath, String title) {
    return FlatButton(
      color: Colors.white,
      padding: EdgeInsets.all(0),
      child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(AppColors.DividerColor), width: Constants.DividerWidth),
        ),
      ),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
      child: Row(
        children: <Widget>[
          Image.asset(imgPath, width: 24, height: 24),
          SizedBox(width: 20),
          Expanded(child: Text(title)),
          Icon(
            IconData(0XE664, fontFamily: Constants.IconFontFamily),
            size: 22.0,
            color: Color(AppColors.TabIconNormal),
          ),
        ],
      ),
    ),
      onPressed: () {
        Fluttertoast.showToast(msg: title, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: Column(
        children: <Widget>[
          ProfileHeader(),
          _buildSeparate(),
          _buildLineButton('assets/images/ic_wallet.png', '钱包'),
          _buildSeparate(),
          _buildLineButton('assets/images/ic_collections.png', '收藏'),
          _buildLineButton('assets/images/ic_album.png', '相册'),
          _buildLineButton('assets/images/ic_cards_wallet.png', '卡包'),
          _buildLineButton('assets/images/ic_emotions.png', '表情'),
          _buildSeparate(),
          _buildLineButton('assets/images/ic_settings.png', '设置'),
        ],
      )
    );
  }
}