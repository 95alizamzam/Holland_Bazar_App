import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tsc_app/core/common_widgets/custom_btn.dart';
import 'package:tsc_app/core/common_widgets/dialogs.dart';
import 'package:tsc_app/core/common_widgets/loader.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/presentation/pages/start_up_page.dart';
import 'package:tsc_app/core/services/firebase/auth_services.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:tsc_app/features/auth/presentation/blocs/login_bloc/login_event.dart';
import 'package:tsc_app/features/auth/presentation/blocs/login_bloc/login_state.dart';
import 'package:tsc_app/features/auth/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:tsc_app/features/auth/presentation/blocs/verify_otp/verify_otp_event.dart';
import 'package:tsc_app/features/auth/presentation/blocs/verify_otp/verify_otp_state.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key, required this.phoneNumber});

  final String phoneNumber;
  final VerifyOtpBloc verifyOtpBloc = getIt<VerifyOtpBloc>();
  final TextEditingController otpController = TextEditingController();
  final router = getIt<NavigationServices>();
  final hiveHelper = getIt<HiveConfig>();
  final authServices = getIt<FirebaseAuthServices>();
  final LoginBloc loginBloc = getIt<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginStates>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }

          if (state is LoginFailed) {
            DialogHandler.show(
              context: context,
              state: DialogState.error,
              msg: state.errorMsg,
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 34.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 72.h),
                Center(
                  child: SizedBox(
                    width: 296.w,
                    child: Text(
                      "We have sent an OTP to your Mobile",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0xFF4A4B4D),
                            fontSize: 25.sp,
                            height: 1.3,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Center(
                  child: SizedBox(
                    width: 302.w,
                    child: Text(
                      "Please check your mobile number ${formatPhoneNumber()} continue to reset your password",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color(0xFF7C7D7E),
                            fontSize: 14.sp,
                            height: 1.3,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 55.h),
                Pinput(
                  controller: otpController,
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
                  obscureText: true,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  closeKeyboardWhenCompleted: true,
                  obscuringWidget: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Text(
                      "*",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 37.sp,
                            color: const Color(0xFFB6B7B7),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  scrollPadding: EdgeInsets.zero,
                  validator: (s) {
                    if (s == null || s.isEmpty) {
                      return "Required Otp";
                    }
                    return null;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (otpCode) {
                    verifyOtpBloc.add(VerifyOtpEvent(otp: otpCode));
                  },
                ),
                SizedBox(height: 36.h),
                BlocConsumer<VerifyOtpBloc, VerifyOtpStates>(
                  bloc: verifyOtpBloc,
                  listener: (context, state) {
                    if (state is VerifyDone) {
                      router.goTo(
                        context,
                        page: const StartUpPage(),
                        clean: true,
                      );
                    }
                    if (state is VerifyFailed) {
                      DialogHandler.show(
                        context: context,
                        state: DialogState.error,
                        msg: state.exception.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is VerifyLoading) {
                      return const Loader();
                    }

                    return CustomBtn(
                      onPress: () {
                        if (otpController.text.trim().isEmpty) {
                          return;
                        }
                      },
                      text: "Next",
                    );
                  },
                ),
                SizedBox(height: 36.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn't Receive ?",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp, color: const Color(0xFF7C7D7E)),
                    ),
                    SizedBox(width: 4.w),
                    TextButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      ),
                      onPressed: resendCode,
                      child: Text(
                        "Click Here",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14.sp,
                              color: const Color(0xFFFE5A01),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber() {
    final String formattedNumber = phoneNumber.replaceRange(3, 8, "*****");

    return formattedNumber;
  }

  void resendCode() {
    loginBloc.add(LoginEvent(phoneNumber: phoneNumber));
  }
}
