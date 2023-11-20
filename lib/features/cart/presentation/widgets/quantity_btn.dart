import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityBtn extends StatelessWidget {
  const QuantityBtn({super.key, required this.onPress, required this.icon});

  final VoidCallback onPress;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 25.w,
        height: 25.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFFE5A01),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              color: Color(0xFFFE5A01),
              blurRadius: 2,
              spreadRadius: 1.3,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
