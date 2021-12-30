import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/constants/drawer.dart';
import 'package:learnui/constants/theme.dart';

import 'content.dart';

class DrawerLayout extends StatefulWidget {
  const DrawerLayout({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;

  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  bool isOpen = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController?.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);

    scrollController!.addListener(() {
      if (scrollController!.offset <= 0) {
        if (!isOpen) {
          setState(() {
            isOpen = true;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(
          0.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
        );
      } else if (scrollController!.offset > 0 &&
          scrollController!.offset < widget.drawerWidth.floor()) {
        iconAnimationController?.animateTo(
          (scrollController!.offset * 100 / (widget.drawerWidth)) / 100,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        if (isOpen) {
          setState(() {
            isOpen = false;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: Get.height,
          width: Get.width + widget.drawerWidth,
          child: Row(
            children: [
              _buildDrawer(context),
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.6),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  // 内容区域
                  child: Stack(
                    children: [
                      // 当抽屉打开时, 内容忽略事件
                      IgnorePointer(
                        ignoring: isOpen || false,
                        child: widget.screenView,
                      ),
                      // 抽屉打开时, 用于捕获内容区域的点击事件
                      if (isOpen)
                        InkWell(
                          onTap: () => onDrawerClick(),
                        ),
                      // 打开关闭抽屉的按钮
                      _buildActionButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top + 8, left: 8),
      child: SizedBox(
        width: AppBar().preferredSize.height - 8,
        height: AppBar().preferredSize.height - 8,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
            child: Center(
              // if you use your own menu view UI you add form initialization
              child: widget.menuView ??
                  AnimatedIcon(
                      icon: widget.animatedIconData ?? AnimatedIcons.arrow_menu,
                      progress: iconAnimationController!),
            ),
            onTap: () {
              // 获取焦点
              FocusScope.of(context).requestFocus(FocusNode());
              onDrawerClick();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return SizedBox(
      width: widget.drawerWidth,
      height: Get.height,
      child: AnimatedBuilder(
        animation: iconAnimationController!,
        builder: (context, child) {
          return Transform(
            transform:
                Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
            child: DrawerContent(
              screenIndex: widget.screenIndex ?? DrawerIndex.home,
              iconAnimationController: iconAnimationController,
              callBackIndex: (DrawerIndex indexType) {
                onDrawerClick();
                try {
                  widget.onDrawerCall!(indexType);
                } catch (_) {}
              },
            ),
          );
        },
      ),
    );
  }

  // 打开/关闭抽屉
  void onDrawerClick() {
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
