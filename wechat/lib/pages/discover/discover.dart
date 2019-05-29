import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wechat/constants.dart';
import 'package:wechat/model/discover.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const SEPARATE_SIZE = 20.0;
  List<DiscoverItemData> data = discoverData;

  @override
  void initState() {
    super.initState();
  }

  _buildSeparate() {
    return SizedBox(height: SEPARATE_SIZE);
  }

  _buildListItem(DiscoverItemData item) {
    // 下边线
    var deco = BoxDecoration(
      border: item.showBottomDivider ? Border(
        bottom: BorderSide(color: Color(AppColors.DividerColor), width: Constants.DividerWidth)
      ) : null
    );
    
    var body = Container(
      decoration: deco,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
      child: Row(
        children: <Widget>[
          Image.asset(item.icon, width: 24, height: 24),
          SizedBox(width: 20),
          Expanded(child: Text(item.title)),
          Icon(
            IconData(0XE664, fontFamily: Constants.IconFontFamily),
            size: 22.0,
            color: Color(AppColors.TabIconNormal),
          ),
        ],
      ),
    );

    return FlatButton(
      color: Colors.white,
      padding: EdgeInsets.all(0),
      child: body,
      onPressed: () {
        Fluttertoast.showToast(msg: item.title, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: ListView.separated(
        itemCount: discoverData.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          var line = _buildListItem(item);
          
          // 第一行上边有空白
          if (index == 0) {
            return Column(
              children: <Widget>[
                _buildSeparate(),
                line,
              ],
            );
          }

          return line;
        },
        separatorBuilder: (BuildContext context, int index) {
          var item = data[index];
          if (item.showBottomBlank) {
            return _buildSeparate();
          }
          return Container();
        },
      ),
    );
  }
}