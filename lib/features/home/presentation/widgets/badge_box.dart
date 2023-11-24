import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tsc_app/core/services/firebase/cloud_firestore.dart';

import '../../../../core/di/setup.dart';
import '../../../../core/services/hive_config.dart';

class BadgeBox extends StatefulWidget {
  const BadgeBox({super.key});

  @override
  State<BadgeBox> createState() => _BadgeBoxState();
}

class _BadgeBoxState extends State<BadgeBox> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  int count = 0;
  @override
  void initState() {
    super.initState();
    final id = getIt<HiveConfig>().getUserId();
    if (id != null) {
      stream = getIt<CloudFireStoreService>().listenToCartChanges(
        cartId: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data?.docs ?? [];
          count = items.length;
        }

        return badges.Badge(
          showBadge: count > 0,
          badgeContent: Text(
            count.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Color(0xFFFE5A01),
            elevation: 4,
          ),
          position: badges.BadgePosition.topEnd(
            end: -4,
            top: -8,
          ),
          child: const Center(
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage("assets/home_page/cart_icon.png"),
            ),
          ),
        );
      },
    );
  }
}
