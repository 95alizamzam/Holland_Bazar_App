import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationServices {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navKey => _navKey;

  void goTo({
    required Widget page,
    bool replace = false,
    bool clean = false,
  }) {
    if (replace) {
      Navigator.of(_navKey.currentState!.context).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
      );
    } else if (clean) {
      Navigator.of(_navKey.currentState!.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    } else {
      Navigator.of(_navKey.currentState!.context).push(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  void goBack() {
    Navigator.of(_navKey.currentState!.context).pop();
  }
}
