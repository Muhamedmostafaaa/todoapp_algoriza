import 'package:flutter/material.dart';

class TextDesign extends StatelessWidget{
  String text;
  TextDesign({required this.text});
  @override
  Widget build(BuildContext context) {
   return Text(
     text,
     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
   );
  }

}