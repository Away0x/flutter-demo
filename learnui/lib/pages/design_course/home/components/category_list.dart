import 'package:flutter/material.dart';

import '../models/category.dart';
import 'category_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
    this.callBack,
  }) : super(key: key);

  final Function()? callBack;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 134,
        width: double.infinity,
        child: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();

            return ListView.builder(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
              itemCount: Category.categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final int count = Category.categoryList.length > 10
                    ? 10
                    : Category.categoryList.length;
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
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

                return CategoryCard(
                  category: Category.categoryList[index],
                  animation: animation,
                  animationController: animationController,
                  callback: widget.callBack,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }
}
