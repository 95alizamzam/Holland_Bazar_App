import 'package:json_annotation/json_annotation.dart';
import 'package:tsc_app/features/cart/domain/entities/cart_item.dart';
part 'cart_item.g.dart';

@JsonSerializable(createToJson: false)
class CartItemModel {
  final int quantity;
  final int id;
  final String description;
  final int discount;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String weight;
  CartItemModel({
    required this.quantity,
    required this.id,
    required this.description,
    required this.discount,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.weight,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}

extension CartItemModelExt on CartItemModel {
  CartItem toDomain() {
    return CartItem(
      quantity: quantity,
      id: id,
      description: description,
      discount: discount,
      imageUrl: imageUrl,
      name: name,
      price: price,
      rating: rating,
      weight: weight,
    );
  }
}
