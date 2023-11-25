import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

typedef OnPinComplete = Function(String pin);

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.onPinComplete,
    required this.controller,
  });

  final OnPinComplete onPinComplete;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      defaultPinTheme: PinTheme(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
      ),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      pinContentAlignment: Alignment.center,
      keyboardType: TextInputType.number,
      length: 6,
      autofocus: true,
      obscureText: false,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
      closeKeyboardWhenCompleted: true,
      textInputAction: TextInputAction.done,
      scrollPadding: EdgeInsets.zero,
      validator: (s) {
        if (s == null || s.isEmpty) {
          return "Required Field";
        }
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (otpCode) {
        onPinComplete(otpCode);
      },
    );
  }
}
