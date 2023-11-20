import 'package:injectable/injectable.dart';
import 'package:tsc_app/core/di/setup.dart';
import 'package:tsc_app/core/services/firebase/cloud_firestore.dart';
import 'package:tsc_app/features/cart/data/models/cart_item.dart';

import '../../../home/domain/entities/product.dart';

abstract class RemoteCartDataSource {
  Future<bool> checkUserCartExist({required String userId});
  Future<void> createUserCart({required String userId});
  Future<List<CartItemModel>> getCartItems({required String cartId});
  Future<void> addItemToCart({required Product item, required String cartId});
  Future<void> changeQuantity({
    required int quantity,
    required String cartId,
    required String documentId,
  });

  Future<void> removeItemFromCard({
    required String cartId,
    required String docId,
  });
}

@LazySingleton(as: RemoteCartDataSource)
class RemoteCartDataSourceImpl extends RemoteCartDataSource {
  final cloudService = getIt<CloudFireStoreService>();
  @override
  Future<bool> checkUserCartExist({required String userId}) async {
    final result = await cloudService.checkIfCartExist(userId: userId);
    return result;
  }

  @override
  Future<void> createUserCart({required String userId}) async {
    return await cloudService.createUserCart(userId: userId);
  }

  @override
  Future<List<CartItemModel>> getCartItems({required String cartId}) async {
    final response = await cloudService.getUserCartItems(userId: cartId);
    final result = response.map((e) {
      return CartItemModel.fromJson(e.data());
    }).toList();

    return result;
  }

  @override
  Future<void> addItemToCart({
    required Product item,
    required String cartId,
  }) async {
    await cloudService.addItemToCart(cartId: cartId, item: item);
  }

  @override
  Future<void> changeQuantity({
    required int quantity,
    required String cartId,
    required String documentId,
  }) async {
    await cloudService.changeItemQuantity(
        cartId: cartId, docId: documentId, quantity: quantity);
  }

  @override
  Future<void> removeItemFromCard({
    required String cartId,
    required String docId,
  }) async {
    await cloudService.removeItemFromCart(cartId: cartId, docId: docId);
  }
}
