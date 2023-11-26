import 'package:flutter/material.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/presentation/pages/on_boarding_page.dart';
import 'package:tsc_app/core/presentation/pages/start_up_page.dart';
import 'package:tsc_app/core/services/firebase/auth_services.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/features/auth/presentation/pages/login_page.dart';

import '../../services/hive_config.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  final route = getIt<NavigationServices>();
  final hiveHelper = getIt<HiveConfig>();
  final authService = getIt<FirebaseAuthServices>();

  @override
  void initState() {
    super.initState();
    final isFirstRun = hiveHelper.getData(key: HiveKeys.isFirstRun);

    if (isFirstRun == null || isFirstRun) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => route.goTo(context, page: const OnBoardingPage(), clean: true),
      );
    } else {
      authService.auth.idTokenChanges().listen((user) {
        if (user == null) {
          route.goTo(context, page: const LoginPage(), clean: true);
        } else {
          route.goTo(context, clean: true, page: const StartUpPage());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Image(
          image: AssetImage("assets/logo/logo.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
