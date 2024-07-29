import 'package:flutter/material.dart';
import 'package:my_chat/pages/home_page.dart';
import 'package:my_chat/pages/ligin_page.dart';
import 'package:my_chat/pages/rerister_page.dart';

class NavigationService {
  late final GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/register": (context) => RegisterPage(),
    "/home": (context) => HomePage(),
  };

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushName(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementName(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
