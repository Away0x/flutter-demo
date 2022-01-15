import 'package:flutter/material.dart';
import 'package:learnui/pages/fitness/theme.dart';
import 'package:learnui/tools/color.dart';

import 'wave_view.dart';

class WaterView extends StatefulWidget {
  const WaterView({
    Key? key,
    required this.mainScreenAnimationController,
    required this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: FitnessTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildML(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8, bottom: 16),
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: FitnessTheme.background,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                              ),
                            ),
                            _buildTime(),
                          ],
                        ),
                      ),
                      _buildButtons(),
                      _buildWave(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildML() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 3),
              child: Text(
                '2100',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FitnessTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: FitnessTheme.nearlyDarkBlue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, bottom: 8),
              child: Text(
                'ml',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FitnessTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: FitnessTheme.nearlyDarkBlue,
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4, top: 2, bottom: 14),
          child: Text(
            'of daily goal 3.5L',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FitnessTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.0,
              color: FitnessTheme.darkText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.access_time,
                  color: FitnessTheme.grey.withOpacity(0.5),
                  size: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Last drink 8:26 AM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FitnessTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.0,
                    color: FitnessTheme.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/fitness_app/bell.png'),
                ),
                Flexible(
                  child: Text(
                    'Your bottle is empty, refill it!.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: FitnessTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.0,
                      color: HexColor('#F65283'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return SizedBox(
      width: 34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: FitnessTheme.nearlyWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: FitnessTheme.nearlyDarkBlue.withOpacity(0.4),
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                Icons.add,
                color: FitnessTheme.nearlyDarkBlue,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(
              color: FitnessTheme.nearlyWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: FitnessTheme.nearlyDarkBlue.withOpacity(0.4),
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                Icons.remove,
                color: FitnessTheme.nearlyDarkBlue,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWave() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
      child: Container(
        width: 60,
        height: 160,
        decoration: BoxDecoration(
          color: HexColor('#E8EDFE'),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(80.0),
              bottomLeft: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0),
              topRight: Radius.circular(80.0)),
          boxShadow: [
            BoxShadow(
                color: FitnessTheme.grey.withOpacity(0.4),
                offset: const Offset(2, 2),
                blurRadius: 4),
          ],
        ),
        child: WaveView(
          percentageValue: 60.0,
        ),
      ),
    );
  }
}
