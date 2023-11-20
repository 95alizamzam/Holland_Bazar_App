import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/common_widgets/cached_image.dart';

import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/fonts/font.dart';
import 'package:tsc_app/core/services/firebase/storage_service.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAddPress,
  });

  final Product product;
  final VoidCallback onAddPress;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final storage = getIt<FireBaseStorageService>();
  String? url;
  @override
  void initState() {
    super.initState();
    storage.getDownloadUrl("products/${widget.product.imageUrl}").then((value) {
      setState(() => url = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (url != null)
            Padding(
              padding: const EdgeInsets.all(4),
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 147.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8EBE8),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: CustomCachedImage(url: url!),
                  ),
                  Positioned(
                    top: 6.h,
                    right: 2.w,
                    child: InkWell(
                      onTap: widget.onAddPress,
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFFB7552),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "${widget.product.discount}%",
                  style: TextStyle(
                    color: const Color(0xFF28AE61),
                    fontFamily: AppFonts.metropolisRegular,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.product.description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xFF392F2D),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 6.h),
                Text(
                  widget.product.weight,
                  style: TextStyle(
                    color: const Color(0xFF999594),
                    fontFamily: AppFonts.metropolisRegular,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "\$${widget.product.price}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(0xFFFB7552),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      "${widget.product.rating}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(0xFFE2D7D4),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: 7.w),
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFA60F),
                    )
                  ],
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
