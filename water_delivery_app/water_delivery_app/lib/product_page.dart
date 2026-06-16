import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_service.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartService();
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid; // nullable UID; handle when user is not signed in

    final products = [
      {"name": "20L Water", "price": 5000},
      {"name": "10L Water", "price": 3000},
      {"name": "5L Water", "price": 1500},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Water"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.water_drop,
                color: Colors.blue,
              ),
              title: Text(
                item["name"].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "KSh ${item["price"]}",
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  try {
                    if (uid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please sign in first"),
                        ),
                      );
                      return;
                    }

                    print("Add button clicked");

                    await cart.addToCart(
                      uid,
                      {
                        "name": item["name"],
                        "price": item["price"],
                      },
                    );

                    print("Item added successfully");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${item["name"]} added to cart",
                        ),
                      ),
                    );
                  } catch (e) {
                    print("ERROR: $e");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Error: $e",
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Add"),
              ),
            ),
          );
        },
      ),
    );
  }
}