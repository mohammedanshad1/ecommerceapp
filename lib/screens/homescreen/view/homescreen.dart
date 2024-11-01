import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:innoitlabsmachintest/core/constants/app_typography.dart';
import 'package:innoitlabsmachintest/core/utils/responsive.dart';
import 'package:innoitlabsmachintest/screens/cartscreen/view/cartscreen_view.dart';
import 'package:innoitlabsmachintest/screens/favouritescreen/view/favouritescreen_view.dart';
import 'package:innoitlabsmachintest/screens/homescreen/model/homescreen_model.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/view/productdetailscreen_view.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/viewmodel/productview_viewmodel.dart';
import 'package:innoitlabsmachintest/screens/profilescreen/view/profilescreen_view.dart';
import 'package:innoitlabsmachintest/shared/bottom_navbar.dart';
import 'package:innoitlabsmachintest/widgets/custom_snackbar.dart';
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
    HomeContent(), // Home Content widget
    CartScreen(), // Cart Screen
    FavoritesScreen(), // Favorites Screen
    ProfileScreen(), // Profile Screen
  ];

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<HomeScreenViewModel>(context, listen: false).fetchProducts();
  });
}
  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: appTypography.bold.copyWith(fontSize: responsive.sp(18)),
        ),
        actions: _currentIndex == 0 // Show filter icon only on Home screen
            ? [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterOptions(context); // Show filter options
                  },
                ),
              ]
            : [], // Empty list when not on the Home screen
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 1:
        return "Cart";
      case 2:
        return "Favorites";
      case 3:
        return "Profile";
      default:
        return "Home";
    }
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: responsive.wp(4), vertical: responsive.hp(2)),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });

              Provider.of<HomeScreenViewModel>(context, listen: false)
                  .searchProducts(_searchQuery);
            },
            decoration: InputDecoration(
              hintText: 'Search for products...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Consumer<HomeScreenViewModel>(
              builder: (context, viewModel, child) {
            if (viewModel.loading) {
              return Center(child: CircularProgressIndicator());
            }

            final filteredProducts = viewModel.products.where((product) {
              return product.title.toLowerCase().contains(_searchQuery);
            }).toList();

            if (filteredProducts.isEmpty) {
              return Center(
                child: Text(
                  'No Products Found',
                  style: appTypography.regular
                      .copyWith(fontSize: responsive.sp(16)),
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
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

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
                  child: Stack(
                    children: [
                      Card(
                        elevation:
                            5, // Increase the elevation for a more prominent look
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
                                        style: appTypography.regular.copyWith(
                                            fontSize: responsive.sp(12)),
                                      ),
                                      SizedBox(width: responsive.wp(1)),
                                      Text(
                                        '(${product.rating.count} reviews)',
                                        style: appTypography.regular.copyWith(
                                            fontSize: responsive.sp(12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add Cart Icon in the top right corner
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius:
                              responsive.wp(6), // Adjust the size of the icon
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart),
                            color: Colors.green,
                            onPressed: () {
                              Provider.of<ProductViewModel>(context,
                                      listen: false)
                                  .addToCart(
                                      product.id); // Add product to the cart
                              CustomSnackBar.show(
                                context,
                                snackBarType: SnackBarType.success,
                                label: "Added to Favorites Successfully",
                                bgColor: Colors
                                    .green, // You can customize this as needed
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

void _showFilterOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: Category.values.map((category) {
            return ListTile(
              title: Text(
                toCamelCase(categoryValues.reverse[category]!),
                style: appTypography.regular
                    .copyWith(fontSize: (17), color: Colors.black),
              ), // Convert to camel case
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Provider.of<HomeScreenViewModel>(context, listen: false)
                    .filterByCategory(category);
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

String toCamelCase(String text) {
  return text.split(' ').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
