import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationServices {
  void goTo(
    BuildContext context, {
    required Widget page,
    bool replace = false,
    bool clean = false,
    bool useAnimation = false,
  }) {
    if (replace) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 500),
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
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 500),
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
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 500),
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

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
