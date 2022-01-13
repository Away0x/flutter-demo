import 'package:flutter/material.dart';

import '../models/category.dart';
import 'popular_card.dart';

class PopularList extends StatefulWidget {
  const PopularList({
    Key? key,
    this.callBack,
  }) : super(key: key);

  final Function()? callBack;

  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: _getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          return GridView(
            padding: const EdgeInsets.all(8),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 32.0,
              crossAxisSpacing: 32.0,
              childAspectRatio: 0.8,
            ),
            children: List.generate(Category.popularCourseList.length, (index) {
              final int count = Category.popularCourseList.length;
              final animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Interval(
                    (1 / count) * index,
                    1.0,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
              );
              animationController.forward();

              return PopularCard(
                callback: widget.callBack,
                category: Category.popularCourseList[index],
                animation: animation,
                animationController: animationController,
              );
            }),
          );
        },
      ),
    );
  }

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
