import 'package:flutter/material.dart';
import 'responsive.dart';
import 'spacing.dart';
import 'product_page.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pure Water Delivery'),

        // ✅ STEP 4: MENU ADDED HERE
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: "home",
                child: Text("Home"),
              ),
              PopupMenuItem(
                value: "cart",
                child: Text("Cart"),
              ),
            ],
            onSelected: (value) {
              if (value == "cart") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                );
              }
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Welcome $username",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.medium),

            Container(
              width: Responsive.width(context) * 0.9,
              padding: const EdgeInsets.all(AppSpacing.medium),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Order fresh clean water easily from your phone. Fast and reliable delivery.",
                style: TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: AppSpacing.large),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ProductPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
                  
              },
              child: const Text("Order Water"),
            ),

            const SizedBox(height: AppSpacing.medium),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: const Text("View Orders"),
            ),
          ],
        ),
      ),
    );
  }
}