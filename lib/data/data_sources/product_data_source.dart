import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductDataSource {
  final Dio dio;

  ProductDataSource(this.dio);

  Future<List<ProductModel>> fetchProducts(
      {int page = 1, int limit = 20}) async {
    final response = await dio.get(
        'https://66edc6fd380821644cddf84a.mockapi.io/api/v1/products',
        queryParameters: {
          'page': page,
          'limit': limit,
        });

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
