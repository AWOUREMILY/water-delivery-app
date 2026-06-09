import 'package:flutter/material.dart';
import 'cart_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: Column(
        children: [

          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("Cart is empty"))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.water_drop),
                          title: Text(item.name),
                          subtitle: Text(
                            "KSh ${item.price} x ${item.quantity}",
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              // ➖ decrease
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                  } else {
                                    cartItems.removeAt(index);
                                  }
                                  refresh();
                                },
                              ),

                              // ➕ increase
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  item.quantity++;
                                  refresh();
                                },
                              ),

                              // 🗑 delete
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cartItems.removeAt(index);
                                  refresh();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // TOTAL SECTION
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.blue.shade50,
            child: Text(
              "Total: KSh ${getTotalPrice()}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // CHECKOUT BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Checkout"),
                        content: const Text("Do you want to confirm your order?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Order Confirmed")),
                              );
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Checkout"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  

