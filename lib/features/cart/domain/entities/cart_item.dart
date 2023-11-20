// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final int quantity;
  final int id;
  final String description;
  final int discount;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String weight;
  CartItem({
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
}
