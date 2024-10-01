import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/screens/homescreen/viewmodel/homescreen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/viewmodel/productview_viewmodel.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteItems = Provider.of<ProductViewModel>(context).favorites;
    final products = Provider.of<HomeScreenViewModel>(context).products;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Your Favorites"),
      // ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('No favorite products.'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final productId = favoriteItems[index];
                final product =
                    products.firstWhere((prod) => prod.id == productId);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          // Display the product image
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(product.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Display product title and price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Close icon to remove from favorites
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ProductViewModel>(context,
                                    listen: false)
                                .removeFromFavorites(productId);
                          },
                          child: Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
