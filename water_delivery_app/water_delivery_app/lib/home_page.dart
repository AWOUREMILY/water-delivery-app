import 'package:flutter/material.dart';
import 'auth_service.dart';

import 'product_page.dart';
import 'cart_page.dart';
import 'customer_page.dart';
import 'api_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final auth = AuthService();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),

      appBar: AppBar(
        title: const Text("💧 Water Delivery Dashboard"),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Welcome, $username 👋",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A4A4A),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [

                  _buildCard(
                    context,
                    icon: Icons.water_drop,
                    iconColor: const Color(0xFF00A8E8),
                    title: "Order Water",
                    subtitle: "Browse and add water products",
                    page: const ProductPage(),
                  ),

                  _buildCard(
                    context,
                    icon: Icons.shopping_cart,
                    iconColor: const Color(0xFF6C63FF),
                    title: "Cart",
                    subtitle: "View items before checkout",
                    page: const CartPage(),
                  ),

                  _buildCard(
                    context,
                    icon: Icons.people,
                    iconColor: const Color(0xFF00B894),
                    title: "Customers",
                    subtitle: "Manage customer records",
                    page: const CustomerPage(),
                  ),

                  _buildCard(
                    context,
                    icon: Icons.api,
                    iconColor: const Color(0xFFFFA502),
                    title: "Orders API",
                    subtitle: "View orders from Firestore",
                    page: const ApiPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
    Color iconColor = Colors.blue,
  }) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF7F8C8D)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFFB0B0B0),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}