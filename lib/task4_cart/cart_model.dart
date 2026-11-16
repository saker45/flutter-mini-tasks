import 'package:flutter/material.dart';

class Product {
  const Product(this.id, this.name, this.price, this.icon);

  final int id;
  final String name;
  final double price;
  final IconData icon;
}

const List<Product> kProducts = [
  Product(1, 'Headphones', 59.99, Icons.headphones),
  Product(2, 'Keyboard', 39.50, Icons.keyboard),
  Product(3, 'Mouse', 19.99, Icons.mouse),
  Product(4, 'Monitor', 149.00, Icons.monitor),
  Product(5, 'Webcam', 29.90, Icons.videocam),
];

/// Shared state: one instance lives above the Navigator, so every screen
/// sees the same cart.
class CartModel extends ChangeNotifier {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => Map.unmodifiable(_items);

  int get totalItems => _items.values.fold(0, (sum, q) => sum + q);

  double get totalPrice =>
      _items.entries.fold(0.0, (sum, e) => sum + e.key.price * e.value);

  int quantityOf(Product p) => _items[p] ?? 0;

  void add(Product p) {
    _items[p] = quantityOf(p) + 1;
    notifyListeners();
  }

  void removeOne(Product p) {
    final q = quantityOf(p);
    if (q <= 1) {
      _items.remove(p);
    } else {
      _items[p] = q - 1;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Exposes [CartModel] to the widget tree and rebuilds dependents on change.
class CartScope extends InheritedNotifier<CartModel> {
  const CartScope({
    super.key,
    required CartModel cart,
    required super.child,
  }) : super(notifier: cart);

  static CartModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope found in context');
    return scope!.notifier!;
  }
}
