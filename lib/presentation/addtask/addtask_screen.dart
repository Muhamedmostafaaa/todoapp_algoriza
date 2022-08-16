import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';
import 'package:todoapp_algoriza/presentation/addtask/widgets/favoritecolor.dart';
import 'package:todoapp_algoriza/presentation/addtask/widgets/texform_design.dart';
import 'package:todoapp_algoriza/presentation/addtask/widgets/text_design.dart';

import 'package:intl/intl.dart';
import 'package:todoapp_algoriza/presentation/sharedwidgets/button.dart';

class Addtaskscreen extends StatelessWidget {
  static const ROUTE_NAME = 'addtaskscreen';
  TextEditingController titlecontrolller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();
  TextEditingController remincontroller = TextEditingController();

  final formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return

       BlocConsumer<Appcubit,AppStates>(listener: (context,states){},
         builder: (context,states){
         var cubit =BlocProvider.of<Appcubit>(context);
         return Scaffold( resizeToAvoidBottomInset: false,
           body: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               const SizedBox(
                 height: 70,
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Row(
                   children:  [
                     InkWell(onTap:(){
                       Navigator.pop(context);
                     } ,
                       child: Icon(
                         Icons.arrow_back_ios_sharp,
                         size: 18,
                       ),
                     ),
                     SizedBox(
                       width: 20,
                     ),
                     Text(
                       'Add task',
                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,
               ),
               Divider(
                 thickness: 1,
                 color: Colors.grey,
               ),
               SizedBox(
                 height: 20,
               ),
               Form(key: formkey,
                 child: SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 12),
                     child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                         TextDesign(text: 'Title'),
                         SizedBox(height: 10,),
                         TextFormDesign(

                           type: TextInputType.text,
                           icon: Icons.title,
                           controller: titlecontrolller,
                           hinttext: 'Enter task tittle',
                           validate: (value) {
                             if (value!.isEmpty) {
                               return 'please enter the task tittle';
                             }
                           },
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         TextDesign(text: 'Date'),
                         SizedBox(height: 10,),
                         TextFormDesign(

                           type: TextInputType.number,
                           icon: Icons.date_range,
                           controller: datecontroller,
                           hinttext: 'Enter task date',
                           validate: (value) {
                             if (value!.isEmpty) {
                               return 'please enter the task date';
                             }
                           },
                           ontap: () {
                             showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime(2023))
                                 .then((value) {
                               datecontroller.text =
                                   DateFormat('dd-MM-yyy').format(value!).toString();
                             });
                           },
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                           children: [
                             Expanded(
                               child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   TextDesign(text: 'Start time'),
                                   SizedBox(height: 10,),
                                   TextFormDesign(
                                     fontsize: 14,

                                     type: TextInputType.number,
                                     suffixicon: Icon(Icons.watch_later_outlined),
                                     controller: starttimecontroller,
                                     hinttext: '11:00 Am',
                                     validate: (value) {
                                       if (value!.isEmpty) {
                                         return 'Enter start time';
                                       }
                                     },
                                     ontap: () {
                                       showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                         starttimecontroller.text=value!.format(context);
                                       });
                                     },
                                   ),
                                 ],
                               ),
                             ),SizedBox(width: 7,),

                             Expanded(
                               child:
                               Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   TextDesign(text: 'End time'),
                                   SizedBox(height: 10),
                                   TextFormDesign(
                                     fontsize: 14,

                                     type: TextInputType.number,
                                     suffixicon: Icon(Icons.watch_later_outlined),
                                     controller: endtimecontroller,
                                     hinttext: '14:00Pm',
                                     validate: (value) {
                                       if (value!.isEmpty) {
                                         return 'Enter end time';
                                       }
                                     },
                                     ontap: () {
                                       showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                         endtimecontroller.text=value!.format(context);
                                       });
                                     },
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                         SizedBox(height: 20,),
                         TextDesign(text: 'Remind'),
                         SizedBox(height: 10,),
                         TextFormDesign(

                           suffixicon: PopupMenuButton(onSelected: (value){
                             remincontroller.text=value.toString();
                           },
                             itemBuilder:(context)=>[
                             PopupMenuItem(child:Text('1 day'),value:'1 day',),
                             PopupMenuItem(child:Text('1 hour'), value: '1 hour',),
                             PopupMenuItem(child:Text('30 min'), value: '30 min',),
                             PopupMenuItem(child:Text('10 min'), value: '10 min',),
                           ] ,),
                           type: TextInputType.number,
                           icon: Icons.add_alert,
                           controller: remincontroller,
                           hinttext: '10 minutes early',


                         ),

                       ],
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Row(
                   children: [
                     Text('Chosse color',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                     Spacer(),
                    Favoritecolor(color: Colors.red,ontap:cubit.oncolorclick,tapedcolor: 'red', ),
                    SizedBox(width: 5,),
                    Favoritecolor(color: Colors.yellow,ontap:cubit.oncolorclick,tapedcolor: 'yellow',),
                     SizedBox(width: 5,),
                    Favoritecolor(color: Colors.grey,ontap:cubit.oncolorclick,tapedcolor:'grey',)
                     ,SizedBox(width: 5,),

                    Favoritecolor(color: Colors.blueAccent,ontap:cubit.oncolorclick,tapedcolor: 'blueAccent',),
                   ],
                 ),
               ),
               Spacer(),
               button(text: 'Create a task', onclick: ()async{
                 if (formkey.currentState!.validate()){
                   cubit.inserttodatabase(tittle: titlecontrolller.text, date: datecontroller.text, starttime: starttimecontroller.text, endtime: endtimecontroller.text, remind: remincontroller.text,color: cubit.selectedcolor);
                     cubit.context=context;
                   Navigator.pop(context);
                   //await cubit.service.shownotification(id: 1, title: titlecontrolller.text, body: datecontroller.text);
                   await cubit.service.showShedulenotification(id: 1, title: titlecontrolller.text, body: datecontroller.text,minutes:1);
                   //await cubit.service.shownotificationwithpayload(id: 1, title: titlecontrolller.text, body: datecontroller.text,payload: 'payload notifiaction');
                 }
               })
             ],
           ),
         );
         },

       );

  }
}
