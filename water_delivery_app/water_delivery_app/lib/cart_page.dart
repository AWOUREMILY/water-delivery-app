import 'package:flutter/material.dart';
import 'cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService cart = CartService();

  @override
  Widget build(BuildContext context) {
    final items = cart.getCartItems();

    double total = 0;
    for (var item in items) {
      total += item["price"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text("Cart is empty"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return ListTile(
                        leading: const Icon(Icons.water_drop),
                        title: Text(item["name"]),
                        subtitle: Text(
                          "KSh ${item["price"]}",
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: KSh $total",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.clear();
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Order placed successfully",
                              ),
                            ),
                          );
                        },
                        child: const Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}