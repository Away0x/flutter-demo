import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wechat/constants.dart';
import 'package:wechat/model/contact.dart';
import 'package:wechat/pages/contact/part/contact_item.dart';

const INDEX_BAR_WORDS = [
  "↑", "☆",
  "A", "B", "C", "D", "E", "F", "G",
  "H", "I", "J", "K", "L", "M", "N",
  "O", "P", "Q", "R", "S", "T", "U",
  "V", "W", "X", "Y", "Z"
];
class ContactPage extends StatefulWidget {

  Color indexBarBackgroundColor = Colors.transparent;
  String currentLetter = '';

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final List<Contact> data = ContactsPageData.mock();
  ScrollController scrollController;
  final Map letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // 计算 index bar item 的定位位置
    var totalPos = contactsButtons.length * ContactItem.height(false);
    for (var i = 0; i < data.length; i++) {
      bool hasGroupTitle = true;
      var item = data[i];
      if (i >0 && item.nameIndex.compareTo(data[i - 1].nameIndex) == 0) {
        hasGroupTitle = false;
      }

      if (hasGroupTitle) {
        letterPosMap[item.nameIndex] = totalPos;
      }
      totalPos += ContactItem.height(hasGroupTitle);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  String getLetter(BuildContext context, double tileHeight, Offset gloalPos) {
    RenderBox box = context.findRenderObject();
    var local = box.globalToLocal(gloalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    // print(INDEX_BAR_WORDS[index]);
    return INDEX_BAR_WORDS[index];
  }

  _buildListView() {
    return ListView.builder(
      controller: scrollController,
      itemCount: data.length + contactsButtons.length,
      itemBuilder: (BuildContext context, int index) {
        ContactItem child;

        if (index < contactsButtons.length) {
          var item = contactsButtons[index];
          child = ContactItem(avatar: item['avatar'], title: item['name']);
        } else {
          bool hasGroupTitle = true;
          int itemIndex = index - contactsButtons.length;
          var item = data[itemIndex];

          if (itemIndex >= 1 && item.nameIndex == data[itemIndex - 1].nameIndex) {
            hasGroupTitle = false;
          }

          child = ContactItem(
            avatar: item.avatar,
            title: item.name,
            groupTitle: hasGroupTitle ? item.nameIndex : null,
          );
        }

        return GestureDetector(
          child: child,
          onTap: () {
            Fluttertoast.showToast(msg: child.title, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
          },
        );
      },
    );
  }

  _buildIndexBar() {
    return Positioned(
      width: Constants.IndexBarWidth,
      right: 0.0,
      top: 0.0,
      bottom: 0.0,
      child: Container(
        color: widget.indexBarBackgroundColor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final totalHeight = constraints.biggest.height;
            final tileHeight = totalHeight / INDEX_BAR_WORDS.length;

            return GestureDetector(
              child: Column(
                children: INDEX_BAR_WORDS.map((String w) {
                  return Expanded(child: Text(w));
                }).toList(),
              ),
              onVerticalDragDown: (DragDownDetails details) {
                setState(() {
                  widget.indexBarBackgroundColor = Colors.black26;
                  widget.currentLetter = getLetter(context, tileHeight, details.globalPosition);
                  jumpToIndex(widget.currentLetter);
                });
              },
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  widget.indexBarBackgroundColor = Colors.transparent;
                  widget.currentLetter = null;
                });
              },
              onVerticalDragCancel: () {
                setState(() {
                  widget.indexBarBackgroundColor = Colors.transparent;
                  widget.currentLetter = null;
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  widget.currentLetter = getLetter(context, tileHeight, details.globalPosition);
                  jumpToIndex(widget.currentLetter);
                });
              },
            );
          },
        ),
      ),
    );
  }

  _buildIndexToast() {
    return Center(
      child: Container(
        width: Constants.IndexLetterBoxSize,
        height: Constants.IndexLetterBoxSize,
        decoration: BoxDecoration(
          color: AppColors.IndexLetterBoxBgColor,
          borderRadius: BorderRadius.all(Radius.circular(Constants.IndexLetterBoxRadius)),
        ),
        child: Center(
          child: Text(widget.currentLetter, style: AppStyles.IndexLetterBoxTextStyle),
        ),
      ),
    );
  }

  // 跳转 index
  jumpToIndex(String letter) {
    final pos = letterPosMap[letter];
    if (pos == null) { return; }
    scrollController.animateTo(pos, curve: Curves.easeInOut, duration: Duration(microseconds: 200));
  } 

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _buildListView(),
      _buildIndexBar(),
    ];

    if (widget.currentLetter != null && widget.currentLetter.isNotEmpty) {
      children.add(_buildIndexToast());
    }

    return Stack(
      children: children,
    );
  }
}