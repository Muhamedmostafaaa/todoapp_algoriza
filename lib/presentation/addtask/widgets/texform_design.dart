import 'package:flutter/material.dart';

class TextFormDesign extends StatelessWidget{
  TextEditingController controller;
  String hinttext;
  VoidCallback? ontap;
  String? Function(String?)? validate;
  TextInputType type;
  IconData? icon;
  Widget? suffixicon;
  double? fontsize;

  TextFormDesign({
    required this.controller,
    required this.hinttext,
    this.ontap,
    this.validate,
    required this.type,
    this.icon,
    this.suffixicon,this.fontsize:16

});

  @override
  Widget build(BuildContext context) {
  return TextFormField(
style: TextStyle(fontSize: fontsize),
    keyboardType: type,
    validator: validate,
    onTap: ontap,
    controller: controller,
    decoration: InputDecoration(

        suffixIcon:suffixicon ,
        prefixIcon: Icon(icon),
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.black12,fontSize: 14,),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12))),
  );
  }

}