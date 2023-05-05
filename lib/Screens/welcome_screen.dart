import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Screens/login_page.dart';
import 'package:eshnly/integration/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [lightGreen1, green2],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.1,),
            Image.asset(
              'assets/images/logo_white.png',
              height: size.height*0.3,
            ),
            const Text(
              'Find your nearest secure EV charge',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height*0.2,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ElevatedButton(
                onPressed: ()
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())
                  );
                }
                ,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    color: black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
