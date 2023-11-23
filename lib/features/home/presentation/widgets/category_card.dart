import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tsc_app/core/common_widgets/cached_image.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/firebase/storage_service.dart';
import 'package:tsc_app/features/home/domain/entities/category.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  String? image;
  @override
  void initState() {
    super.initState();

    getIt<FireBaseStorageService>()
        .getDownloadUrl("categories/${widget.category.imageUrl}")
        .then((value) {
      setState(() => image = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 75.w,
          height: 75.h,
          margin: EdgeInsets.symmetric(horizontal: 7.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: image == null
              ? categoryCardLoader()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CustomCachedImage(
                    url: image!,
                    fit: BoxFit.fill,
                  ),
                ),
        ),
        SizedBox(height: 5.h),
        Text(
          widget.category.name,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFF40484E),
          ),
        ),
      ],
    );
  }

  Widget categoryCardLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white.withOpacity(.4),
      enabled: true,
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 1),
      child: SizedBox(
        width: 75.w,
        height: 75.h,
        child: Container(
          width: 75.w,
          height: 75.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
