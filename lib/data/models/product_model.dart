import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    bool isFavorite = false,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          isFavorite: isFavorite,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
    );
  }
}
