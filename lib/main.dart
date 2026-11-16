import 'package:flutter/material.dart';

import 'task2_interactive_ui.dart';
import 'task3_profile_ui.dart';
import 'task4_cart/cart_model.dart';
import 'task4_cart/product_list_screen.dart';

void main() => runApp(const MiniTasksApp());

class MiniTasksApp extends StatefulWidget {
  const MiniTasksApp({super.key});

  @override
  State<MiniTasksApp> createState() => _MiniTasksAppState();
}

class _MiniTasksAppState extends State<MiniTasksApp> {
  // Created once; lives above MaterialApp so every route shares it.
  final CartModel _cart = CartModel();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        title: 'Flutter Mini Tasks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Mini Tasks')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.touch_app),
              title: const Text('Task 2: Interactive UI'),
              subtitle: const Text('Red box, tap counter, colour box'),
              onTap: () => _open(context, const InteractiveBoxesScreen()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Task 3: Static Profile UI'),
              subtitle: const Text('Profile / dashboard screen'),
              onTap: () => _open(context, const ProfileScreen()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Task 4: Shared-state Cart'),
              subtitle: const Text('Multi-screen app, shared cart'),
              onTap: () => _open(context, const ProductListScreen()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Task 1 (CLI app) is in bin/cli_app.dart.\n'
              'Run it with: dart run bin/cli_app.dart',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
