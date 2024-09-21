import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:simple_mobile_application/domain/entities/product.dart';
import 'package:simple_mobile_application/domain/use_cases/get_products_use_case.dart';
import 'package:simple_mobile_application/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:simple_mobile_application/presentation/view_models/product_view_model.dart';

import 'product_view_model_test.mocks.dart';

// Create mock classes for the dependencies
@GenerateMocks([GetProductsUseCase, ToggleFavoriteUseCase])
void main() {
  late MockGetProductsUseCase mockGetProductsUseCase;
  late MockToggleFavoriteUseCase mockToggleFavoriteUseCase;
  late ProductViewModel productViewModel;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    mockToggleFavoriteUseCase = MockToggleFavoriteUseCase();
    productViewModel =
        ProductViewModel(mockGetProductsUseCase, mockToggleFavoriteUseCase);
  });

  group('ProductViewModel Tests', () {
    final List<Product> mockProducts = [
      Product(
          id: '1',
          name: 'Product 1',
          price: 10.0,
          imageUrl: 'url1',
          description: 'desc1',
          isFavorite: false),
      Product(
          id: '2',
          name: 'Product 2',
          price: 20.0,
          imageUrl: 'url2',
          description: 'desc2',
          isFavorite: true),
    ];

    test('Fetch products successfully', () async {
      // Set up the mock to return a Future containing the mockProducts list
      when(mockGetProductsUseCase.call(page: 1, limit: 20))
          .thenAnswer((_) async => mockProducts);

      // Call the method under test
      await productViewModel.fetchProducts();

      // Verify the products list is populated with mock data
      expect(productViewModel.products.length, mockProducts.length);
      expect(productViewModel.products, mockProducts);
    });

    test('Toggle favorite status of a product', () async {
      productViewModel.products.addAll(mockProducts);
      final productId = '1';

      // Call the method under test
      await productViewModel.toggleFavorite(productId);

      // Verify the favorite status has changed
      expect(productViewModel.products[0].isFavorite, true);
      // Verify that the backend update method was called
      verify(mockToggleFavoriteUseCase.call(productId)).called(1);
    });
  });
}
