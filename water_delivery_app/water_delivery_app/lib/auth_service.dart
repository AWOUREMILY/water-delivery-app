import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  final String baseUrl = "http://10.210.130.207/water_delivery_api";

  Future<Map<String, dynamic>?> register(
      String email, String password) async {

    try {
      var response = await http.post(
        Uri.parse("$baseUrl/register.php"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "email": email,
          "password": password,
        },
      );

      // DEBUG LINES - ADD HERE
      print("Register Status Code: ${response.statusCode}");
      print("Register Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

    } catch (e) {
      print("Register Error: $e");
    }

    return null;
  }


  Future<Map<String, dynamic>?> login(
      String email, String password) async {

    try {
      var response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "email": email,
          "password": password,
        },
      );

      
      print("Login Status Code: ${response.statusCode}");
      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

    } catch (e) {
      print("Login Error: $e");
    }

    return null;
  }
}