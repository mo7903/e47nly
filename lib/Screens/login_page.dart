import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eshnly/constants.dart';
import 'package:eshnly/Elements/input_field.dart';
import 'package:eshnly/Screens/Sign up/personal_info.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("E47nly"),
        backgroundColor: green1,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo_green.png',
                height: size.height * 0.3,
              ),
              InputField(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(Icons.email, color: green2,),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              InputField(
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(Icons.lock, color: green2,),
                    suffixIcon: Icon(Icons.visibility, color: green2,),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text('Forgot password?', style: const TextStyle(color: black),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final todoProvider = TodoProvider();
                      final result = await todoProvider.login(email, password);
                      if (result.isEmpty) {
                        // Login successful
                      } else {
                        // Login failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: green1,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 20,),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?", style: TextStyle(fontSize: 17)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 17,
                        color: green1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}