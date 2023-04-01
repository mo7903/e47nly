import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Elements/input_field.dart';
import 'package:eshnly/Screens/Sign up/personal_info.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logo_green.png',
              height: size.height*0.3,
            ),
            const InputField(child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                icon: Icon(Icons.email, color: green2,),
              ),
            ),),
            const InputField(child: TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.lock, color: green2,),
                suffixIcon: Icon(Icons.visibility, color: green2,),
              ),
              obscureText: true,
            ),),
            GestureDetector(
              onTap: () {},
              child: Text('Forgot password?', style: const TextStyle(color: black),),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: size.width*0.8,
              child:
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: green1,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Log in', style: TextStyle(fontSize: 20,),),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?", style: TextStyle(fontSize: 17)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signup())
                    );
                  },
                  child: const Text('Sign up', style: TextStyle(
                      fontSize: 17,
                      color: green1,
                      fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
