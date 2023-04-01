import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
import 'package:eshnly/Elements/input_field.dart';

class PersonalInfoFields extends StatelessWidget {
  const PersonalInfoFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const <Widget>[
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'First Name',
              icon: Icon(Icons.person, color: green2,),
            ),
          ),),
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'Last Name',
              icon: Icon(Icons.person, color: green2,),
            ),
          ),),
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              icon: Icon(Icons.email, color: green2,),
            ),
          ),),
          InputField(child: TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              icon: Icon(Icons.lock, color: green2,),
              suffixIcon: Icon(Icons.visibility, color: green2,),
            ),
            obscureText: true,
          ),),
          InputField(child: TextField(
            inputFormatters: [],
            decoration: InputDecoration(
              hintText: 'Phone Number',
              icon: Icon(Icons.phone, color: green2,),
            ),
          ),),
        ],
      ),
    );
  }
}
