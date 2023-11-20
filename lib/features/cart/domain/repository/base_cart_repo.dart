import 'package:dartz/dartz.dart';
import 'package:tsc_app/core/exceptions/app_exception.dart';
import 'package:tsc_app/features/cart/domain/entities/cart_item.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';

abstract class BaseCartRepository {
  Future<Either<CustomException, bool>> checkUserCartExist({
    required String userId,
  });

  Future<Either<CustomException, Unit>> createUserCart({
    required String userId,
  });

  Future<Either<CustomException, List<CartItem>>> getUserCartItems({
    required String cartId,
  });

  Future<Either<CustomException, Unit>> addItemToCart({
    required Product item,
    required String cartId,
  });
  Future<Either<CustomException, Unit>> changeItemQuantity({
    required String docId,
    required String cartId,
    required int quantity,
  });

  Future<Either<CustomException, Unit>> removeItemFromCard({
    required String cartId,
    required String docId,
  });
}
