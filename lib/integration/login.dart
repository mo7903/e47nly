
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eshnly/Screens/login_page.dart';
import 'package:eshnly/main.dart';
import 'package:eshnly/Screens/welcome_screen.dart';
import 'package:http/http.dart' as http;

class login{
  String username;
  String password;

  login({required this.username, required this.password});
}


class TodoProvider with ChangeNotifier {
  final url = 'http://127.0.0.1:5000/login';
  Future<void> addTodo(String task) async {
    Map<String, dynamic> request = { "is_executed": false};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(Uri.parse(url), headers: headers);
    Map<String, dynamic> responsePayload = json.decode(response.body);

}}