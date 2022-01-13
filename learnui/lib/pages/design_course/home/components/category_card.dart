import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/tools/color.dart';
import 'package:learnui/pages/design_course/theme.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.animationController,
    required this.animation,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final Category category;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: SizedBox(
                  width: 280,
                  child: Stack(
                    children: [
                      _buildInfo(),
                      _buildImage(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildInfo() {
    return Row(
      children: [
        const SizedBox(width: 48),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: HexColor('#F8FAFB'),
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 48 + 24),
                Expanded(
                  child: Column(
                    children: [
                      _buildTitle(),
                      const Expanded(child: SizedBox()),
                      _buildRating(),
                      _buildPrice(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        category.title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.27,
          color: DesignCourseTheme.darkerText,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${category.lessonCount} lesson',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 12,
              letterSpacing: 0.27,
              color: DesignCourseTheme.grey,
            ),
          ),
          Row(
            children: [
              Text(
                '${category.rating}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: DesignCourseTheme.grey,
                ),
              ),
              const Icon(
                Icons.star,
                color: DesignCourseTheme.nearlyBlue,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$${category.money}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
              color: DesignCourseTheme.nearlyBlue,
            ),
          ),
          InkWell(
            onTap: () {
              Get.defaultDialog(middleText: "Plus");
            },
            child: Container(
              decoration: const BoxDecoration(
                color: DesignCourseTheme.nearlyBlue,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.add,
                  color: DesignCourseTheme.nearlyWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(category.imagePath),
            ),
          )
        ],
      ),
    );
  }
}
