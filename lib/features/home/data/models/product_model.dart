import 'package:json_annotation/json_annotation.dart';
import 'package:tsc_app/features/home/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductModel {
  final int id;
  final String description;
  final int discount;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String weight;
  ProductModel({
    required this.id,
    required this.description,
    required this.discount,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.weight,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelExt on ProductModel {
  Product toDomain() {
    return Product(
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
