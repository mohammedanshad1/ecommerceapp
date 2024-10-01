import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';
import 'package:innoitlabsmachintest/core/utils/responsive.dart';
import 'package:innoitlabsmachintest/screens/cartscreen/view/cartscreen_view.dart';
import 'package:innoitlabsmachintest/screens/favouritescreen/view/favouritescreen_view.dart';
// Import your Profile screen
import 'package:innoitlabsmachintest/screens/productdetailscreen/view/productdetailscreen_view.dart';
import 'package:innoitlabsmachintest/screens/profilescreen/view/profilescreen_view.dart';
import 'package:innoitlabsmachintest/shared/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:innoitlabsmachintest/screens/homescreen/viewmodel/homescreen_viewmodel.dart';

class HomeScreenView extends StatefulWidget {
  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int _currentIndex = 0; // Track the current index of the bottom navigation bar

  // List of screens for the bottom navigation
  final List<Widget> _screens = [
    HomeContent(), // Your Home Content widget
    CartScreen(), // Replace with your Cart screen
    FavoritesScreen(), // Replace with your Favorites screen
    ProfileScreen(), // Replace with your Profile screen
  ];

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
      body: _screens[_currentIndex], // Update body to show current screen
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on tap
          });
        },
      ),
    );
  }
}

// New Home Content widget to display products
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Consumer<HomeScreenViewModel>(builder: (context, viewModel, child) {
      if (viewModel.loading) {
        return Center(child: CircularProgressIndicator());
      }

      if (viewModel.products.isEmpty) {
        return Center(
          child: Text(
            'No Products Found',
            style: appTypography.regular.copyWith(fontSize: responsive.sp(16)),
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
                  builder: (context) => ProductDetailScreen(product: product),
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
                              color: Colors.green, fontSize: responsive.sp(14)),
                        ),
                        SizedBox(height: responsive.hp(1)),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.yellow, size: responsive.sp(12)),
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
            ),
          );
        },
      );
    });
  }
}
