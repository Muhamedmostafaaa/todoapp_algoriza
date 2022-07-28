import 'package:flutter/material.dart';

class TextTextformfileld extends StatelessWidget {
  TextEditingController controller;
  String text;
  String hinttext;
  VoidCallback? ontap;
  String? Function(String?)? validate;
  TextInputType type;
  IconData? icon;
  Widget? suffixicon;

  TextTextformfileld(
      {required this.controller,
      required this.text,
      required this.hinttext,
      this.ontap,
       this.validate,
      required this.type,
      this.icon,
      this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(

            keyboardType: type,
            validator: validate,
            onTap: ontap,
            controller: controller,
            decoration: InputDecoration(
                isDense: true,
              suffixIcon:suffixicon ,
                prefixIcon: Icon(icon),
                hintText: hinttext,
                hintStyle: TextStyle(color: Colors.black12,fontSize: 12,),
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
          ),
        ],
      ),
    );
  }
}
