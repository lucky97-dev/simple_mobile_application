import 'package:simple_mobile_application/data/repositories/product_repository.dart';

import '../../domain/entities/product.dart';
import '../data_sources/product_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> fetchProducts({int page = 1, int limit = 20}) async {
    final productModels =
        await dataSource.fetchProducts(page: page, limit: limit);
    return productModels
        .map((model) => Product(
              id: model.id,
              name: model.name,
              description: model.description,
              price: model.price,
              imageUrl: model.imageUrl,
              isFavorite: model.isFavorite,
            ))
        .toList();
  }

  @override
  Future<void> toggleFavoriteStatus(String productId) async {
    final products = await dataSource.fetchProducts();
    final product = products.firstWhere((product) => product.id == productId);
    product.isFavorite = !product.isFavorite;
  }
}
