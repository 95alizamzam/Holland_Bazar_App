import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextFormField(
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        enabled: true,
        decoration: InputDecoration(
          enabled: true,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 13.h,
          ),
          fillColor: Colors.white,
          hintText: "Search",
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF959FA8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9.r),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(9.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(9.r),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
      ),
    );
  }
}
