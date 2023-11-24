import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/bloc.dart';
import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/bloc.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/products_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/pages/home_page.dart';

import '../../../features/home/presentation/blocs/products_bloc/bloc.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  List<Widget> screens = [
    const HomePage(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (_) => getIt<ProductsBloc>()..add(GetHomeProductsEvent()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (_) => getIt<CategoriesBloc>()..add(GetHomeCategoriesEvent()),
        ),
        BlocProvider<OffersBloc>(
          create: (_) => getIt<OffersBloc>()..add(GetHomeOffersEvent()),
        ),
      ],
      child: Scaffold(
        appBar: null,
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          color: Colors.white,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color(0xFFC4C4C4),
            selectedItemColor: const Color(0xFFFE5A01),
            onTap: (value) {
              setState(() => currentIndex = value);
            },
            items: NavBarItemsEnum.values.map((e) {
              return BottomNavigationBarItem(
                label: e.label(),
                icon: e.icon(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

enum NavBarItemsEnum {
  home,
  offers,
  favorite,
  hollandGo,
  account;

  String label() {
    final char = name.characters.first.toUpperCase();
    return char + name.substring(1).toLowerCase();
  }

  Widget icon() {
    final IconData icon = switch (this) {
      home => Icons.home,
      offers => Icons.local_offer_outlined,
      favorite => Icons.favorite_border,
      hollandGo => Icons.card_giftcard_outlined,
      account => Icons.person,
    };
    return Icon(icon);
  }
}
