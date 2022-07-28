import 'package:flutter/material.dart';

class Favoritecolor extends StatelessWidget{
  Color color;
  String tapedcolor;
  Function ontap;
  Favoritecolor({required this.color,required this.ontap,required this.tapedcolor});
  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: (){
      ontap(tapedcolor);
    },
      child: Container(
        width: 20,height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),color: color,
        ),
      ),
    );
  }

}