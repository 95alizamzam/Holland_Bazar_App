import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsc_app/core/shared_widgets/loader.dart';

import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/features/auth/presentation/pages/otp_page.dart';
import 'package:tsc_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/core/shared_widgets/custom_btn.dart';
import 'package:tsc_app/core/shared_widgets/custom_btn_with_icon.dart';
import 'package:tsc_app/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:tsc_app/features/auth/presentation/blocs/login_bloc/login_event.dart';
import 'package:tsc_app/features/auth/presentation/pages/sign_up_page.dart';

import '../../../../core/shared_widgets/dialogs.dart';
import '../blocs/login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final router = getIt<NavigationServices>();
  final loginBloc = getIt<LoginBloc>();

  bool isSecure = true;

  @override
  void dispose() {
    phoneCon.dispose();
    passCon.dispose();
    loginBloc.streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginStates>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginDone) {
            router.goTo(
              context,
              replace: true,
              page: OtpPage(phoneNumber: phoneCon.text.trim()),
            );
          } else if (state is LoginFailed) {
            DialogHandler.show(
              context: context,
              state: DialogState.error,
              msg: state.errorMsg,
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            // remove focus from the text field
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 68.h),
                  Center(
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 30.sp,
                            color: const Color(0xFF4A4B4D),
                          ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    'Add your details to login',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xFF7C7D7E),
                        ),
                  ),
                  SizedBox(height: 37.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AuthTextField(
                          controller: phoneCon,
                          action: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          hint: "Mobile No",
                          validator: (phoneNumber) {
                            if (phoneNumber == null || phoneNumber.isEmpty) {
                              return "phone Number is required";
                            } else if (phoneNumber.characters.first != "0" ||
                                phoneNumber.trim().length != 11) {
                              return "phone Number Format is Wrong";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 28.h),
                        AuthTextField(
                          controller: passCon,
                          action: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          hint: "Password",
                          isSecure: isSecure,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSecure = !isSecure;
                              });
                            },
                            icon: Icon(
                              isSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "password is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),
                  BlocBuilder<LoginBloc, LoginStates>(
                    bloc: loginBloc,
                    builder: (_, state) {
                      if (state is LoginLoading) {
                        return const Loader();
                      } else {
                        return CustomBtn(onPress: login, text: "Login");
                      }
                    },
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    "Forgot your password?",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xFF7C7D7E),
                        ),
                  ),
                  SizedBox(height: 148.h),
                  Text(
                    "or Login With",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp, color: const Color(0xFF7C7D7E)),
                  ),
                  SizedBox(height: 17.h),
                  CustomBtnWithIcon(
                    onPress: () {},
                    text: "Login with Google",
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color(0xFFDD4B39),
                              ),
                            ),
                    icon: SvgPicture.asset(
                      "assets/login/google_plus_icon.svg",
                      color: Colors.white,
                      width: 20.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 87.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp, color: const Color(0xFF7C7D7E)),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: goToSignUpPage,
                        child: Text(
                          "Sign Up",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                    color: const Color(0xFFFE5A01),
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 43.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToSignUpPage() {
    router.goTo(context, replace: true, page: SignUpPage());
  }

  void login() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      loginBloc.add(LoginEvent(phoneNumber: phoneCon.text.trim()));
    }
  }
}
