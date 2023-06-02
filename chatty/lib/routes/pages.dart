import 'package:chatty/pages/chat/index.dart';
import 'package:chatty/pages/voicecall/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:chatty/pages/profile/index.dart';
import 'package:chatty/pages/signin/index.dart';
import 'package:chatty/pages/welcome/index.dart';
import 'package:chatty/pages/message/index.dart';
import 'package:chatty/pages/contact/index.dart';

import './middlewares/middlewares.dart';
import 'names.dart';
import 'observers.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.Message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.Profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.Contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.Chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.VoiceCall,
      page: () => const VoicecallPage(),
      binding: VoicecallBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
  ];
}
