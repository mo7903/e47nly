import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginInt {
  String email;
  String password;

  LoginInt({required this.email, required this.password});
}

class TodoProvider with ChangeNotifier {
  final url = 'http://127.0.0.1:5000/ev_owners/login';

  Future<String> login(String email, String password) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'password': password});
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    final responsePayload = json.decode(response.body);

    if (response.statusCode == 200) {
      // Login successful
      return '';
    } else {
      // Login failed
      return responsePayload['error'] ?? 'An error occurred while logging in';
    }
  }
}
