import 'package:flutter/material.dart';

import 'package:oschina/application.dart';

class MyDrawer extends StatelessWidget {

  final String headImgPath;
  final List<String> menuTitles;
  final List<IconData> menuIcons;

  MyDrawer({
    Key key,
    @required this.headImgPath,
    @required this.menuTitles,
    @required this.menuIcons,
  }) : assert(headImgPath != null),
    assert(menuTitles != null),
    assert(menuIcons != null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        padding: const EdgeInsets.all(0), //解决状态栏问题
        itemCount: menuTitles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          // head img
          if (index == 0) {
            return Image.asset(headImgPath, fit: BoxFit.cover);
          }

          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              switch (index) {
              case 0:
                _pushRoute(context, '/publish');
                break;
              case 1:
                _pushRoute(context, '/black_house');
                break;
              case 2:
                _pushRoute(context, '/about');
                break;
              case 3:
                _pushRoute(context, '/settings');
                break;
              default:
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Divider(height: 0);
          }

          return Divider(height: 1);
        },
      ),
    );
  }

  _pushRoute(BuildContext context, String route) {
    Navigator.of(context).pop(); // 把 drawer 收起
    Application.navigateTo(context, route);
  }
}