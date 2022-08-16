import 'package:flutter/material.dart';

class SingleTask extends StatelessWidget{
  Map item;
  Color color;
  SingleTask({required this.item,required this.color});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 80,
      margin:
      EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 17, vertical: 13),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['starttime'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(item['tittle'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ],

            ),
            Spacer(),
            Container(
              width: 20,height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),

              ),
              child:
               Center(child:item['status']=='complete'?
               Icon(Icons.check,color: Colors.white,size: 12,):Container()),
            )
          ],
        ),
      ),
    );
  }

}