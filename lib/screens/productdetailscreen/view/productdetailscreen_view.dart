import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';

import 'package:innoitlabsmachintest/screens/homescreen/model/homescreen_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle add to cart functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: appTypography.bold.copyWith(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: appTypography.bold.copyWith(color: Colors.green, fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product.description,
                    style: appTypography.regular.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
