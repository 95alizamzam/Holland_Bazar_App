import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tsc_app/core/common_widgets/cached_image.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/firebase/storage_service.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  String? image;
  @override
  void initState() {
    super.initState();

    getIt<FireBaseStorageService>()
        .getDownloadUrl("offers/${widget.imageUrl}")
        .then((value) {
      setState(() => image = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 195.h,
      width: 195.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: image == null
          ? offerCardLoader()
          : ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CustomCachedImage(
                url: image!,
                fit: BoxFit.fill,
                placeHolder: Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 195.h,
                    width: 195.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }
}

Widget offerCardLoader() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.white.withOpacity(.4),
    enabled: true,
    direction: ShimmerDirection.ltr,
    period: const Duration(seconds: 1),
    child: SizedBox(
      height: 195.h,
      width: 195.w,
      child: Container(
        height: 195.h,
        width: 195.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}
