import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mobile_application/presentation/widgets/custome_widgets.dart';
import '../view_models/product_view_model.dart';
import 'favorite_products_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          _buildSearchBar(viewModel),
          Expanded(
            child: _buildProductList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('All Favorite Products'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FavoriteProductsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ProductViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 55,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search by name',
            border: OutlineInputBorder(),
          ),
          onChanged: (query) {
            viewModel.filterProducts(query);
          },
        ),
      ),
    );
  }

  Widget _buildProductList(ProductViewModel viewModel) {
    if (viewModel.isLoading && viewModel.products.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else if (viewModel.errorMessage != null &&
        viewModel.errorMessage!.isNotEmpty) {
      return _buildErrorState(viewModel);
    } else {
      return _buildProductListView(viewModel);
    }
  }

  Widget _buildErrorState(ProductViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              viewModel.fetchProducts(); // Retry fetching products
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductListView(ProductViewModel viewModel) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (!viewModel.isLoading &&
            viewModel.hasMore &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          viewModel.fetchProducts();
        }
        return true;
      },
      child: ListView.builder(
        itemCount: viewModel.products.length + (viewModel.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= viewModel.products.length) {
            return Center(child: CircularProgressIndicator());
          }

          final product = viewModel.products[index];
          return buildProductItem(context, product, viewModel);
        },
      ),
    );
  }
}
