import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E47nly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: green2,
      ),
      home: Welcome(),
    );
  }
}