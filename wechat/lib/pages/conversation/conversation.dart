import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wechat/model/conversation.dart';
import 'part/conversation_item.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  final ConversationPageData data = ConversationPageData.mock();

  Widget _buildItem(BuildContext context, int index) {
    var item = data.conversations[index];

    return GestureDetector(
      child: ConversationItem(conversation: item),
      onTap: () {
        Fluttertoast.showToast(msg: item.title, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.conversations.length,
      itemBuilder: _buildItem,
    );
  }
}