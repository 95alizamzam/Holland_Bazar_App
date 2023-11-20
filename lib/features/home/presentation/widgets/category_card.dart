import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      setState(() {
        image = value;
      });
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
              ? const SizedBox.shrink()
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
}
