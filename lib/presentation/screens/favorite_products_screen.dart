import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mobile_application/presentation/widgets/custome_widgets.dart';
import '../view_models/product_view_model.dart';

class FavoriteProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Products')),
      body: viewModel.favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                'No favorite products found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = viewModel.favoriteProducts[index];
                return buildProductItem(context, product, viewModel);
              },
            ),
    );
  }
}
