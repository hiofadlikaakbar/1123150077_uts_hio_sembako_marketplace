import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_models.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  CartProvider() {
    loadCart();
  }

  void addToCart(Product product) {
    _items.add(product);
    saveCart();
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    saveCart();
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }

  void clearCart() {
    _items.clear();
    saveCart();
    notifyListeners();
  }
}
