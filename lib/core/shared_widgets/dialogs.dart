import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/shared_widgets/custom_btn.dart';
import 'package:tsc_app/core/shared_widgets/loader.dart';

enum DialogState {
  error,
  success,
  loading;

  Color getColor() {
    final Color value = switch (this) {
      DialogState.error => Colors.red,
      DialogState.success => Colors.green,
      DialogState.loading => Colors.grey.shade400,
    };
    return value;
  }

  IconData getIcon() {
    final IconData value = switch (this) {
      DialogState.error => Icons.close,
      DialogState.success => Icons.check,
      DialogState.loading => Icons.sync,
    };
    return value;
  }
}

class DialogHandler {
  static void show({
    required BuildContext context,
    required DialogState state,
    String? msg,
  }) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: state == DialogState.loading ? false : true,
      builder: (_) => state == DialogState.loading
          ? Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(20),
              child: Loader(color: state.getColor()),
            )
          : AlertDialog(
              shape: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.getColor(),
                    ),
                    child: Icon(
                      state.getIcon(),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    state.name.toUpperCase(),
                    style: TextStyle(
                      color: state.getColor(),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    msg!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomBtn(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(state.getColor()),
                    ),
                    onPress: () {
                      Navigator.of(_).pop();
                    },
                    text: "OK",
                  ),
                ],
              ),
            ),
    );
  }
}
