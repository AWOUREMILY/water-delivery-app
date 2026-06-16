import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List users = [];
final nameController = TextEditingController();
final emailController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        isLoading = false;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("API Records"),
    ),

    body: isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [

              // 🔹 INPUT FIELDS
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                      ),
                    ),

                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔴 ADD BUTTON
                    ElevatedButton(
                      onPressed: () {
                        (
                          nameController.text,
                          emailController.text,
                        );

                        nameController.clear();
                        emailController.clear();
                      },
                      child: const Text("Add Record"),
                    ),
                  ],
                ),
              ),

              // 🔹 LIST VIEW
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(users[index]['name']),
                      subtitle: Text(users[index]['email']),
                    );
                  },
                ),
              ),
            ],
          ),
  );
}
}