// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/features/cart/data/models/cart_item.dart';
import 'package:tsc_app/features/cart/domain/entities/cart_item.dart';
import 'package:tsc_app/features/cart/domain/repository/base_cart_repo.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';

import '../data_source/remote.dart';

@LazySingleton(as: BaseCartRepository)
class CartRepoImpl extends BaseCartRepository {
  final RemoteCartDataSource remote;
  CartRepoImpl({required this.remote});
  @override
  Future<Either<CustomException, bool>> checkUserCartExist({
    required String userId,
  }) async {
    try {
      final result = await remote.checkUserCartExist(userId: userId);
      return right(result);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, Unit>> createUserCart({
    required String userId,
  }) async {
    try {
      await remote.createUserCart(userId: userId);
      return right(unit);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, List<CartItem>>> getUserCartItems({
    required String cartId,
  }) async {
    try {
      final List<CartItemModel> result =
          await remote.getCartItems(cartId: cartId);
      final data = result.map((e) => e.toDomain()).toList();
      return right(data);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, Unit>> addItemToCart({
    required Product item,
    required String cartId,
  }) async {
    try {
      await remote.addItemToCart(item: item, cartId: cartId);
      return right(unit);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, Unit>> changeItemQuantity({
    required String docId,
    required String cartId,
    required int quantity,
  }) async {
    try {
      await remote.changeQuantity(
        documentId: docId,
        quantity: quantity,
        cartId: cartId,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<CustomException, Unit>> removeItemFromCard({
    required String cartId,
    required String docId,
  }) async {
    try {
      await remote.removeItemFromCard(docId: docId, cartId: cartId);
      return right(unit);
    } on CustomException catch (e) {
      return left(e);
    }
  }
}
