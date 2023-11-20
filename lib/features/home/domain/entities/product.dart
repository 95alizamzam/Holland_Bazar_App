class Product {
  final int id;
  final String description;
  final int discount;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String weight;
  Product({
    required this.id,
    required this.description,
    required this.discount,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.weight,
  });
}

extension ProductExt on Product {
  Map<String, dynamic> toData() {
    return {
      "id": id,
      "description": description,
      "discount": discount,
      "imageUrl": imageUrl,
      "name": name,
      "price": price,
      "rating": rating,
      "weight": weight,
    };
  }
}
