import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnui/constants/drawer.dart';
import 'package:learnui/constants/theme.dart';

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}

class DrawerContent extends StatefulWidget {
  const DrawerContent(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  List<DrawerList> drawerList = [
    DrawerList(
      index: DrawerIndex.home,
      labelName: 'Home',
      icon: const Icon(Icons.home),
    ),
    DrawerList(
      index: DrawerIndex.help,
      labelName: 'Help',
      isAssetsImage: true,
      imageName: 'assets/images/supportIcon.png',
    ),
    DrawerList(
      index: DrawerIndex.feedBack,
      labelName: 'FeedBack',
      icon: const Icon(Icons.help),
    ),
    DrawerList(
      index: DrawerIndex.invite,
      labelName: 'Invite Friend',
      icon: const Icon(Icons.group),
    ),
    DrawerList(
      index: DrawerIndex.share,
      labelName: 'Rate the app',
      icon: const Icon(Icons.share),
    ),
    DrawerList(
      index: DrawerIndex.about,
      labelName: 'About Us',
      icon: const Icon(Icons.info),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildUserInfo(),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildMenuItem(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          buildBottom(context),
        ],
      ),
    );
  }

  Widget buildUserInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: widget.iconAnimationController!,
              builder: (BuildContext context, Widget? child) {
                return ScaleTransition(
                  scale: AlwaysStoppedAnimation<double>(
                      1.0 - (widget.iconAnimationController!.value) * 0.2),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation<double>(
                        Tween<double>(begin: 0.0, end: 24.0)
                                .animate(CurvedAnimation(
                                  parent: widget.iconAnimationController!,
                                  curve: Curves.fastOutSlowIn,
                                ))
                                .value /
                            360),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.grey.withOpacity(0.6),
                            offset: const Offset(2.0, 4.0),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        child: Image.asset('assets/images/userImage.png'),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 4),
              child: Text(
                'Chris Hemsworth',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Sign Out',
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppTheme.darkText,
            ),
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onTap: () {
            onTapped();
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }

  void onTapped() {
    if (kDebugMode) {
      print('Doing Something...');
    } // Print to console.
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }

  Widget buildMenuItem(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
