import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class Application {

  static Router router;

  static navigateTo(BuildContext context, String route, {
     TransitionType transition = TransitionType.native,
  }) {
    router.navigateTo(context, route, transition: transition);
  }
}