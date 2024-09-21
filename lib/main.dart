import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_sources/product_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/use_cases/get_products_use_case.dart';
import 'domain/use_cases/toggle_favorite_use_case.dart';
import 'presentation/view_models/product_view_model.dart';
import 'presentation/screens/product_list_screen.dart';
import 'package:dio/dio.dart';

void main() {
  final dio = Dio();
  final productDataSource = ProductDataSource(dio);
  final productRepository = ProductRepositoryImpl(productDataSource);

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl productRepository;

  MyApp({required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(
            GetProductsUseCase(productRepository),
            ToggleFavoriteUseCase(productRepository),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black, fontSize: 16),
            bodyText2: TextStyle(color: Colors.grey[600], fontSize: 14),
            headline6: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          appBarTheme: AppBarTheme(
              color: Colors.blue,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              iconTheme: IconThemeData(color: Colors.white)),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        home: ProductListScreen(),
      ),
    );
  }
}
