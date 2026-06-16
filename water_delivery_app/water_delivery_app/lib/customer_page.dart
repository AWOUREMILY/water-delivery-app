import 'package:flutter/material.dart';
import 'customer_service.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final CustomerService service = CustomerService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void showForm({int? index}) {
    if (index != null) {
      final customer = service.getCustomers()[index];
      nameController.text = customer["name"]!;
      phoneController.text = customer["phone"]!;
    } else {
      nameController.clear();
      phoneController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Add Customer" : "Edit Customer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final data = {
                  "name": nameController.text,
                  "phone": phoneController.text,
                };

                if (index == null) {
                  service.addCustomer(data);
                } else {
                  service.updateCustomer(index, data);
                }
              });

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customers = service.getCustomers();

    return Scaffold(
      appBar: AppBar(title: const Text("Customers")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(),
        child: const Icon(Icons.add),
      ),
      body: customers.isEmpty
          ? const Center(child: Text("No customers yet"))
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final c = customers[index];

                return ListTile(
                  title: Text(c["name"] ?? ""),
                
                  subtitle: Text(c["phone"] ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showForm(index: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            service.deleteCustomer(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}