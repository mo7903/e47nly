import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';

class InputField extends StatelessWidget {
  final Widget child;
  const InputField({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      padding: EdgeInsets.fromLTRB(15, 1, 15, 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: fadedGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
