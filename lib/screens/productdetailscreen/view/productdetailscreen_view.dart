import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/screens/cartscreen/view/cartscreen_view.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/viewmodel/productview_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';
import 'package:innoitlabsmachintest/core/utils/responsive.dart';
import 'package:innoitlabsmachintest/screens/homescreen/model/homescreen_model.dart';
import 'package:innoitlabsmachintest/widgets/custom_button.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart'; // Import the snackbar package
import 'package:innoitlabsmachintest/widgets/custom_snackbar.dart'; // Ensure you have the correct path for your CustomSnackBar

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: appTypography.bold.copyWith(fontSize: responsive.sp(18)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
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
                    style: appTypography.bold
                        .copyWith(color: Colors.green, fontSize: 20),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(responsive.wp(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              buttonName: "Favorite",
              onTap: () async {
                await Provider.of<ProductViewModel>(context, listen: false)
                    .addToFavorites(product.id);
                CustomSnackBar.show(
                  context,
                  snackBarType: SnackBarType.success,
                  label: "Added to Favorites Successfully",
                  bgColor: Colors.green, // You can customize this as needed
                );
              },
              buttonColor: Colors.red,
              height: responsive.hp(7),
              width: responsive.wp(45),
            ),
            CustomButton(
              buttonName: "Add to Cart",
              onTap: () async {
                await Provider.of<ProductViewModel>(context, listen: false)
                    .addToCart(product.id as int);
                CustomSnackBar.show(
                  context,
                  snackBarType: SnackBarType.success,
                  label: "Added to Cart Successfully",
                  bgColor: Colors.green, // You can customize this as needed
                );
              },
              buttonColor: Colors.green,
              height: responsive.hp(7),
              width: responsive.wp(45),
            ),
          ],
        ),
      ),
    );
  }
}
