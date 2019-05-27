import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wechat/constants.dart';
import 'package:wechat/model/conversation.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;

  const ConversationItem({Key key, @required this.conversation});

  _buildAvatar() {
    Widget avatar;
    if (conversation.isAvatarFromNet()) {
      avatar = CachedNetworkImage(
        imageUrl: conversation.avatar,
        placeholder: Constants.ConversationAvatarDefaultIocn,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ContactAvatarSize,
      );
    }

    if (conversation.unreadMsgCount <= 0) {
      return avatar;
    }

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        avatar,
        Positioned(
          right: -6.0,
          top: -6.0,
          child: Container(
            width: Constants.UnReadMsgNotifyDotSize,
            height: Constants.UnReadMsgNotifyDotSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2.0),
              color: Color(AppColors.NotifyDotBgColor),
            ),
            child: Text(conversation.unreadMsgCount.toString(), style: AppStyles.UnreadMsgCountDotStyle),
          ),
        ),
      ],
    );
  }

  _buildMuteIcon() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Icon(
        IconData(0xe78b, fontFamily: Constants.IconFontFamily),
        color: conversation.isMute ? Color(AppColors.ConversationMuteIconColor) : Colors.transparent,
        size: Constants.ConversationMuteIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItemBgColor),
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: Constants.DividerWidth,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildAvatar(),
          Container(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(conversation.title, style: AppStyles.TitleStyle),
                Text(conversation.desc, style: AppStyles.DescStyle),
              ],
            ),
          ),
          Container(width: 10.0),
          Column(
            children: <Widget>[
              Text(conversation.updateAt, style: AppStyles.DescStyle),
              _buildMuteIcon(),
            ],
          ),
          // Column(),
        ],
      ),
    );
  }
}