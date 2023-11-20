// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/features/home/data/models/category_model.dart';
import 'package:tsc_app/features/home/data/models/offer_model.dart';
import 'package:tsc_app/features/home/data/models/product_model.dart';
import 'package:tsc_app/features/home/domain/entities/category.dart';
import 'package:tsc_app/features/home/domain/entities/offer.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';
import 'package:tsc_app/features/home/domain/repository/base_home_repo.dart';

import '../data_source/remote.dart';

@LazySingleton(as: BaseHomeRepo)
class HomeRepoImpl extends BaseHomeRepo {
  final RemoteHomeDataSource remote;
  HomeRepoImpl({required this.remote});
  @override
  Future<Either<CustomException, List<Product>>> getProducts() async {
    try {
      final List<ProductModel> products = await remote.getProducts();
      final result = products.map((e) => e.toDomain()).toList();
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, List<Offer>>> getOffers() async {
    try {
      final List<OfferModel> offers = await remote.getOffers();
      final result = offers.map((e) => e.toDomain()).toList();
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, List<Category>>> getCategories() async {
    try {
      final List<CategoryModel> categories = await remote.getCategories();
      final result = categories.map((e) => e.toDomain()).toList();
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }
}
