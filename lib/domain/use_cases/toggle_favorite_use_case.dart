import 'package:simple_mobile_application/data/repositories/product_repository.dart';

class ToggleFavoriteUseCase {
  final ProductRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String productId) {
    return repository.toggleFavoriteStatus(productId);
  }
}
