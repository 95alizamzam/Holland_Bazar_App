import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/presentation/pages/logo_page.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/core/thems/light_theme.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/bloc.dart';
import 'core/services/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();
  await Hive.initFlutter();
  await getIt<HiveConfig>().init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => getIt<CartBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Tsc Test App',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationServices.navKey,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          home: const LogoPage(),
        ),
      ),
    );
  }
}
