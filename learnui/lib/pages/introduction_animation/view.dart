import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/splash_view.dart';
import 'components/relax_view.dart';
import 'components/care_view.dart';
import 'components/mood_diary_view.dart';
import 'components/welcome_view.dart';
import 'components/skip_button.dart';
import 'components/next_button.dart';

class IntroductionAnimationPage extends StatefulWidget {
  const IntroductionAnimationPage({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationPageState createState() =>
      _IntroductionAnimationPageState();
}

class _IntroductionAnimationPageState extends State<IntroductionAnimationPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(animationController: _animationController!),
            RelaxView(animationController: _animationController!),
            CareView(animationController: _animationController!),
            MoodDiaryView(animationController: _animationController!),
            WelcomeView(animationController: _animationController!),
            SkipButton(
              animationController: _animationController!,
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
            ),
            NextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    final controller = _animationController!;
    if (controller.value >= 0 && controller.value <= 0.2) {
      controller.animateTo(0.0);
    } else if (controller.value > 0.2 && controller.value <= 0.4) {
      controller.animateTo(0.2);
    } else if (controller.value > 0.4 && controller.value <= 0.6) {
      controller.animateTo(0.4);
    } else if (controller.value > 0.6 && controller.value <= 0.8) {
      controller.animateTo(0.6);
    } else if (controller.value > 0.8 && controller.value <= 1.0) {
      controller.animateTo(0.8);
    }
  }

  void _onNextClick() {
    final controller = _animationController!;
    if (controller.value >= 0 && controller.value <= 0.2) {
      controller.animateTo(0.4);
    } else if (controller.value > 0.2 && controller.value <= 0.4) {
      controller.animateTo(0.6);
    } else if (controller.value > 0.4 && controller.value <= 0.6) {
      controller.animateTo(0.8);
    } else if (controller.value > 0.6 && controller.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Get.back();
  }
}
