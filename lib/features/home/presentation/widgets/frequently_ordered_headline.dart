import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/fonts/font.dart';

class FrequentlyOrderedHeadLine extends StatelessWidget {
  const FrequentlyOrderedHeadLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Frequently Ordered",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: AppFonts.metropolisSemiBold,
                  color: const Color(0xFF40484E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Suggestions Based on your order history ",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: AppFonts.metropolisRegular,
                  color: const Color(0xFF959FA8),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'See all',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: AppFonts.metropolisRegular,
              color: const Color(0xFFFE5A01),
            ),
          ),
          SizedBox(width: 4.w),
          const Icon(
            Icons.arrow_forward_ios,
            size: 10,
            color: Color(0xFFFE5A01),
          ),
        ],
      ),
    );
  }
}
