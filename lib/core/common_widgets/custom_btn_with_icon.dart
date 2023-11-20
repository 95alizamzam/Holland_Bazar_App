import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtnWithIcon extends StatelessWidget {
  const CustomBtnWithIcon({
    super.key,
    required this.onPress,
    required this.text,
    required this.icon,
    this.bgColor,
    this.style,
  });

  final VoidCallback onPress;
  final String text;
  final Color? bgColor;
  final ButtonStyle? style;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      style: style ?? ElevatedButton.styleFrom(backgroundColor: bgColor),
      onPressed: onPress,
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
      ),
    );
  }
}
