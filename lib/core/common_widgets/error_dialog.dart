import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/common_widgets/custom_btn.dart';

class DialogHandler {
  static void showErrorDialog(
    BuildContext context, {
    required String errorMsg,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: const Icon(Icons.close, color: Colors.white),
            ),
            SizedBox(height: 20.h),
            Text(
              "Error",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              onPress: () {
                Navigator.of(_).pop();
              },
              text: "ok",
            ),
          ],
        ),
      ),
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String message,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            SizedBox(height: 20.h),
            Text(
              "Success",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPress: () {
                Navigator.of(_).pop();
              },
              text: "ok",
            ),
          ],
        ),
      ),
    );
  }
}
