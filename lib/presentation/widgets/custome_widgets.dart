import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_mobile_application/domain/entities/product.dart';
import 'package:simple_mobile_application/presentation/screens/product_details_screen.dart';
import 'package:simple_mobile_application/presentation/view_models/product_view_model.dart';

Widget buildProductItem(
    BuildContext context, Product product, ProductViewModel viewModel) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(product: product),
            ),
          )
          .then((value) => viewModel.updateFavoriteProducts());
    },
    child: Card(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              height: 140,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )),
          Container(
            height: 140,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 152,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Price: \$${product.price}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        viewModel.toggleFavorite(product.id);
                        viewModel.updateFavoriteProducts();
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
