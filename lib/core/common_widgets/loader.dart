import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.progress});

  final double? progress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xFFFE5A01),
        backgroundColor: Colors.white,
        value: progress,
      ),
    );
  }
}
