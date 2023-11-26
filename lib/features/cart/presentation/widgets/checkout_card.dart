import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsc_app/core/fonts/font.dart';
import 'package:tsc_app/features/cart/data/models/cart_item.dart';

import '../../../../core/shared_widgets/custom_btn.dart';
import '../../../../core/di/setup.dart';
import '../../../../core/services/firebase/cloud_firestore.dart';
import '../../../../core/services/hive_config.dart';
import '../../domain/entities/cart_item.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({super.key, required this.items});

  final List<CartItem> items;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  List<CartItem> usedItems = [];
  @override
  void initState() {
    super.initState();

    usedItems = widget.items;
    final id = getIt<HiveConfig>().getUserId();
    if (id != null) {
      stream = getIt<CloudFireStoreService>().listenToCartChanges(
        cartId: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final docs = snapshot.data?.docs ?? [];
          final result =
              docs.map((e) => CartItemModel.fromJson(e.data())).toList();
          usedItems = result.map((e) => e.toDomain()).toList();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: DottedBorder(
                radius: const Radius.circular(29),
                borderType: BorderType.RRect,
                padding: EdgeInsets.zero,
                dashPattern: const [4],
                strokeWidth: 2,
                color: const Color(0xFFEEEEEE),
                strokeCap: StrokeCap.butt,
                child: Container(
                  height: 58.h,
                  padding: EdgeInsets.symmetric(vertical: 9.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 18.w),
                      SvgPicture.asset("assets/cart_page/discount_icon.svg"),
                      SizedBox(width: 8.w),
                      SizedBox(
                        child: Text(
                          "Enter promo code",
                          style: TextStyle(
                            color: const Color(0xFF231D25).withOpacity(.70),
                            fontSize: 12.sp,
                            fontFamily: AppFonts.robotoRegular,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomBtn(
                        onPress: () {},
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(70.w, 41.h)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                          ),
                          textStyle: MaterialStatePropertyAll(
                            TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        text: "Apply",
                      ),
                      SizedBox(width: 9.w),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 31.h),
            Container(
              height: 280.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: const Color(0xFF222226),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Delivery',
                            style: TextStyle(
                              color: const Color(0xFF222226),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Offer',
                            style: TextStyle(
                              color: const Color(0xFFFF0000),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${getTotal().toStringAsFixed(2)} \$',
                            style: TextStyle(
                              color: const Color(0xFF222226),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '2,000 \$',
                            style: TextStyle(
                              color: const Color(0xFF222226),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '- ${getDiscount().toStringAsFixed(2)} \$',
                            style: TextStyle(
                              color: const Color(0xFFFF0000),
                              fontSize: 15.sp,
                              fontFamily: AppFonts.metropolisRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 27.h),
                  _dottedLine(),
                  SizedBox(height: 24.h),
                  Text(
                    "Grand Total  \$ ${getGrandTotal().toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xFFFE5A01),
                          fontSize: 16.sp,
                        ),
                  ),
                  SizedBox(height: 24.h),
                  CustomBtn(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xFF231D25),
                      ),
                    ),
                    onPress: () {},
                    text: 'Checkout',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: 4.0,
      dashColor: Color(0xFFEEEEEE),
      dashRadius: 0.0,
      dashGapLength: 2.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }

  double getTotal() {
    double total = 0;
    for (var e in usedItems) {
      total += (e.price * e.quantity);
    }

    return total;
  }

  double getDiscount() {
    double discountAsMoney = 0;
    for (var e in usedItems) {
      discountAsMoney += (e.price * e.discount) / 100;
    }

    return discountAsMoney;
  }

  double getGrandTotal() {
    final total = getTotal();
    final discount = getDiscount();

    return total - discount;
  }
}
