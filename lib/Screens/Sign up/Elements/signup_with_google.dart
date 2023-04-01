import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';

class GoogleSignup extends StatelessWidget {
  const GoogleSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(child: Divider(color: black, height: 2.5,),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('OR', style: TextStyle(color: black, fontSize: 10,),),
              ),
              Expanded(child: Divider(color: black, height: 1.5,),),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Image.asset('assets/images/google icon.png',scale: 1.4,),
                SizedBox(width: size.width*0.03,),
                Text('Continue with Google', style: TextStyle(fontSize: 20, color: black),)
              ],),),
          ),
        ],
      ),
    );
  }
}
