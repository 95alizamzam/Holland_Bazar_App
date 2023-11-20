import 'package:dartz/dartz.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/features/home/domain/entities/offer.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';

import '../entities/category.dart';

abstract class BaseHomeRepo {
  Future<Either<CustomException, List<Product>>> getProducts();
  Future<Either<CustomException, List<Offer>>> getOffers();
  Future<Either<CustomException, List<Category>>> getCategories();
}
