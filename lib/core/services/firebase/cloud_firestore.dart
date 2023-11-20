import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../features/home/domain/entities/product.dart';

@lazySingleton
class CloudFireStoreService {
  final FirebaseFirestore fs = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getProducts() async {
    final data = await fs.collection("Products").orderBy("id").get();
    return data.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getOffers() async {
    final data = await fs.collection("Offers").orderBy("id").get();
    return data.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCategories() async {
    final data = await fs.collection("ctegories").orderBy("id").get();
    return data.docs;
  }

  Future<bool> checkIfCartExist({required String userId}) async {
    final data = await fs.collection("carts").doc(userId).get();
    return data.exists;
  }

  Future<void> createUserCart({
    required String userId,
  }) async =>
      await fs.collection("carts").doc(userId).set({});

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUserCartItems({
    required String userId,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> query =
        await fs.collection("carts").doc(userId).collection("items").get();
    return query.docs;
  }

  Future<void> addItemToCart({
    required String cartId,
    required Product item,
  }) async {
    if (!await checkIfCartExist(userId: cartId)) {
      await createUserCart(userId: cartId);
    }

    final result = await fs
        .collection("carts")
        .doc(cartId)
        .collection("items")
        .doc("${item.id}-${item.name}")
        .get();

    if (result.exists) {
      await fs
          .collection("carts")
          .doc(cartId)
          .collection("items")
          .doc("${item.id}-${item.name}")
          .update({
        "quantity": result['quantity'] + 1,
      });
    } else {
      await fs
          .collection("carts")
          .doc(cartId)
          .collection("items")
          .doc("${item.id}-${item.name}")
          .set({
        ...item.toData(),
        "quantity": 1,
      });
    }
  }

  Future<void> changeItemQuantity({
    required String cartId,
    required String docId,
    required int quantity,
  }) async {
    await fs
        .collection("carts")
        .doc(cartId)
        .collection("items")
        .doc(docId)
        .update({"quantity": quantity});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenToCartChanges({
    required String cartId,
  }) {
    return fs.collection("carts").doc(cartId).collection("items").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToCartItemChanges({
    required String docId,
    required String cartId,
  }) {
    return fs
        .collection("carts")
        .doc(cartId)
        .collection("items")
        .doc(docId)
        .snapshots();
  }

  Future<void> removeItemFromCart({
    required String cartId,
    required String docId,
  }) async {
    await fs
        .collection("carts")
        .doc(cartId)
        .collection("items")
        .doc(docId)
        .delete();
  }
}
