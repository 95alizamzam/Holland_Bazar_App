import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.onPress,
    required this.text,
    this.bgColor,
    this.style,
  });

  final VoidCallback onPress;
  final String text;
  final Color? bgColor;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? ElevatedButton.styleFrom(backgroundColor: bgColor),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
