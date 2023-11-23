import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmerLoader extends StatelessWidget {
  const CartShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      itemCount: 4,
      itemBuilder: (c, i) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 9.h),
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EBE8),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.white,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 100,
                        height: 10,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 70,
                        height: 10,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 40,
                        height: 10,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 20.w,
                      height: 6.h,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
