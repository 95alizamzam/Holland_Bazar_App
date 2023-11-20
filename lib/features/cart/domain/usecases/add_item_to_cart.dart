// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/core/usecase/use_case.dart';

import '../../../home/domain/entities/product.dart';
import '../repository/base_cart_repo.dart';

@lazySingleton
class AddItemToCartUseCase extends UseCase<AddItemToCartParams, Unit> {
  final BaseCartRepository repo;
  AddItemToCartUseCase({required this.repo});
  @override
  Future<Either<CustomException, Unit>> call(params) async {
    return await repo.addItemToCart(
      cartId: params.cartId,
      item: params.item,
    );
  }
}

class AddItemToCartParams {
  final String cartId;
  final Product item;
  AddItemToCartParams({required this.cartId, required this.item});
}
