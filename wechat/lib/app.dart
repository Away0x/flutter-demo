import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wechat/constants.dart';

import 'package:wechat/pages/conversation/conversation.dart';
import 'package:wechat/pages/contact/contact.dart';
import 'package:wechat/pages/discover/discover.dart';
import 'package:wechat/pages/profile/profile.dart';

import 'package:wechat/components/navigation_view/navigation_view.dart';

enum PopupActions {
  GROUP_CHAT,
  ADD_FRIEND,
  QR_SCAN,
  PAYMENT,
}

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {

  PageController _pageController;
  List<Widget> _pages;
  int _currentPageIndex = 0;
  List<NavigationView> _navigationViews;

  @override
  void initState() {
    super.initState();

    _navigationViews = [
      NavigationView(title: '微信',
        icon: IconData(0xe608, fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe603, fontFamily: Constants.IconFontFamily)),
      NavigationView(title: '通讯录',
        icon: IconData(0xe601, fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe602, fontFamily: Constants.IconFontFamily)),
      NavigationView(title: '发现',
        icon: IconData(0xe600, fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe604, fontFamily: Constants.IconFontFamily)),
      NavigationView(title: '我',
        icon: IconData(0xe607, fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe630, fontFamily: Constants.IconFontFamily)),
    ];

    _pageController = PageController(initialPage: _currentPageIndex);
    _pages = [
      ConversationPage(),
      ContactPage(),
      DiscoverPage(),
      ProfilePage(),
    ];
  }

  _buildPageView() {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _pages[index];
      },
      itemCount: _pages.length,
      controller: _pageController,
      onPageChanged: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
    );
  }

  _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Color(AppColors.TabIconActive),
      currentIndex: _currentPageIndex,
      items: _navigationViews.map((v) => v.item).toList(),
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
          _pageController.jumpToPage(_currentPageIndex);  
        });
      },
    );
  }

  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
          IconData(iconName, fontFamily: Constants.IconFontFamily),
          size: 22.0,
          color: Color(AppColors.AppBarPopupMenuColor),
        ),
        Container(width: 12.0),
        Text(title, style: TextStyle(color: Color(AppColors.AppBarPopupMenuColor)))
      ],
    );
  }

  _buildPopupMenu() {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<PopupActions>>[
          PopupMenuItem(
            value: PopupActions.GROUP_CHAT,
            child: _buildPopupMenuItem(0xe606, '发起群聊'),
          ),
          PopupMenuItem(
            value: PopupActions.ADD_FRIEND,
            child: _buildPopupMenuItem(0x3638, '添加朋友'),
          ),
          PopupMenuItem(
            value: PopupActions.QR_SCAN,
            child: _buildPopupMenuItem(0xe79b, '扫一扫'),
          ),
          PopupMenuItem(
            value: PopupActions.PAYMENT,
            child: _buildPopupMenuItem(0xe658, '收付款'),
          ),
        ];
      },
      onSelected: (PopupActions v) {
        switch (v) {
        case PopupActions.GROUP_CHAT:
          Fluttertoast.showToast(msg: '发起群聊', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
          break;
        case PopupActions.ADD_FRIEND:
          Fluttertoast.showToast(msg: '添加朋友', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
          break;
        case PopupActions.QR_SCAN:
          Fluttertoast.showToast(msg: '扫一扫', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
          break;
        case PopupActions.PAYMENT:
          Fluttertoast.showToast(msg: '收付款', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
          break;
        default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        elevation: 0.0, // 不需要阴影
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe605, fontFamily: Constants.IconFontFamily)),
            onPressed: () =>
              Fluttertoast.showToast(msg: '点击了搜索按钮', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER),
          ),
          Container(width: 16.0),
          _buildPopupMenu(),
          Container(width: 16.0)
        ],
      ),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}