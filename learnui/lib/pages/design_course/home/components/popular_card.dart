import 'package:flutter/material.dart';
import 'package:learnui/pages/design_course/theme.dart';
import 'package:learnui/tools/color.dart';

import '../models/category.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
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
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: HexColor('#F8FAFB'),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 16, right: 16),
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 16,
                                        right: 16,
                                        bottom: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                          _buildRating(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 48),
                            ],
                          ),
                        )),
                        const SizedBox(height: 48),
                      ],
                    ),
                    _buildBottomImage(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRating() {
    return Row(
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
    );
  }

  Widget _buildBottomImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: DesignCourseTheme.grey.withOpacity(0.2),
              offset: const Offset(0.0, 0.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          child: AspectRatio(
            aspectRatio: 1.28,
            child: Image.asset(category.imagePath),
          ),
        ),
      ),
    );
  }
}
