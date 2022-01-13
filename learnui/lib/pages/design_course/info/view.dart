import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class DesignCourseInfoPage extends StatefulWidget {
  const DesignCourseInfoPage({Key? key}) : super(key: key);

  @override
  _DesignCourseInfoPageState createState() => _DesignCourseInfoPageState();
}

class _DesignCourseInfoPageState extends State<DesignCourseInfoPage>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  late AnimationController animationController;
  late Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tempHeight = Get.height - (Get.width / 1.2) + 24.0;

    return Container(
      color: DesignCourseTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/design_course/webInterFace.png'),
                ),
              ],
            ),
            Positioned(
              top: (Get.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildContent(tempHeight),
            ),
            Positioned(
              top: (Get.width / 1.2) - 24.0 - 35,
              right: 35,
              child: _buildLikeButton(),
            ),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(double height) {
    return Container(
      decoration: BoxDecoration(
        color: DesignCourseTheme.nearlyWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        boxShadow: [
          BoxShadow(
            color: DesignCourseTheme.grey.withOpacity(0.2),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: infoHeight,
              maxHeight: height > infoHeight ? height : infoHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                _buildRating(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity1,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        _buildTimeBox('24', 'Classe'),
                        _buildTimeBox('2hours', 'Time'),
                        _buildTimeBox('24', 'Seat'),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildText()),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity3,
                  child: _buildBottomButton(),
                ),
                SizedBox(height: Get.mediaQuery.padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 32.0, left: 18, right: 16),
      child: Text(
        'Web Design\nCourse',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          letterSpacing: 0.27,
          color: DesignCourseTheme.darkerText,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            '\$28.99',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseTheme.nearlyBlue,
            ),
          ),
          Row(
            children: const [
              Text(
                '4.3',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: DesignCourseTheme.grey,
                ),
              ),
              Icon(
                Icons.star,
                color: DesignCourseTheme.nearlyBlue,
                size: 24,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimeBox(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DesignCourseTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity2,
      child: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Text(
          'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 14,
            letterSpacing: 0.27,
            color: DesignCourseTheme.grey,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Container(
              decoration: BoxDecoration(
                color: DesignCourseTheme.nearlyWhite,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border:
                    Border.all(color: DesignCourseTheme.grey.withOpacity(0.2)),
              ),
              child: const Icon(
                Icons.add,
                color: DesignCourseTheme.nearlyBlue,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: DesignCourseTheme.nearlyBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: DesignCourseTheme.nearlyBlue.withOpacity(0.5),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Join Course',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 0.0,
                    color: DesignCourseTheme.nearlyWhite,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
      child: Card(
        color: DesignCourseTheme.nearlyBlue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        elevation: 10.0,
        child: const SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Icon(
              Icons.favorite,
              color: DesignCourseTheme.nearlyWhite,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: SizedBox(
        width: AppBar().preferredSize.height,
        height: AppBar().preferredSize.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
            child: const Icon(
              Icons.arrow_back_ios,
              color: DesignCourseTheme.nearlyBlack,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }
}
