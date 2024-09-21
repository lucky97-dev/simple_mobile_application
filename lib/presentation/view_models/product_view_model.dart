import 'package:flutter/foundation.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import '../../domain/use_cases/toggle_favorite_use_case.dart';
import '../../domain/entities/product.dart';

class ProductViewModel with ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _favoriteProducts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _limit = 20;
  String? _errorMessage;

  ProductViewModel(this.getProductsUseCase, this.toggleFavoriteUseCase);

  List<Product> get products =>
      _filteredProducts.isNotEmpty ? _filteredProducts : _products;
  List<Product> get favoriteProducts => _favoriteProducts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProducts =
          await getProductsUseCase.call(page: _currentPage, limit: _limit);
      if (newProducts.isEmpty) {
        _hasMore = false;
      } else {
        _products.addAll(newProducts);
        _currentPage++;
        updateFavoriteProducts();
      }
    } catch (e) {
      _errorMessage = 'Failed to load products. Please try again later.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String productId) async {
    final productIndex =
        _products.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      _products[productIndex].isFavorite = !_products[productIndex].isFavorite;
      notifyListeners();

      try {
        // Update the backend
        await toggleFavoriteUseCase.call(productId);
        // Update favorite products
        updateFavoriteProducts();
      } catch (e) {
        _products[productIndex].isFavorite =
            !_products[productIndex].isFavorite; // Revert change on error
        _errorMessage =
            'Failed to update favorite status. Please try again later.';
        notifyListeners();
      }
    }
  }

  Future<void> updateFavoriteProducts() async {
    _favoriteProducts =
        _products.where((product) => product.isFavorite).toList();
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts.clear();
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
