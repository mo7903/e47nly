import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Elements/input_field.dart';

class EVInfo extends StatelessWidget {
  const EVInfo({Key? key}) : super(key: key);

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
          Text('Your EV Info', style: TextStyle(color: green1, fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: size.height*0.1,),
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'Vehicle Model',
              icon: Icon(Icons.electric_car, color: green2,),
            ),
          ),),
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'Needed Charger Type',
              icon: Icon(Icons.charging_station, color: green2,),
            ),
          ),),
          SizedBox(height: size.height*0.1,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: size.width*0.8,
            child:
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: green1,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 20,),),
            ),
          ),
      Container(
        width: size.width*0.8,
        child: Row(
            children: const <Widget>[
              Expanded(child: Divider(color: black, height: 2.5,),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('OR', style: TextStyle(color: black, fontSize: 10,),),
              ),
              Expanded(child: Divider(color: black, height: 1.5,),),
            ],
          ),
      ),
          TextButton(
            onPressed: () {},
            child: Text('Skip for now', style: TextStyle(color: black),),
          ),
        ],
      ),
    ),
    );
  }
}
