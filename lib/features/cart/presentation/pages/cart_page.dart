import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/shared_widgets/custom_btn.dart';
import 'package:tsc_app/core/shared_widgets/dialogs.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/fonts/font.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/bloc.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/events.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/states.dart';
import 'package:tsc_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:tsc_app/features/cart/presentation/widgets/cart_loader.dart';
import 'package:tsc_app/features/cart/presentation/widgets/checkout_card.dart';

import '../../domain/entities/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>()..add(CheckExistCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAFC),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Orders Cart',
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                fontSize: 18.sp,
              ),
        ),
      ),
      body: BlocConsumer<CartBloc, CartBlocStates>(
        listener: (context, state) {
          if (state is FailedState) {
            DialogHandler.show(
              context: context,
              state: DialogState.error,
              msg: state.exception.message,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const CartShimmerLoader();
          } else if (state is FailedState) {
            return const SizedBox.shrink();
          } else if (!cartBloc.isCartExist) {
            return _createUserCart();
          }

          return cartBloc.items?.isEmpty ?? true
              ? _emptyUserCart()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 4.h,
                  ),
                  itemCount: cartBloc.items!.length,
                  itemBuilder: (c, i) {
                    final CartItem item = cartBloc.items![i];
                    return CartItemUi(
                      key: ValueKey(item.id),
                      item: item,
                      onDelete: () {
                        cartBloc.add(
                          RemoveItemFromCart(
                            docId: "${item.id}-${item.name}",
                            itemId: item.id,
                          ),
                        );
                      },
                      onChangeQuantity: (quantity) {
                        cartBloc.add(
                          ChangeItemQuantity(
                            documentId: "${item.id}-${item.name}",
                            quantity: quantity,
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartBlocStates>(
        builder: (context, state) {
          if (!cartBloc.isCartExist || (cartBloc.items?.isEmpty ?? true)) {
            return const SizedBox.shrink();
          }

          return CheckoutCard(items: cartBloc.items ?? []);
        },
      ),
    );
  }

  Widget _createUserCart() {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 200.h,
            fit: BoxFit.cover,
            image: const AssetImage(
              "assets/cart_page/cart_not_found.png",
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "You don't have cart yet , Please Click To Create Your Own Cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: AppFonts.metropolisSemiBold,
              height: 1.4,
            ),
          ),
          SizedBox(height: 40.h),
          CustomBtn(
            onPress: () {
              cartBloc.add(CreateCartEvent());
            },
            text: "Create",
          ),
        ],
      ),
    );
  }

  Widget _emptyUserCart() {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 200.h,
            fit: BoxFit.cover,
            image: const AssetImage(
              "assets/cart_page/empty_cart.png",
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Your Cart is Empty , Please Discover Items and Added them to Your cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: AppFonts.metropolisSemiBold,
              height: 1.4,
            ),
          ),
          SizedBox(height: 40.h),
          CustomBtn(
            onPress: () {
              getIt<NavigationServices>().goBack(context);
            },
            text: "Discover",
          ),
        ],
      ),
    );
  }
}
