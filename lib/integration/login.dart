import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login {
  String email;
  String password;

  Login({required this.email, required this.password});
}

class TodoProvider with ChangeNotifier {
  final url = 'http://192.168.1.7:5000/login/ev_owners';

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
