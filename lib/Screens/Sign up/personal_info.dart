import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Screens/Sign up/Elements/personal_text_fields.dart';
import 'package:eshnly/Screens/Sign%20up/Elements/signup_with_google.dart';
import 'package:eshnly/Screens/login_page.dart';
import 'package:eshnly/Screens/Sign up/sign_up _as.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height*0.05,),
              Text('Sign Up', style: TextStyle(color: green1, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height*0.03,),
              PersonalInfoFields(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: size.width*0.8,
                child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpAs())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: green1,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 20,),),
                ),
              ),
              GoogleSignup(),
              SizedBox(height: size.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?", style: TextStyle(fontSize: 17)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login())
                      );
                    },
                    child: const Text('Log in', style: TextStyle(
                        fontSize: 17,
                        color: green1,
                        fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: size.height*0.05,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
