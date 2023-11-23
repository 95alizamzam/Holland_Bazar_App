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
    bool useAnimation = false,
  }) {
    if (replace) {
      Navigator.of(_navKey.currentState!.context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, child) {
            if (useAnimation) {
              const start = Offset(0, 1);
              const end = Offset.zero;
              final tween = Tween<Offset>(begin: start, end: end);
              return SlideTransition(position: a.drive(tween), child: child);
            } else {
              return child;
            }
          },
        ),
      );
    } else if (clean) {
      Navigator.of(_navKey.currentState!.context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, child) {
            if (useAnimation) {
              const start = Offset(0, 1);
              const end = Offset.zero;
              final tween = Tween<Offset>(begin: start, end: end);
              return SlideTransition(position: a.drive(tween), child: child);
            } else {
              return child;
            }
          },
        ),
        (route) => false,
      );
    } else {
      Navigator.of(_navKey.currentState!.context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, a, __, child) {
            if (useAnimation) {
              const start = Offset(0, 1);
              const end = Offset.zero;
              final tween = Tween<Offset>(begin: start, end: end);
              return SlideTransition(position: a.drive(tween), child: child);
            } else {
              return child;
            }
          },
        ),
      );
    }
  }

  void goBack() {
    Navigator.of(_navKey.currentState!.context).pop();
  }
}
