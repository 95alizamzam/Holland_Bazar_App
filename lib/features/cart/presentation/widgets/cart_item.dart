import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/common_widgets/cached_image.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/fonts/font.dart';
import 'package:tsc_app/core/services/firebase/cloud_firestore.dart';
import 'package:tsc_app/core/services/firebase/storage_service.dart';
import 'package:tsc_app/core/services/hive_config.dart';
import 'package:tsc_app/features/cart/presentation/widgets/quantity_btn.dart';
import '../../domain/entities/cart_item.dart';

class CartItemUi extends StatefulWidget {
  const CartItemUi({
    super.key,
    required this.item,
    required this.onChangeQuantity,
    required this.onDelete,
  });

  final CartItem item;
  final Function(int quantity) onChangeQuantity;
  final VoidCallback onDelete;

  @override
  State<CartItemUi> createState() => _CartItemUiState();
}

class _CartItemUiState extends State<CartItemUi> {
  String? url;
  late int quantity;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> stream;
  @override
  void initState() {
    super.initState();
    quantity = widget.item.quantity;

    if (context.mounted) {
      getIt<FireBaseStorageService>()
          .getDownloadUrl("products/${widget.item.imageUrl}")
          .then((value) {
        setState(() => url = value);
      });
    }

    stream = getIt<CloudFireStoreService>().listenToCartItemChanges(
      docId: "${widget.item.id}-${widget.item.name}",
      cartId: getIt<HiveConfig>().getData(key: HiveKeys.userId),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item.id),
      direction: DismissDirection.endToStart,
      dragStartBehavior: DragStartBehavior.start,
      background: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.w),
          child: const Image(
            image: AssetImage("assets/cart_page/delete_btn.png"),
          ),
        ),
      ),
      onUpdate: (details) {
        if (details.reached) {
          widget.onDelete();
        }
      },
      dismissThresholds: const {
        DismissDirection.endToStart: .6,
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {}
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        }
        return false;
      },
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if (data != null) {
              quantity = data["quantity"];
            }
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 9.h),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8EBE8),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: url == null
                      ? const SizedBox.shrink()
                      : CustomCachedImage(
                          key: UniqueKey(),
                          url: url!,
                        ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color(0xFF231D25),
                              fontSize: 14.sp,
                            ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        widget.item.description,
                        style: TextStyle(
                          color: const Color(0xFF919191),
                          fontSize: 12.sp,
                          fontFamily: AppFonts.metropolisRegular,
                        ),
                      ),
                      SizedBox(height: 9.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: const Color(0xFFFE5A01),
                                      fontSize: 12.sp,
                                    ),
                          ),
                          Text(
                            (widget.item.price).toStringAsFixed(2),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: const Color(0xFF231D25),
                                      fontSize: 15.sp,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuantityBtn(
                      icon: Icons.remove,
                      onPress: () {
                        if (quantity > 1) {
                          widget.onChangeQuantity(quantity - 1);
                        }
                      },
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "$quantity",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF231D25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    QuantityBtn(
                      icon: Icons.add,
                      onPress: () {
                        widget.onChangeQuantity(quantity + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
