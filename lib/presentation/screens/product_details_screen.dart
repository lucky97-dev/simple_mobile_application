import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/product_view_model.dart';
import '../../domain/entities/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.imageUrl, height: 200, width: 200),
            ),
            SizedBox(height: 20),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 20),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            Spacer(),
            Center(
              child: InkWell(
                onTap: () {
                  viewModel.toggleFavorite(product.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: product.isFavorite ? Colors.red : Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Toggle Favorite"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
