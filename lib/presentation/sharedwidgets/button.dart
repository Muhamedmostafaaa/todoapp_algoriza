import 'package:flutter/material.dart';

class button extends StatelessWidget {
  String text;
  VoidCallback onclick;
  button({required this.text,required this.onclick});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 35),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                primary: Colors.green),
            onPressed: onclick,
            child: Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )));
  }
}
