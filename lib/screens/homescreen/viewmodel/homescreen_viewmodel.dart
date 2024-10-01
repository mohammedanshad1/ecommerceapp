import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/homescreen_model.dart';


class HomeScreenViewModel with ChangeNotifier {
  List<Products> _products = [];
  bool _loading = false;

  List<Products> get products => _products;
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
}
