import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/core/common_widgets/custom_btn.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController nameCon = TextEditingController();
  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final router = getIt<NavigationServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 68.h),
              Center(
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 30.sp,
                        color: const Color(0xFF4A4B4D),
                      ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'Add your details to sign up',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF7C7D7E),
                    ),
              ),
              SizedBox(height: 113.h),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthTextField(
                      controller: nameCon,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      hint: "Name",
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 36.h),
                    AuthTextField(
                      controller: phoneCon,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      hint: "Mobile No",
                      validator: (phoneNumber) {
                        if (phoneNumber == null || phoneNumber.isEmpty) {
                          return "phone Number is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 36.h),
                    AuthTextField(
                      controller: addressCon,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hint: "Address",
                      validator: (address) {
                        if (address == null || address.isEmpty) {
                          return "Address is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 196.h),
              CustomBtn(
                text: "Sign Up",
                onPress: signUp,
              ),
              SizedBox(height: 28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an Account?",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp, color: const Color(0xFF7C7D7E)),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      router.goTo(context,
                          replace: true, page: const LoginPage());
                    },
                    child: Text(
                      "Login",
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
    );
  }

  void signUp() {}
}
