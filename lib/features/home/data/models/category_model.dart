import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/category.dart';
part 'category_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel {
  final int id;
  final String name;
  final String imageUrl;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelExt on CategoryModel {
  Category toDomain() {
    return Category(
      id: id,
      imageUrl: imageUrl,
      name: name,
    );
  }
}
