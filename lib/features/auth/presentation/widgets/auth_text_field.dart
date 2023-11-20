import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/fonts/font.dart';

typedef OnValidator = String? Function(String?);

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.action,
    required this.keyboardType,
    required this.hint,
    required this.validator,
    required this.controller,
  });

  final TextInputType keyboardType;
  final TextInputAction action;
  final String hint;
  final OnValidator validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: action,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 34.w,
          vertical: 22.h,
        ),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFFB6B7B7),
          fontFamily: AppFonts.metropolisRegular,
        ),
      ),
      validator: validator,
    );
  }
}
