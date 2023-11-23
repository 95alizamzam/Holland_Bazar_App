import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsc_app/core/common_widgets/dialogs.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/fonts/font.dart';
import 'package:tsc_app/core/services/navigation_services.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/bloc.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/events.dart';
import 'package:tsc_app/features/cart/presentation/cart_bloc/states.dart';
import 'package:tsc_app/features/cart/presentation/pages/cart_page.dart';
import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/bloc.dart';
import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/categories_bloc/states.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/bloc.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/offers_bloc/states.dart';
import 'package:tsc_app/features/home/presentation/blocs/products_bloc/events.dart';
import 'package:tsc_app/features/home/presentation/blocs/products_bloc/states.dart';
import 'package:tsc_app/features/home/presentation/widgets/badge_box.dart';
import 'package:tsc_app/features/home/presentation/widgets/category_card.dart';
import 'package:tsc_app/features/home/presentation/widgets/frequently_ordered_headline.dart';
import 'package:tsc_app/features/home/presentation/widgets/home_search_field.dart';
import 'package:tsc_app/features/home/presentation/widgets/offer_card.dart';
import 'package:tsc_app/features/home/presentation/widgets/offers_headline.dart';
import 'package:tsc_app/features/home/presentation/widgets/product_card.dart';

import '../../domain/entities/product.dart';
import '../blocs/products_bloc/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductsBloc homeBloc = getIt<ProductsBloc>();
  final OffersBloc offersBloc = getIt<OffersBloc>();
  final CategoriesBloc categoriesBloc = getIt<CategoriesBloc>();

  final router = getIt<NavigationServices>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    homeBloc.add(GetHomeProductsEvent());
    offersBloc.add(GetHomeOffersEvent());
    categoriesBloc.add(GetHomeCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAFC),
      body: BlocListener<CartBloc, CartBlocStates>(
        listener: (ctx, state) {
          if (state is AddItemToCartDoneState) {
            Navigator.of(context).pop();

            DialogHandler.show(
              context: context,
              state: DialogState.success,
              msg: "Your Item has been added to Cart Successfully",
            );
          }
          if (state is FailedState) {
            Navigator.of(context).pop();

            DialogHandler.show(
              context: context,
              state: DialogState.error,
              msg: state.exception.message,
            );
          }

          if (state is AddItemToCartLoadingState) {
            DialogHandler.show(
              context: context,
              state: DialogState.loading,
            );
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // BIG IMAGE
              Stack(
                fit: StackFit.loose,
                children: [
                  const Image(
                    image: AssetImage("assets/home_page/cover_img.png"),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 54.h,
                    left: 0.w,
                    right: 0.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        height: 54.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(child: HomeSearchField()),
                            SizedBox(width: 7.w),
                            GestureDetector(
                              onTap: () {
                                router.goTo(
                                  useAnimation: true,
                                  page: const CartPage(),
                                );
                              },
                              child: Container(
                                width: 51.w,
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: const BadgeBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140.h,
                    left: 23.w,
                    right: 0.w,
                    child: Text(
                      'Holland Bazar',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontFamily: AppFonts.metropolisExtraBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 175.h,
                    left: 23.w,
                    right: 0.w,
                    child: Text(
                      'Powered By TFC',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontFamily: AppFonts.metropolisExtraBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const OffersHeadLine(),
              // OFFERS
              BlocBuilder<OffersBloc, OffersStates>(
                bloc: offersBloc,
                builder: (context, state) {
                  if (state is OffersDoneState) {
                    return SizedBox(
                      height: 195.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: offersBloc.offers.length,
                        itemBuilder: (c, i) {
                          return OfferCard(
                            imageUrl: offersBloc.offers[i].imageUrl,
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 40.h),
              // CATEGORIES
              BlocBuilder<CategoriesBloc, CategoriessStates>(
                bloc: categoriesBloc,
                builder: (c, state) {
                  if (state is CategoriesDoneState) {
                    return SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: categoriesBloc.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return CategoryCard(
                            category: categoriesBloc.categories[i],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const FrequentlyOrderedHeadLine(),
              // PRODUCTS
              BlocBuilder<ProductsBloc, ProductsStates>(
                bloc: homeBloc,
                builder: (c, state) {
                  if (state is ProductsDoneState) {
                    return SizedBox(
                      height: 270.h,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeBloc.products.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return ProductCard(
                            onAddPress: () {
                              addItemToCart(homeBloc.products[i]);
                            },
                            product: homeBloc.products[i],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  void addItemToCart(Product product) {
    context.read<CartBloc>().add(AddItemToCart(item: product));
  }
}
