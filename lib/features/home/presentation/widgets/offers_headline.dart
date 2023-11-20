import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/fonts/font.dart';

class OffersHeadLine extends StatelessWidget {
  const OffersHeadLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 16.w,
      ),
      child: Row(
        children: [
          Text(
            'Offers',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: AppFonts.metropolisRegular,
              color: const Color(0xFF40484E),
            ),
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
