import 'package:flutter/material.dart';

import 'cart_model.dart';
import 'cart_screen.dart';

/// Screen 1 of Task 4: product list with an "add to cart" button
/// and a cart badge in the app bar.
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4 - Shop'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge(
              isLabelVisible: cart.totalItems > 0,
              label: Text('${cart.totalItems}'),
              child: IconButton(
                key: const Key('openCart'),
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: kProducts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final p = kProducts[index];
          final qty = cart.quantityOf(p);
          return ListTile(
            leading: Icon(p.icon, size: 32),
            title: Text(p.name),
            subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (qty > 0) Text('x$qty  '),
                IconButton(
                  key: Key('add_${p.id}'),
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () => cart.add(p),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
