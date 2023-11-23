import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/presentation/enums/on_boarding_page_enum.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/core/common_widgets/custom_btn.dart';

import '../../../features/auth/presentation/pages/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;
  final route = getIt<NavigationServices>();

  @override
  void initState() {
    super.initState();
    getIt<HiveConfig>().storeData(
      key: HiveKeys.isFirstRun,
      value: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView.builder(
        itemCount: OnBoardingPageEnum.values.length,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemBuilder: (context, index) {
          final item = OnBoardingPageEnum.values[index];
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 112.h),
                SvgPicture.asset(
                  item.getImage(),
                  height: 294.81.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30.h),
                SmoothPageIndicator(
                  controller: controller,
                  count: OnBoardingPageEnum.values.length,
                  axisDirection: Axis.horizontal,
                  effect: SlideEffect(
                    spacing: 5.w,
                    radius: 4.0,
                    dotWidth: 8,
                    dotHeight: 8,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: const Color(0xFFD6D6D6),
                    activeDotColor: const Color(0xFFFE5A01),
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Text(
                    item.getTitle(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 34.h),
                SizedBox(
                  height: 58.h,
                  width: 271.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      item.getDescription(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13.sp,
                            height: 1.5,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: CustomBtn(
                    onPress: () {
                      if (currentIndex ==
                          OnBoardingPageEnum.values.length - 1) {
                        route.goTo(clean: true, page: LoginPage());
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      }
                    },
                    text: "Next",
                  ),
                ),
                SizedBox(height: 112.h),
              ],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
