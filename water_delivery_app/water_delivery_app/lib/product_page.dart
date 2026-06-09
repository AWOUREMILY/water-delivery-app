import 'package:flutter/material.dart';
import 'cart_data.dart';
import 'cart_model.dart';
import 'cart_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  final List<Map<String, dynamic>> products = const [
    {"name": "20L Water Bottle", "price": 50},
    {"name": "10L Water Bottle", "price": 30},
    {"name": "5L Water Bottle", "price": 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          )
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product["name"]} tapped"),
                ),
              );
            },

            child: Card(
              child: ListTile(
                leading: const Icon(Icons.water_drop, color: Colors.blue),
                title: Text(product["name"]),
                subtitle: Text("KSh ${product["price"]}"),

                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cartItems.add(
                      CartItem(
                        name: product["name"],
                        price: product["price"],
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to cart")),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}