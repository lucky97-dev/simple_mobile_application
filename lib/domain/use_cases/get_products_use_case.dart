import 'package:simple_mobile_application/data/repositories/product_repository.dart';

import '../entities/product.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call({int page = 1, int limit = 20}) {
    return repository.fetchProducts(page: page, limit: limit);
  }
}
