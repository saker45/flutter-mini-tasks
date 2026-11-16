import 'package:flutter/material.dart';

import 'cart_model.dart';

/// Screen 2 of Task 4: shows the same shared cart, lets the user change
/// quantities, and shows the total.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final entries = cart.items.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          if (entries.isNotEmpty)
            IconButton(
              tooltip: 'Clear cart',
              icon: const Icon(Icons.delete_outline),
              onPressed: cart.clear,
            ),
        ],
      ),
      body: entries.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (final e in entries)
                        ListTile(
                          leading: Icon(e.key.icon),
                          title: Text(e.key.name),
                          subtitle: Text(
                            '\$${e.key.price.toStringAsFixed(2)} each',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => cart.removeOne(e.key),
                              ),
                              Text('${e.value}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cart.add(e.key),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Text(
                    'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                    key: const Key('totalText'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
    );
  }
}
