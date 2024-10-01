import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProductViewModel extends ChangeNotifier {
  List<int> _favorites = [];
  List<int> _cartItems = [];

  List<int> get favorites => _favorites;
  List<int> get cartItems => _cartItems;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = (prefs.getStringList('favorites') ?? []).map(int.parse).toList();
    notifyListeners();
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    _cartItems = (prefs.getStringList('cart') ?? []).map(int.parse).toList();
    notifyListeners();
  }

  Future<void> addToFavorites(int productId) async {
    if (!_favorites.contains(productId)) {
      _favorites.add(productId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favorites.map((id) => id.toString()).toList());
      notifyListeners();
    }
  }

  Future<void> addToCart(int productId) async {
    if (!_cartItems.contains(productId)) {
      _cartItems.add(productId);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('cart', _cartItems.map((id) => id.toString()).toList());
      notifyListeners();
    }
  }
  Future<void> removeFromFavorites(int productId) async {
  _favorites.remove(productId);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favorites', _favorites.map((id) => id.toString()).toList());
  notifyListeners();
}

Future<void> removeFromCart(int productId) async {
  _cartItems.remove(productId);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('cart', _cartItems.map((id) => id.toString()).toList());
  notifyListeners();
}

}

  