import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';
import 'package:innoitlabsmachintest/core/utils/responsive.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/view/productdetailscreen_view.dart';
import 'package:innoitlabsmachintest/shared/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:innoitlabsmachintest/screens/homescreen/viewmodel/homescreen_viewmodel.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int _currentIndex = 0; // Track the current index of the bottom navigation bar

  @override
  void initState() {
    super.initState();
    // Fetch products when the screen initializes
    Provider.of<HomeScreenViewModel>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive; // Access responsive instance

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: appTypography.bold.copyWith(fontSize: responsive.sp(18)),
        ),
      ),
      body: Consumer<HomeScreenViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.products.isEmpty) {
            return Center(
              child: Text(
                'No Products Found',
                style:
                    appTypography.regular.copyWith(fontSize: responsive.sp(16)),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(responsive.wp(4)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive.width > 600 ? 3 : 2,
              crossAxisSpacing: responsive.wp(3),
              mainAxisSpacing: responsive.hp(2),
              childAspectRatio: 0.7,
            ),
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              final product = viewModel.products[index];

              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(responsive.wp(3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(responsive.wp(3)),
                              topRight: Radius.circular(responsive.wp(3)),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(responsive.wp(3)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: appTypography.semiBold
                                    .copyWith(fontSize: responsive.sp(14)),
                              ),
                              SizedBox(height: responsive.hp(1)),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: appTypography.bold.copyWith(
                                    color: Colors.green,
                                    fontSize: responsive.sp(14)),
                              ),
                              SizedBox(height: responsive.hp(1)),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.yellow,
                                      size: responsive.sp(12)),
                                  SizedBox(width: responsive.wp(1)),
                                  Text(
                                    '${product.rating.rate}',
                                    style: appTypography.regular
                                        .copyWith(fontSize: responsive.sp(12)),
                                  ),
                                  SizedBox(width: responsive.wp(1)),
                                  Text(
                                    '(${product.rating.count} reviews)',
                                    style: appTypography.regular
                                        .copyWith(fontSize: responsive.sp(12)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on tap
          });
          // Handle navigation logic here based on the selected index
          switch (index) {
            case 0:
              // Navigate to Home
              // You can use Navigator.pushNamed(context, '/home'); or other navigation methods
              break;
            case 1:
              // Navigate to Cart
              // Navigator.pushNamed(context, '/cart');
              break;
            case 2:
              // Navigate to Favorites
              // Navigator.pushNamed(context, '/favorites');
              break;
            case 3:
              // Navigate to Settings
              // Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
