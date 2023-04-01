import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Screens/Sign up/charger_info.dart';
import 'package:eshnly/Screens/Sign up/EV_info.dart';

class SignUpAs extends StatelessWidget {
  const SignUpAs({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Sign up as...', style: TextStyle(color: black, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height*0.05,),
              Text('EV Owner', style: TextStyle(color: black, fontSize: 25, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EVInfo())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Image.asset('assets/images/EV.png', height: size.height*0.2,),
                ),
              ),
              Text('Charger Owner', style: TextStyle(color: black, fontSize: 25, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChargerInfo())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Image.asset('assets/images/charger.png', height: size.height*0.2,),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
