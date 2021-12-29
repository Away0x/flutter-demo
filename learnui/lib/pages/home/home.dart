import 'package:flutter/material.dart';
import 'package:learnui/constants/theme.dart';

import 'components/drawer_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerLayout(
            drawerWidth:
                MediaQuery.of(context).size.width * 0.75, // 抽屉宽度占屏幕 0.75
            screenView: const Text('asdasd'),
          ),
        ),
      ),
    );
  }
}
