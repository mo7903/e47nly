import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Elements/input_field.dart';

class ChargerInfo extends StatelessWidget {
  const ChargerInfo({Key? key}) : super(key: key);

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
        child: Container(
            width: size.width*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Charger Info', style: TextStyle(color: green1, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height*0.1,),
              InputField(child: DropdownButtonFormField(
                hint: Text('Residence Area'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city, color: green2,),
                ),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(child: Text('El-Sheikh Zayed'), value: 'Zayed',),
                  DropdownMenuItem(child: Text('6th of October'), value: 'October',),
                  DropdownMenuItem(child: Text('Madinat Nasr'), value: 'Madinat Nasr',),
                  DropdownMenuItem(child: Text('Al-Obour'), value: 'Obour',),
                  DropdownMenuItem(child: Text('Alexandria'), value: 'Alexandria',),
                ],
                onChanged: null,
              ),),
              const InputField(child: TextField(
                decoration: InputDecoration(
                  hintText: 'Charger Type',
                  icon: Icon(Icons.charging_station, color: green2,),
                ),
              ),),
              const InputField(child: TextField(
                decoration: InputDecoration(
                  hintText: 'National ID',
                  icon: Icon(Icons.perm_identity, color: green2,),
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
              TextButton(
                onPressed: () {},
                child: Text('Skip for now', style: TextStyle(color: black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
