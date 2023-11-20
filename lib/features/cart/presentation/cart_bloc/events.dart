// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tsc_app/features/home/domain/entities/product.dart';

abstract class CartBlocEvents {}

class CheckExistCartEvent extends CartBlocEvents {}

class CreateCartEvent extends CartBlocEvents {}

class GetCartItemsEvent extends CartBlocEvents {
  final String userId;
  GetCartItemsEvent({required this.userId});
}

class AddItemToCart extends CartBlocEvents {
  final Product item;
  AddItemToCart({required this.item});
}

class ChangeItemQuantity extends CartBlocEvents {
  final String documentId;
  final int quantity;
  ChangeItemQuantity({required this.documentId, required this.quantity});
}

class RemoveItemFromCart extends CartBlocEvents {
  final int itemId;
  final String docId;
  RemoveItemFromCart({
    required this.docId,
    required this.itemId,
  });
}
