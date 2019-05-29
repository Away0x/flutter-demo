import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wechat/utils/utils.dart';
import 'package:wechat/constants.dart';

class ContactItem extends StatelessWidget {

  final String avatar;
  final String title;
  final String groupTitle;

  static const double MARGIN_VERTICAL = 10.0;
  static const double GROUP_TITLE_HEIGHT = 24.0;

  ContactItem({
    @required this.avatar,
    @required this.title,
    this.groupTitle,
  });

  static double height(bool hasGroupTitle) {
    final _buttonHeight = MARGIN_VERTICAL * 2 + Constants.ContactAvatarSize + Constants.DividerWidth;
    if (hasGroupTitle) {
      return _buttonHeight + GROUP_TITLE_HEIGHT;
    } else {
      return _buttonHeight;
    }
  }

  _buildAvatarIcon() {
    if (isAvatarFromNet(this.avatar)) {
      return CachedNetworkImage(
        imageUrl: this.avatar,
        placeholder: Constants.ContactAvatarDefaultIocn,
        width: Constants.ContactAvatarSize,
        height: Constants.ContactAvatarSize,
      );
    } else {
      return Image.asset(
        this.avatar,
        width: Constants.ContactAvatarSize,
        height: Constants.ContactAvatarSize,
      );
    }
  }

  _buildLineContent() {
    var content = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: Constants.DividerWidth, color: Color(AppColors.DividerColor)),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildAvatarIcon(),
          SizedBox(width: 10.0),
          Text(title),
        ],
      ),
    );

    if (groupTitle == null) {
      return content;
    }

    return Column(
      children: <Widget>[
        Container(
          height: GROUP_TITLE_HEIGHT,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          color: Colors.black12,
          alignment: Alignment.centerLeft,
          child: Text(groupTitle, style: TextStyle(color: Colors.black45, fontSize: 14.0)),
        ),
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLineContent();
  }
}