import 'package:simple_mobile_application/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts({int page, int limit});
  Future<void> toggleFavoriteStatus(String productId);
}
