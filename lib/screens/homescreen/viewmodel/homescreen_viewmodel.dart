import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/homescreen_model.dart';

class HomeScreenViewModel with ChangeNotifier {
  List<Products> _products = [];
  List<Products> _filteredProducts = [];
  bool _loading = false;

  List<Products> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;
  bool get loading => _loading;

  // Fetch products from the API
  Future<void> fetchProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    _loading = true;
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _products = jsonData.map((data) => Products.fromJson(data)).toList();
        _filteredProducts = []; // Reset filtered products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print("Error fetching products: $error");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Search products based on the title
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = []; // Reset to show all products
    } else {
      _filteredProducts = _products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
  // Add this method to your HomeScreenViewModel
void filterByCategory(Category category) {
  if (category == Category.ELECTRONICS) {
    _filteredProducts = _products.where((product) => product.category == Category.ELECTRONICS).toList();
  } else if (category == Category.JEWELERY) {
    _filteredProducts = _products.where((product) => product.category == Category.JEWELERY).toList();
  } else if (category == Category.MEN_S_CLOTHING) {
    _filteredProducts = _products.where((product) => product.category == Category.MEN_S_CLOTHING).toList();
  } else if (category == Category.WOMEN_S_CLOTHING) {
    _filteredProducts = _products.where((product) => product.category == Category.WOMEN_S_CLOTHING).toList();
  } else {
    _filteredProducts = []; // Reset if no category is selected
  }
  notifyListeners();
}

}
