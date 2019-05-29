import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wechat/constants.dart';

class ProfileHeader extends StatelessWidget {

  _buildAvatar() {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: 'https://randomuser.me/api/portraits/men/10.jpg',
        placeholder: Constants.ProfileAvatarDefaultIocn,
        width: Constants.ProfileHeaderIconSize,
        height: Constants.ProfileHeaderIconSize,
      ),
    );
  }

  _buildNameAndDesc() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('David',
            style: TextStyle(color: Color(AppColors.TitleColor), fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10.0),
          Text('微信号: xxxxxxx', style: TextStyle(color: Color(AppColors.DescTextColor), fontSize: 13.0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 33.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildAvatar(),
            SizedBox(width: 10.0),
            _buildNameAndDesc(),
            Icon(IconData(0xe620, fontFamily: Constants.IconFontFamily),
              size: 22.0,
              color: Color(AppColors.TabIconNormal),
            ),
            SizedBox(width: 5.0),
            Icon(IconData(0xe664, fontFamily: Constants.IconFontFamily),
              size: 22.0,
              color: Color(AppColors.TabIconNormal),
            ),
          ],
        ),
      ),
      onTap: () {
        Fluttertoast.showToast(msg: '点击了个人信息', gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
      },
    );
  }
}